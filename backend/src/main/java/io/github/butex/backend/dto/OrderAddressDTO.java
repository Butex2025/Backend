package io.github.butex.backend.dto;

import lombok.Data;

@Data
public class OrderAddressDTO {
    private String street;
    private String postcode;
    private String city;
}
