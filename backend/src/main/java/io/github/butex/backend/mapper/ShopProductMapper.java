package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.ShopProduct;
import io.github.butex.backend.dto.ShopProductDTO;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring", uses = {ShopMapper.class, ProductMapper.class, ProductColorMapper.class, ProductSizeMapper.class, ProductFabricMapper.class, ProductTypeMapper.class})
public interface ShopProductMapper {

    ShopProductDTO shopProductToShopProductDTO(ShopProduct shopProduct);

    ShopProduct shopProductDTOToShopProduct(ShopProductDTO shopProductDTO);
}
