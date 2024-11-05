package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.ProductSize;
import io.github.butex.backend.dal.repository.ProductSizeRepository;
import io.github.butex.backend.dto.ProductSizeDTO;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.transaction.Transactional;
import lombok.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ProductSizeService {

    @Autowired
    private ProductSizeRepository productSizeRepository;

    public ProductSize create(ProductSizeDTO dto) {
        productSizeRepository.findBySize(dto.getSize()).ifPresent(existing -> {
            throw new IllegalArgumentException("Size " + dto.getSize() + " already exists");
        });

        ProductSize productSize = ProductSize.builder()
                .size(dto.getSize())
                .build();
        return productSizeRepository.save(productSize);
    }

    public List<ProductSizeDTO> getAll() {
        return productSizeRepository.findAll().stream()
                .map(size -> new ProductSizeDTO(size.getId(), size.getSize()))
                .collect(Collectors.toList());
    }

    public ProductSizeDTO getById(Long id) {
        return productSizeRepository.findById(id)
                .map(size -> new ProductSizeDTO(size.getId(), size.getSize()))
                .orElse(null); // Możesz zamienić na wyjątek, jeśli wymagane
    }

    public ProductSizeDTO getBySize(Double size) {
        return productSizeRepository.findBySize(size)
                .map(s -> new ProductSizeDTO(s.getId(), s.getSize()))
                .orElse(null); // Możesz zamienić na wyjątek, jeśli wymagane
    }
}
