package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.ProductSize;
import io.github.butex.backend.dal.repository.ProductSizeRepository;
import io.github.butex.backend.dto.ProductSizeDTO;
import io.github.butex.backend.exception.DataAlreadyExistException;
import io.github.butex.backend.exception.DataNotFoundException;
import io.github.butex.backend.mapper.ProductSizeMapper;
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
@RequiredArgsConstructor
public class ProductSizeService {

    private final ProductSizeRepository productSizeRepository;
    private final ProductSizeMapper productSizeMapper;

    @Transactional
    public ProductSize create(ProductSizeDTO dto) {
        productSizeRepository.findBySize(dto.getSize()).ifPresent(existing -> {
            throw new DataAlreadyExistException("Size " + dto.getSize() + " already exists");
        });

        ProductSize productSize = ProductSize.builder()
                .size(dto.getSize())
                .build();
        return productSizeRepository.save(productSize);
    }

    public List<ProductSizeDTO> getAll() {
        return productSizeRepository.findAll().stream()
                .map(productSizeMapper::productSizeToProductSizeDTO)
                .collect(Collectors.toList());
    }

    public ProductSizeDTO getById(Long id) {
        return productSizeRepository.findById(id)
                .map(productSizeMapper::productSizeToProductSizeDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Size id %s not exists", id)));
    }

    public ProductSizeDTO getBySize(Double size) {
        return productSizeRepository.findBySize(size)
                .map(productSizeMapper::productSizeToProductSizeDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Size %s not exists", size)));
    }
}
