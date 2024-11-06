package io.github.butex.backend.dto;

import io.github.butex.backend.dal.entity.ProductColor;
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
    private ProductSizeDTO productSize;
    private ProductColorDTO productColor;
    private Long quantity;
}
