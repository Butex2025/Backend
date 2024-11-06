package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.ProductType;
import io.github.butex.backend.dal.repository.ProductTypeRepository;
import io.github.butex.backend.dto.ProductTypeDTO;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ProductTypeService {

    @Autowired
    private ProductTypeRepository productTypeRepository;

    public ProductType getOrCreate(ProductTypeDTO dto) {
        return productTypeRepository.findByType(dto.getType())
                .orElseGet(() -> create(dto));
    }

    
    public ProductType create(ProductTypeDTO dto) {
        productTypeRepository.findByType(dto.getType()).ifPresent(existing -> {
            throw new IllegalArgumentException("Type " + dto.getType() + " already exists");
        });

        ProductType productType = ProductType.builder()
                .type(dto.getType())
                .build();
        return productTypeRepository.save(productType);
    }
    public List<ProductTypeDTO> getAll() {
        return productTypeRepository.findAll().stream()
                .map(type -> new ProductTypeDTO(type.getId(), type.getType()))
                .collect(Collectors.toList());
    }

    public ProductTypeDTO getById(Long id) {
        return productTypeRepository.findById(id)
                .map(type -> new ProductTypeDTO(type.getId(), type.getType()))
                .orElse(null); // Możesz zamienić na wyjątek, jeśli wymagane
    }

    public ProductTypeDTO getByType(String type) {
        return productTypeRepository.findByType(type)
                .map(t -> new ProductTypeDTO(t.getId(), t.getType()))
                .orElse(null); // Możesz zamienić na wyjątek, jeśli wymagane
    }
}
