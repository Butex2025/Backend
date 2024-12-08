package io.github.butex.backend.controller;

import io.github.butex.backend.dal.entity.Order;
import io.github.butex.backend.dal.entity.User;
import io.github.butex.backend.exception.DataBadRequestException;
import io.github.butex.backend.mapper.OrderMapper;
import io.github.butex.backend.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Log4j2
@RestController
@RequestMapping("/api/v1/notification")
@RequiredArgsConstructor
public class NotificationController {


    private final OrderService orderService;
    private final OrderMapper orderMapper;

    @Operation(
            summary = "Get all info about user orders status",
            description = "Endpoint to get not resolved orders from user. " +
                    "Its important to send request with authentication header, based on jwt.sum === user email, we get info about orders"
    )
    @GetMapping
    public ResponseEntity<?> getOrdersStatus(@Parameter(hidden = true) Authentication authentication) {
        String email = ((UserDetails) authentication.getPrincipal()).getUsername();
        if(email.isEmpty()){
            throw new DataBadRequestException("User has to be authenticated");
        }
        List<Order> orders = orderService.getUserNotConfirmedOrders(email);

        return ResponseEntity.ok(orderMapper.ordersToNotificationOrderDTOs(orders));
    }

}
