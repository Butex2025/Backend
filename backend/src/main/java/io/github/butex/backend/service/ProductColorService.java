package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.ProductColor;
import io.github.butex.backend.dal.repository.ProductColorRepository;
import io.github.butex.backend.dto.ProductColorDTO;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ProductColorService {

    @Autowired
    private ProductColorRepository productColorRepository;

    public ProductColor getOrCreate(ProductColorDTO dto) {
        return productColorRepository.findByColor(dto.getColor())
                .orElseGet(() -> create(dto));
    }

    public ProductColor create(ProductColorDTO dto) {
        productColorRepository.findByColor(dto.getColor()).ifPresent(existing -> {
            throw new IllegalArgumentException("Color " + dto.getColor() + " already exists");
        });

        ProductColor productColor = ProductColor.builder()
                .color(dto.getColor())
                .build();
        return productColorRepository.save(productColor);
    }

    public List<ProductColorDTO> getAll() {
        return productColorRepository.findAll().stream()
                .map(color -> new ProductColorDTO(color.getId(), color.getColor()))
                .collect(Collectors.toList());
    }

    public ProductColorDTO getById(Long id) {
        return productColorRepository.findById(id)
                .map(color -> new ProductColorDTO(color.getId(), color.getColor()))
                .orElse(null); // Możesz zamienić na wyjątek, jeśli wymagane
    }

    public ProductColorDTO getByColor(String color) {
        return productColorRepository.findByColor(color)
                .map(c -> new ProductColorDTO(c.getId(), c.getColor()))
                .orElse(null); // Możesz zamienić na wyjątek, jeśli wymagane
    }

}
