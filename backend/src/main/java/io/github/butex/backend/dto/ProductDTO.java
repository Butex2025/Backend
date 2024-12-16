package io.github.butex.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTO {
    private Long id;
    private String name;
    private String brand;
    private BigDecimal price;
    private byte[] image;
    private ProductFabricDTO productFabric;
    private ProductTypeDTO productType;
}
