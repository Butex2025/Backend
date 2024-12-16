package io.github.butex.backend.controller;

import io.github.butex.backend.dal.entity.Order;
import io.github.butex.backend.dto.CreateOrderDto;
import io.github.butex.backend.dto.OrderDTO;
import io.github.butex.backend.mapper.OrderMapper;
import io.github.butex.backend.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/v1/order")
@RestController
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final OrderMapper orderMapper;

    @PostMapping
    public ResponseEntity<OrderDTO> createOrder(@RequestBody CreateOrderDto orderDTO) {
        Order order = orderService.validateOrderAndSaveEntity(orderDTO);
        return ResponseEntity.ok(orderMapper.orderToOrderDTO(order));
    }
}
