package io.github.butex.backend.dto;

import io.github.butex.backend.constant.ProductColor;
import io.github.butex.backend.constant.ProductFabric;
import io.github.butex.backend.dal.entity.ProductType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.List;

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