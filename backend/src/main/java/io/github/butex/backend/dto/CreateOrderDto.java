package io.github.butex.backend.dto;

import lombok.Data;

import java.util.List;

@Data
public class CreateOrderDto {
    private List<OrderProductDTO> products;

    private Long shopId;

    private OrderAddressDTO orderAddress;
    private String name;
    private String email;
    private String phoneNumber;
    private String service;
    private Double finalPrice;
}
