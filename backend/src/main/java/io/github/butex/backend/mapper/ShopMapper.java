package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.Shop;
import io.github.butex.backend.dto.ShopDTO;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ShopMapper {

    ShopDTO shopToShopDTO(Shop shop);

    Shop shopDTOToShop(ShopDTO shopDTO);
}
