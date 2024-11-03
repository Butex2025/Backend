package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.Product;
import io.github.butex.backend.dto.ProductDTO;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface ProductMapper {

    List<ProductDTO> productListToProductDtoList(List<Product> productList);

    ProductDTO productToProductDTO(Product product);
}
