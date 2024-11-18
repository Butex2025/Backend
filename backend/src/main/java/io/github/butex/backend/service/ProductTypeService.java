package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.ProductType;
import io.github.butex.backend.dal.repository.ProductTypeRepository;
import io.github.butex.backend.dto.ProductTypeDTO;
import io.github.butex.backend.exception.DataAlreadyExistException;
import io.github.butex.backend.exception.DataNotFoundException;
import io.github.butex.backend.mapper.ProductTypeMapper;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductTypeService {

    private final ProductTypeRepository productTypeRepository;
    private final ProductTypeMapper productTypeMapper;
    
    public ProductType create(ProductTypeDTO dto) {
        productTypeRepository.findByType(dto.getType()).ifPresent(existing -> {
            throw new DataAlreadyExistException("Type " + dto.getType() + " already exists");
        });

        ProductType productType = ProductType.builder()
                .type(dto.getType())
                .build();
        return productTypeRepository.save(productType);
    }
    public List<ProductTypeDTO> getAll() {
        return productTypeRepository.findAll().stream()
                .map(productTypeMapper::productTypeToProductTypeDTO)
                .collect(Collectors.toList());
    }

    public ProductTypeDTO getById(Long id) {
        return productTypeRepository.findById(id)
                .map(productTypeMapper::productTypeToProductTypeDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Size id %s not exists", id)));
    }

    public ProductTypeDTO getByType(String type) {
        return productTypeRepository.findByType(type)
                .map(productTypeMapper::productTypeToProductTypeDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Size %s not exists", type)));
    }
}
