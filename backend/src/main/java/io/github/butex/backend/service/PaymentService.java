package io.github.butex.backend.service;

import io.github.butex.backend.client.PaynowClient;
import io.github.butex.backend.dal.entity.Order;
import io.github.butex.backend.dal.entity.Payment;
import io.github.butex.backend.dal.repository.PaymentRepository;
import io.github.butex.backend.dto.paynow.PaynowBuyerDTO;
import io.github.butex.backend.dto.paynow.PaynowRequestDTO;
import io.github.butex.backend.dto.paynow.PaynowResponseDTO;
import io.github.butex.backend.dto.paynow.PaynowStatusResponseDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private static final String CONFIRMED_STATUS = "CONFIRMED";

    private final OrderService orderService;
    private final PaynowClient paynowClient;
    private final PaymentRepository paymentRepository;

    public PaynowResponseDTO createPayment(Long orderId) {
        Order order = orderService.getOrder(orderId);
        PaynowRequestDTO paynowRequestDTO = buildPaynowRequest(order);

        PaynowResponseDTO paynowResponseDTO = paynowClient.createPayment(paynowRequestDTO);
        savePayment(preparePaymentEntity(orderId, paynowResponseDTO));
        return paynowResponseDTO;
    }

    public void savePayment(Payment payment) {
        paymentRepository.save(payment);
    }

    public void validatePaymentStatuses() {
        List<Payment> notConifrmedPayments = paymentRepository.findAllByStatusIsNot(CONFIRMED_STATUS);

        for (Payment notConifrmedPayment : notConifrmedPayments) {
            PaynowStatusResponseDTO paymentStatus = paynowClient.getPaymentStatus(notConifrmedPayment.getPaymentId());

            if (!paymentStatus.getStatus().equalsIgnoreCase(notConifrmedPayment.getStatus())) {
                notConifrmedPayment.setStatus(paymentStatus.getStatus());
                paymentRepository.save(notConifrmedPayment);

                if (paymentStatus.getStatus().equalsIgnoreCase(CONFIRMED_STATUS)) {
                    orderService.createOrder(notConifrmedPayment.getOrderId());
                }
            }
        }
    }

    private Payment preparePaymentEntity(Long orderId, PaynowResponseDTO paynowResponseDTO) {
        Payment payment = new Payment();
        payment.setPaymentId(paynowResponseDTO.getPaymentId());
        payment.setOrderId(orderId);
        payment.setStatus(paynowResponseDTO.getStatus());
        payment.setCreateDate(LocalDateTime.now());
        return payment;
    }

    private static PaynowRequestDTO buildPaynowRequest(Order order) {
        return PaynowRequestDTO.builder()
                .amount((int) ((order.getFinalPrice() * 100)))
                .description("Opłata za zamówienie " + order.getId())
                .currency("PLN")
                .externalId(String.valueOf(order.getId()))
                .buyer(PaynowBuyerDTO.builder()
                        .email(order.getEmail())
                        .firstName(order.getName().split(" ")[0])
                        .lastName(order.getName().split(" ")[1])
                        .build())
                .build();
    }
}