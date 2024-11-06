package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.Product;
import io.github.butex.backend.dal.entity.ProductColor;
import io.github.butex.backend.dal.entity.ProductFabric;
import io.github.butex.backend.dal.entity.ProductType;
import io.github.butex.backend.dal.repository.ProductRepository;

import io.github.butex.backend.dto.ProductColorDTO;
import io.github.butex.backend.dto.ProductDTO;
import io.github.butex.backend.mapper.ProductMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;
//    private final ProductColorService productColorService;
    private final ProductTypeService productTypeService;
    private final ProductFabricService productFabricService;
    private final ProductMapper productMapper;

    public ProductDTO create(ProductDTO dto) {

//        List<ProductColor> colors = dto.getProductColors().stream()
//                .map(productColorService::getOrCreate)
//                .collect(Collectors.toList());

        ProductFabric fabric = productFabricService.getOrCreate(dto.getProductFabric());
        ProductType type = productTypeService.getOrCreate(dto.getProductType());

        Product product = Product.builder()
                .name(dto.getName())
                .brand(dto.getBrand())
                .price(dto.getPrice())
                .image(dto.getImage())
//                .productColors(colors)
                .productFabric(fabric)
                .productType(type)
                .build();

        return productMapper.productToProductDTO(productRepository.save(product));
    }

    // Pobieranie wszystkich produktów
    public List<ProductDTO> getAll() {
        return productRepository.findAll().stream()
                .map(productMapper::productToProductDTO)
                .collect(Collectors.toList());
    }

    // Pobieranie produktu według ID
    public ProductDTO getById(Long id) {
        return productRepository.findById(id)
                .map(productMapper::productToProductDTO)
                .orElse(null); // Można zwrócić wyjątek zamiast null, jeśli wymagane
    }
}
