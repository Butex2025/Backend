package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.*;
import io.github.butex.backend.dal.repository.*;
import io.github.butex.backend.dto.ShopProductDTO;
import io.github.butex.backend.mapper.ShopProductMapper;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class ShopProductService {

    private final ShopProductRepository shopProductRepository;
    private final ShopRepository shopRepository;
    private final ProductRepository productRepository;
    private final ProductColorRepository productColorRepository;
    private final ProductSizeRepository productSizeRepository;
    private final ProductFabricRepository productFabricRepository;
    private final ProductTypeRepository productTypeRepository;
    private final ShopProductMapper shopProductMapper;

    public ShopProductDTO create(ShopProductDTO dto) {
        // Konwersja DTO na encję
        ShopProduct shopProduct = convertToEntity(dto);

        // Sprawdzenie, czy istnieje już taki rekord
        Optional<ShopProduct> existingShopProduct = findExistingShopProduct(shopProduct);

        if (existingShopProduct.isPresent()) {
            // Jeśli rekord istnieje, dodajemy ilość do istniejącego rekordu
            ShopProduct existing = existingShopProduct.get();
            existing.setQuantity(existing.getQuantity() + shopProduct.getQuantity());
            ShopProduct updatedShopProduct = shopProductRepository.save(existing);
            return shopProductMapper.shopProductToShopProductDTO(updatedShopProduct);
        } else {
            // Jeśli rekord nie istnieje, zapisujemy nowy
            ShopProduct savedShopProduct = shopProductRepository.save(shopProduct);
            return shopProductMapper.shopProductToShopProductDTO(savedShopProduct);
        }
    }

    public List<ShopProductDTO> getAll() {
        return shopProductRepository.findAll()
                .stream()
                .map(shopProductMapper::shopProductToShopProductDTO)
                .collect(Collectors.toList());
    }

    private ShopProduct convertToEntity(ShopProductDTO dto) {
        // Pobieranie encji na podstawie ID z DTO, konwersja na encję
        Shop shop = shopRepository.findById(dto.getShop().getId())
                .orElseThrow(() -> new IllegalArgumentException("Shop not found with id: " + dto.getShop().getId()));
        Product product = productRepository.findById(dto.getProduct().getId())
                .orElseThrow(() -> new IllegalArgumentException("Product not found with id: " + dto.getProduct().getId()));
        ProductColor color = productColorRepository.findById(dto.getProductColor().getId())
                .orElseThrow(() -> new IllegalArgumentException("Color not found with id: " + dto.getProductColor().getId()));
        ProductSize size = productSizeRepository.findById(dto.getProductSize().getId())
                .orElseThrow(() -> new IllegalArgumentException("Size not found with id: " + dto.getProductSize().getId()));
        ProductFabric fabric = productFabricRepository.findById(dto.getProductFabric().getId())
                .orElseThrow(() -> new IllegalArgumentException("Fabric not found with id: " + dto.getProductFabric().getId()));
        ProductType type = productTypeRepository.findById(dto.getProductType().getId())
                .orElseThrow(() -> new IllegalArgumentException("Type not found with id: " + dto.getProductType().getId()));

        return ShopProduct.builder()
                .shop(shop)
                .product(product)
                .productColor(color)
                .productSize(size)
                .productFabric(fabric)
                .productType(type)
                .quantity(dto.getQuantity())
                .build();
    }

    private Optional<ShopProduct> findExistingShopProduct(ShopProduct shopProduct) {
        // Znalezienie istniejącego rekordu na podstawie kombinacji atrybutów
        return shopProductRepository.findByShopAndProductAndProductColorAndProductSizeAndProductFabricAndProductType(
                shopProduct.getShop(),
                shopProduct.getProduct(),
                shopProduct.getProductColor(),
                shopProduct.getProductSize(),
                shopProduct.getProductFabric(),
                shopProduct.getProductType()
        );
    }
}
