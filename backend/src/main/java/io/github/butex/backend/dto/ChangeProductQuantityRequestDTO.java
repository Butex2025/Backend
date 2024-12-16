package io.github.butex.backend.dto;

import lombok.Data;

@Data
public class ChangeProductQuantityRequestDTO {

    private Long productId;
    private Long quantity;
}
