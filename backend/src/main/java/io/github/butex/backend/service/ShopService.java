package io.github.butex.backend.service;


import io.github.butex.backend.dal.entity.Shop;
import io.github.butex.backend.dal.repository.ShopRepository;
import io.github.butex.backend.dto.ShopDTO;
import io.github.butex.backend.exception.DataAlreadyExistException;
import io.github.butex.backend.exception.DataNotFoundException;
import io.github.butex.backend.mapper.ShopMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ShopService {

    private final ShopRepository shopRepository;
    private final ShopMapper shopMapper;

    public List<ShopDTO> getAllShops() {
        return shopMapper.shopListToShopDTOLis(shopRepository.findAll());
    }

    public ShopDTO create(ShopDTO dto) {
        shopRepository.findByNameAndCityAndStreet(dto.getName(), dto.getCity(), dto.getStreet()).ifPresent(existing -> {
            throw new DataAlreadyExistException("Shop " + dto.getName() + " in " + dto.getCity() + " already exists at " + dto.getStreet());
        });

        Shop shop = Shop.builder()
                .name(dto.getName())
                .city(dto.getCity())
                .street(dto.getStreet())
                .postcode(dto.getPostcode())
                .latitude(dto.getLatitude())
                .longitude(dto.getLongitude())
                .build();
        return shopMapper.shopToShopDTO(shopRepository.save(shop));

    }

    public ShopDTO getById(Long id) {
        return shopRepository.findById(id)
                .map(shopMapper::shopToShopDTO)
                .orElseThrow(() -> new DataNotFoundException("Shop not found with id: " + id));
    }

    public List<ShopDTO> getAll() {
        return shopRepository.findAll()
                .stream()
                .map(shopMapper::shopToShopDTO)
                .collect(Collectors.toList());
    }

    public ShopDTO getByNameAndCityAndStreet(String name, String city, String street) {
        return shopRepository.findByNameAndCityAndStreet(name, city, street)
                .map(shopMapper::shopToShopDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Shop not found with name: %s, city: %s, street: %s", name, city, street)));
    }
}
