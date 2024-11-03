package io.github.butex.backend.dto;

import lombok.Data;

@Data
public class OrderProductDTO {
    private Long id;
    private Long productId;
    private int quantity;
}
