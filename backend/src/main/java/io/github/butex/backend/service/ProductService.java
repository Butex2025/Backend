package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.Product;
import io.github.butex.backend.dal.repository.ProductRepository;
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
    private final ProductMapper productMapper;
    // Tworzenie nowego produktu
    public ProductDTO create(ProductDTO dto) {

        Product product = Product.builder()
                .name(dto.getName())
                .brand(dto.getBrand())
                .price(dto.getPrice())
                .image(dto.getImage())
                .build();
        return productMapper.productToProductDTO(productRepository.save(product));
    }

    // Pobieranie wszystkich produktów
    public List<ProductDTO> getAll() {
        return productRepository.findAll().stream()
                .map(product -> new ProductDTO(product.getId(), product.getName(), product.getBrand(), product.getPrice(), product.getImage()))
                .collect(Collectors.toList());
    }

    // Pobieranie produktu według ID
    public ProductDTO getById(Long id) {
        return productRepository.findById(id)
                .map(product -> new ProductDTO(product.getId(), product.getName(), product.getBrand(), product.getPrice(), product.getImage()))
                .orElse(null); // Możesz zamienić na wyjątek, jeśli wymagane
    }
}
