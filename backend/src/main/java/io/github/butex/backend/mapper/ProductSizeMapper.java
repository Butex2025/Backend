package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.ProductSize;
import io.github.butex.backend.dto.ProductSizeDTO;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ProductSizeMapper {

    ProductSizeDTO productSizeToProductSizeDTO(ProductSize productSize);

    ProductSize productSizeDTOToProductSize(ProductSizeDTO productSizeDTO);
}