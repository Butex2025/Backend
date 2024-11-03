package io.github.butex.backend.service;

import io.github.butex.backend.client.FurgonetkaClient;
import io.github.butex.backend.constant.DeliveryService;
import io.github.butex.backend.dal.entity.Order;
import io.github.butex.backend.dal.repository.OrderRepository;
import io.github.butex.backend.dto.OrderDTO;
import io.github.butex.backend.dto.OrderProductDTO;
import io.github.butex.backend.dto.furgonetka.FurgonetkaPackageDTO;
import io.github.butex.backend.dto.furgonetka.FurgonetkaPackagePickupDTO;
import io.github.butex.backend.dto.furgonetka.FurgonetkaPackageReceiverDTO;
import io.github.butex.backend.dto.furgonetka.FurgonetkaPackageRequestDTO;
import io.github.butex.backend.mapper.OrderMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final FurgonetkaClient furgonetkaClient;
    private final OrderMapper orderMapper;
    private final ProductService productService;

    public Order getOrder(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    public Order validateOrderAndSaveEntity(OrderDTO orderDTO) {
        furgonetkaClient.validateOrderPackage(preparePackageRequestDTO(orderDTO));
        Order order = orderMapper.orderDTOToOrder(orderDTO);

        double finalPrice = 0.0;
        for (OrderProductDTO orderProduct : orderDTO.getProducts()) {
            double partialPrice = productService.getProduct(orderProduct.getProductId()).getPrice().doubleValue() * orderProduct.getQuantity();
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
}
