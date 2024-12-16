package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.Payment;
import io.github.butex.backend.dal.repository.PaymentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PaymentServiceHelper {

    private final PaymentRepository paymentRepository;

    public Payment getPaymentByOrderId(Long orderId) {
        return paymentRepository.findByOrderId(orderId).orElse(null);
    }
}
