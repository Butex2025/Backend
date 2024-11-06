package io.github.butex.backend.dto;

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
public class ProductDetailsDTO {

    private Long productId;
    private String name;
    private String brand;
    private BigDecimal price;
    private ProductFabricDTO productFabric;
    private ProductTypeDTO productType;
    private byte[] image;

    private List<String> colors;
    private List<Double> sizes;
    private List<ShopDTO> shops;
}
