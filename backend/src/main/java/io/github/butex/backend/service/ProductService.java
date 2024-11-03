package io.github.butex.backend.service;

import io.github.butex.backend.dal.repository.ProductRepository;
import io.github.butex.backend.dto.ProductDTO;
import io.github.butex.backend.mapper.ProductMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;
    private final ProductMapper productMapper;

    public List<ProductDTO> getAllProducts() {
        return productMapper.productListToProductDtoList(productRepository.findAll());
    }

    public ProductDTO getProduct(Long id) {
        return productRepository.findById(id).map(productMapper::productToProductDTO).orElse(null);
    }
}
