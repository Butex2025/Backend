package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.ProductColor;
import io.github.butex.backend.dto.ProductColorDTO;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ProductColorMapper {

    ProductColorDTO productColorToProductColorDTO(ProductColor productColor);

    ProductColor productColorDTOToProductColor(ProductColorDTO productColorDTO);
}
