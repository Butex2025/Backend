package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.ProductFabric;
import io.github.butex.backend.dto.ProductFabricDTO;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ProductFabricMapper {

    ProductFabricDTO productFabricToProductFabricDTO(ProductFabric productFabric);

    ProductFabric productFabricDTOToProductFabric(ProductFabricDTO productFabricDTO);
}