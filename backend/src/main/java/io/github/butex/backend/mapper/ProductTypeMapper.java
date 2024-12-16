package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.ProductType;
import io.github.butex.backend.dto.ProductTypeDTO;
import org.mapstruct.Mapper;
@Mapper(componentModel = "spring")
public interface ProductTypeMapper {

    ProductTypeDTO productTypeToProductTypeDTO(ProductType productType);

    ProductType productTypeDTOToProductType(ProductTypeDTO productTypeDTO);
}
