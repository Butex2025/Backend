package io.github.butex.backend.schedule;

import io.github.butex.backend.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.concurrent.TimeUnit;

@Component
@RequiredArgsConstructor
public class OrderCheckScheduler {

    private final OrderService orderService;

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @Scheduled(fixedDelay = 30, timeUnit = TimeUnit.SECONDS)
    public void checkPaymentStatus() {
        orderService.checkPaymentStatus();
    }


}
