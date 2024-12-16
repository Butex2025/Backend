package io.github.butex.backend.schedule;

import io.github.butex.backend.service.PaymentService;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.concurrent.TimeUnit;

@EnableScheduling
@Component
@RequiredArgsConstructor
public class PaymentCheckScheduler {

    private final PaymentService paymentService;

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @Scheduled(fixedDelay = 30, timeUnit = TimeUnit.SECONDS)
    public void checkPaymentStatuses() {
        paymentService.validatePaymentStatuses();
    }
}
