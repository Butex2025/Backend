package io.github.butex.backend.dto;

import io.github.butex.backend.dal.entity.OrderStatus;
import lombok.Data;

import java.util.List;

@Data
public class NotificationOrderDTO {

    private Long id;
    private List<OrderProductDTO> products;
    private String email;
    private String phoneNumber;
    private String service;
    private String status;

}
