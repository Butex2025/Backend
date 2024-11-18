package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.*;
import io.github.butex.backend.dal.repository.*;
import io.github.butex.backend.dto.ProductDetailsDTO;
import io.github.butex.backend.dto.ShopDTO;
import io.github.butex.backend.dto.ShopProductDTO;
import io.github.butex.backend.exception.DataBadRequestException;
import io.github.butex.backend.exception.DataNotFoundException;
import io.github.butex.backend.mapper.ProductFabricMapper;
import io.github.butex.backend.mapper.ProductTypeMapper;
import io.github.butex.backend.mapper.ShopMapper;
import io.github.butex.backend.mapper.ShopProductMapper;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ShopProductService {

    private final ShopProductRepository shopProductRepository;
    private final ShopRepository shopRepository;
    private final ProductRepository productRepository;
    private final ProductSizeRepository productSizeRepository;
    private final ProductColorRepository productColorRepository;

    private final ShopProductMapper shopProductMapper;
    private final ProductFabricMapper productFabricMapper;
    private final ProductTypeMapper productTypeMapper;
    private final ShopMapper shopMapper;

    @Transactional
    public ShopProductDTO create(ShopProductDTO dto) {
        ShopProduct shopProduct = convertToEntity(dto);

        Optional<ShopProduct> existingShopProduct = findExistingShopProduct(shopProduct);

        if (existingShopProduct.isPresent()) {
            ShopProduct existing = existingShopProduct.get();
            existing.setQuantity(existing.getQuantity() + shopProduct.getQuantity());
            ShopProduct updatedShopProduct = shopProductRepository.save(existing);
            return shopProductMapper.shopProductToShopProductDTO(updatedShopProduct);
        } else {
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
        Shop shop = shopRepository.findById(dto.getShop().getId())
                .orElseThrow(() -> new DataBadRequestException("Shop not found with id: " + dto.getShop().getId()));
        Product product = productRepository.findById(dto.getProduct().getId())
                .orElseThrow(() -> new DataBadRequestException("Product not found with id: " + dto.getProduct().getId()));
        ProductSize size = productSizeRepository.findById(dto.getProductSize().getId())
                .orElseThrow(() -> new DataBadRequestException("Size not found with id: " + dto.getProductSize().getId()));
        ProductColor color = productColorRepository.findById(dto.getProductColor().getId())
                .orElseThrow(() -> new DataBadRequestException("Color not found with id: " + dto.getProductColor().getId()));

        return ShopProduct.builder()
                .shop(shop)
                .product(product)
                .productSize(size)
                .productColor(color)
                .quantity(dto.getQuantity())
                .build();
    }

    private Optional<ShopProduct> findExistingShopProduct(ShopProduct shopProduct) {
        return shopProductRepository.findByShopAndProductAndProductSizeAndProductColor(
                shopProduct.getShop(),
                shopProduct.getProduct(),
                shopProduct.getProductSize(),
                shopProduct.getProductColor()
        );
    }

    public ProductDetailsDTO getProductDetailsById(Long productId) {

        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new DataBadRequestException(String.format("Product %s not found", productId)));

        List<ShopProduct> shopProducts = shopProductRepository.findByProduct(product);

        if (shopProducts.isEmpty()) {
            throw new DataNotFoundException("Product with ID " + productId + " not found");
        }

        List<String> colors = shopProducts.stream()
                .map(sp -> sp.getProductColor().getColor())
                .distinct()
                .collect(Collectors.toList());

        List<Double> sizes = shopProducts.stream()
                .map(sp -> sp.getProductSize().getSize())
                .distinct()
                .collect(Collectors.toList());

        List<ShopDTO> shops = shopProducts.stream()
                .map(ShopProduct::getShop)
                .distinct()
                .map(shopMapper::shopToShopDTO)
                .collect(Collectors.toList());

        return ProductDetailsDTO.builder()
                .productId(product.getId())
                .name(product.getName())
                .brand(product.getBrand())
                .price(product.getPrice())
                .productFabric(productFabricMapper.productFabricToProductFabricDTO(product.getProductFabric()))
                .productType(productTypeMapper.productTypeToProductTypeDTO(product.getProductType()))
                .image(product.getImage())
                .colors(colors)
                .sizes(sizes)
                .shops(shops)
                .build();
    }

}
