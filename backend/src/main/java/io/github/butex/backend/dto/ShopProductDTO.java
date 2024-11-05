package io.github.butex.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ShopProductDTO {
    private Long id;
    private ShopDTO shop;
    private ProductDTO product;
    private ProductColorDTO productColor;
    private ProductSizeDTO productSize;
    private ProductFabricDTO productFabric;
    private ProductTypeDTO productType;
    private Long quantity;
}
