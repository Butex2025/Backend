package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.Shop;
import io.github.butex.backend.dto.ShopDTO;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface ShopMapper {

    ShopDTO shopToShopDTO(Shop shop);


    List<ShopDTO> shopListToShopDTOLis(List<Shop> shops);

    Shop shopDTOToShop(ShopDTO shopDTO);
}
