package io.github.butex.backend.service;




import io.github.butex.backend.dal.entity.Shop;
import io.github.butex.backend.dal.repository.ShopRepository;
import io.github.butex.backend.dto.ShopDTO;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ShopService {
    @Autowired
    private ShopRepository shopRepository;

    public Shop create(ShopDTO dto) {
        shopRepository.findByNameAndCityAndStreet(dto.getName(), dto.getCity(), dto.getStreet()).ifPresent(existing -> {
            throw new IllegalArgumentException("Shop " + dto.getName() + " in " + dto.getCity() + " already exists at " + dto.getStreet());
        });


        Shop shop = Shop.builder()
                .name(dto.getName())
                .city(dto.getCity())
                .street(dto.getStreet())
                .postcode(dto.getPostcode())
                .latitude(dto.getLatitude())
                .longitude(dto.getLongitude())
                .build();
        return shopRepository.save(shop);

    }

    // Znajdowanie sklepu według ID
    // Znajdowanie sklepu według ID
    public ShopDTO getById(Long id) {
        return shopRepository.findById(id)
                .map(this::convertToDTO)
                .orElseThrow(() -> new IllegalArgumentException("Shop not found with id: " + id));
    }

    // Pobieranie wszystkich sklepów
    public List<ShopDTO> getAll() {
        return shopRepository.findAll()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    // Znajdowanie sklepu według nazwy, miasta i ulicy
    public ShopDTO getByNameAndCityAndStreet(String name, String city, String street) {
        return shopRepository.findByNameAndCityAndStreet(name, city, street)
                .map(this::convertToDTO)
                .orElseThrow(() -> new IllegalArgumentException("Shop not found with name: " + name + ", city: " + city + ", street: " + street));
    }

    // Metoda pomocnicza do konwersji encji na DTO
    private ShopDTO convertToDTO(Shop shop) {
        return new ShopDTO(
                shop.getId(),
                shop.getName(),
                shop.getCity(),
                shop.getStreet(),
                shop.getPostcode(),
                shop.getLatitude(),
                shop.getLongitude()
        );
    }

}
