package io.github.butex.backend.service;

import io.github.butex.backend.client.FurgonetkaClient;
import io.github.butex.backend.constant.DeliveryService;
import io.github.butex.backend.dal.entity.Order;
import io.github.butex.backend.dal.entity.OrderStatus;
import io.github.butex.backend.dal.entity.Payment;
import io.github.butex.backend.dal.entity.Shop;
import io.github.butex.backend.dal.repository.OrderRepository;
import io.github.butex.backend.dto.CreateOrderDto;
import io.github.butex.backend.dto.OrderDTO;
import io.github.butex.backend.dto.OrderProductDTO;
import io.github.butex.backend.dto.ShopDTO;
import io.github.butex.backend.dto.furgonetka.FurgonetkaPackageDTO;
import io.github.butex.backend.dto.furgonetka.FurgonetkaPackagePickupDTO;
import io.github.butex.backend.dto.furgonetka.FurgonetkaPackageReceiverDTO;
import io.github.butex.backend.dto.furgonetka.FurgonetkaPackageRequestDTO;
import io.github.butex.backend.mapper.OrderMapper;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

    private static final String CONFIRMED_STATUS = "CONFIRMED";

    private final OrderRepository orderRepository;
    private final FurgonetkaClient furgonetkaClient;
    private final OrderMapper orderMapper;
    private final ProductService productService;
    private final PaymentServiceHelper paymentServiceHelper;
    private final ShopService shopService;

    public Order getOrder(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    public Order validateOrderAndSaveEntity(CreateOrderDto createOrderDto) {
        furgonetkaClient.validateOrderPackage(preparePackageRequestDTO(createOrderDto));
        Order order = new Order();
        order.setProducts(orderMapper.orderProductDTOToOrderProduct(createOrderDto.getProducts()));
        order.setName(createOrderDto.getName());
        order.setEmail(createOrderDto.getEmail());
        order.setPhoneNumber(createOrderDto.getPhoneNumber());
        order.setService(createOrderDto.getService());

        if(createOrderDto.getOrderAddress() != null) {
            order.setStreet(createOrderDto.getOrderAddress().getStreet());
            order.setPostcode(createOrderDto.getOrderAddress().getPostcode());
            order.setCity(createOrderDto.getOrderAddress().getCity());
        } else {
            ShopDTO shop = shopService.getById(createOrderDto.getShopId());
            order.setStreet(shop.getStreet());
            order.setPostcode(shop.getPostcode());
            order.setCity(shop.getCity());
        }

        double finalPrice = 0.0;
        for (OrderProductDTO orderProduct : createOrderDto.getProducts()) {
            double partialPrice = productService.getById(orderProduct.getProductId()).getPrice().doubleValue() * orderProduct.getQuantity();
            finalPrice += partialPrice;
        }

        order.setFinalPrice(finalPrice);
        return orderRepository.save(order);
    }

    public Order createOrder(Long orderId) {
        Order order = orderRepository.findById(orderId).orElse(null);
        if (order == null) {
            return null;
        }

        OrderDTO orderDTO = orderMapper.orderToOrderDTO(order);
        furgonetkaClient.createOrderPackage(preparePackageRequestDTO(orderDTO));
        return order;
    }

    private FurgonetkaPackageRequestDTO preparePackageRequestDTO(OrderDTO orderDTO) {
        FurgonetkaPackagePickupDTO packagePickupDTO = FurgonetkaPackagePickupDTO.builder()
                .street("Przykładowa 5")
                .postcode("95-100")
                .city("Zgierz")
                .name("Jan Kowalski")
                .company("Butex Sp. z o.o.")
                .email("kontakt@butex.pl")
                .phone("353874919")
                .countryCode("PL")
                .build();

        FurgonetkaPackageReceiverDTO packageReceiverDTO = FurgonetkaPackageReceiverDTO.builder()
                .street(orderDTO.getStreet())
                .postcode(orderDTO.getPostcode())
                .city(orderDTO.getCity())
                .name(orderDTO.getName())
                .company("")
                .email(orderDTO.getEmail())
                .phone(orderDTO.getPhoneNumber())
                .countryCode("PL")
                .build();

        List<FurgonetkaPackageDTO> furgonetkaPackageDTOList = new ArrayList<>();

        orderDTO.getProducts().forEach(orderProductDTO -> {
            for (int i = 0; i < orderProductDTO.getQuantity(); i++) {
                FurgonetkaPackageDTO packageDTO = FurgonetkaPackageDTO.builder()
                        .width(30)
                        .depth(50)
                        .height(20)
                        .weight(0.5f)
                        .description("Buty")
                        .build();
                furgonetkaPackageDTOList.add(packageDTO);
            }
        });

        return FurgonetkaPackageRequestDTO.builder()
                .service_id(DeliveryService.fromName(orderDTO.getService()))
                .pickup(packagePickupDTO)
                .receiver(packageReceiverDTO)
                .parcels(furgonetkaPackageDTOList)
                .type("package")
                .build();
    }

    private FurgonetkaPackageRequestDTO preparePackageRequestDTO(CreateOrderDto orderDTO) {
        FurgonetkaPackagePickupDTO packagePickupDTO = FurgonetkaPackagePickupDTO.builder()
                .street("Przykładowa 5")
                .postcode("95-100")
                .city("Zgierz")
                .name("Jan Kowalski")
                .company("Butex Sp. z o.o.")
                .email("kontakt@butex.pl")
                .phone("353874919")
                .countryCode("PL")
                .build();

        FurgonetkaPackageReceiverDTO packageReceiverDTO = null;
        if(orderDTO.getOrderAddress() != null) {
            packageReceiverDTO = FurgonetkaPackageReceiverDTO.builder()
                    .street(orderDTO.getOrderAddress().getStreet())
                    .postcode(orderDTO.getOrderAddress().getPostcode())
                    .city(orderDTO.getOrderAddress().getCity())
                    .name(orderDTO.getName())
                    .company("")
                    .email(orderDTO.getEmail())
                    .phone(orderDTO.getPhoneNumber())
                    .countryCode("PL")
                    .build();
        } else {
            ShopDTO shop = shopService.getById(orderDTO.getShopId());

            packageReceiverDTO = FurgonetkaPackageReceiverDTO.builder()
                    .street(shop.getStreet())
                    .postcode(shop.getPostcode())
                    .city(shop.getCity())
                    .name(orderDTO.getName())
                    .company("")
                    .email(orderDTO.getEmail())
                    .phone(orderDTO.getPhoneNumber())
                    .countryCode("PL")
                    .build();
        }


        List<FurgonetkaPackageDTO> furgonetkaPackageDTOList = new ArrayList<>();

        orderDTO.getProducts().forEach(orderProductDTO -> {
            for (int i = 0; i < orderProductDTO.getQuantity(); i++) {
                FurgonetkaPackageDTO packageDTO = FurgonetkaPackageDTO.builder()
                        .width(30)
                        .depth(50)
                        .height(20)
                        .weight(0.5f)
                        .description("Buty")
                        .build();
                furgonetkaPackageDTOList.add(packageDTO);
            }
        });

        return FurgonetkaPackageRequestDTO.builder()
                .service_id(DeliveryService.fromName(orderDTO.getService()))
                .pickup(packagePickupDTO)
                .receiver(packageReceiverDTO)
                .parcels(furgonetkaPackageDTOList)
                .type("package")
                .build();
    }


    public List<Order> getAllOrder() {
        return orderRepository.findAll();
    }

    public List<Order> getAllOrdersWithStatus(final Collection<OrderStatus> orderStatus) {
        return orderRepository.findAllByStatusIn(orderStatus);
    }

    public List<Order> getAllUserOrdersNotWithStatus(final String email, final Collection<OrderStatus> orderStatus) {
        return orderRepository.findAllByEmailAndStatusNotIn(email, orderStatus);
    }

    @Transactional
    public Order changeOrderStatus(final Long orderProductId, OrderStatus status) {
        Order orderProduct = getOrder(orderProductId);
        if (orderProductId == null) {
            return null;
        }
        orderProduct.setStatus(status);
        return orderRepository.save(orderProduct);
    }

    @Transactional
    public void checkPaymentStatus() {
        List<Order> orderProductList = getAllOrdersWithStatus(
                Arrays.asList(OrderStatus.PROCESSING, OrderStatus.PAYMENT_PENDING)
        );

        for (Order order : orderProductList) {
            switch (order.getStatus()) {
                case PROCESSING -> {
                    //find payment
                    Payment payment = paymentServiceHelper.getPaymentByOrderId(order.getId());
                    if (payment != null) {
                        changeOrderStatus(order.getId(), OrderStatus.PAYMENT_PENDING);
                    }
                }
                case PAYMENT_PENDING -> {
                    Payment payment = paymentServiceHelper.getPaymentByOrderId(order.getId());
                    if (payment != null && payment.getStatus().equals(CONFIRMED_STATUS)) {
                        changeOrderStatus(order.getId(), OrderStatus.PAYMENT_COMPLETED);
                        //ready to do staff
                    }
                }
            }
        }

    }

    public List<Order> getUserNotConfirmedOrders(String email) {
        return getAllUserOrdersNotWithStatus(
                email,
                Arrays.asList(OrderStatus.DELIVERED, OrderStatus.DELIVERY_FAILED, OrderStatus.CANCELED, OrderStatus.RETURNED)
        );
    }
}
