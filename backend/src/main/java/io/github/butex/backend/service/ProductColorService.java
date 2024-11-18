package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.ProductColor;
import io.github.butex.backend.dal.repository.ProductColorRepository;
import io.github.butex.backend.dto.ProductColorDTO;
import io.github.butex.backend.exception.DataAlreadyExistException;
import io.github.butex.backend.exception.DataNotFoundException;
import io.github.butex.backend.mapper.ProductColorMapper;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductColorService {

    private final ProductColorRepository productColorRepository;
    private final ProductColorMapper productColorMapper;

    @Transactional
    public ProductColor create(ProductColorDTO dto) {
        productColorRepository.findByColor(dto.getColor()).ifPresent(existing -> {
            throw new DataAlreadyExistException("Color " + dto.getColor() + " already exists");
        });

        ProductColor productColor = ProductColor.builder()
                .color(dto.getColor())
                .build();
        return productColorRepository.save(productColor);
    }

    public List<ProductColorDTO> getAll() {
        return productColorRepository.findAll().stream()
                .map(productColorMapper::productColorToProductColorDTO)
                .collect(Collectors.toList());
    }

    public ProductColorDTO getById(Long id) {
        return productColorRepository.findById(id)
                .map(productColorMapper::productColorToProductColorDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Color id %s not exists", id)));
    }

    public ProductColorDTO getByColor(String color) {
        return productColorRepository.findByColor(color)
                .map(productColorMapper::productColorToProductColorDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Color %s not exists", color)));
    }

}
