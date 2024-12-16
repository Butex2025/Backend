package io.github.butex.backend.dto;

import lombok.Data;

import java.util.List;

@Data
public class OrderDTO {

    private Long id;
    private List<OrderProductDTO> products;
    private String name;
    private String street;
    private String postcode;
    private String city;
    private String email;
    private String phoneNumber;
    private String service;
    private Double finalPrice;
}
