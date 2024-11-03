package io.github.butex.backend.dto;

import io.github.butex.backend.constant.ProductColor;
import io.github.butex.backend.constant.ProductFabric;
import io.github.butex.backend.constant.ProductType;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class ProductDTO {

    private Long id;
    private ProductType productType;
    private String name;
    private String brand;
    private BigDecimal price;
    private List<Double> sizes;
    private List<ProductColor> colors;
    private ProductFabric fabric;
    private byte[] image;
}
