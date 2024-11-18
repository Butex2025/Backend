package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.ProductFabric;
import io.github.butex.backend.dal.repository.ProductFabricRepository;
import io.github.butex.backend.dto.ProductFabricDTO;
import io.github.butex.backend.exception.DataAlreadyExistException;
import io.github.butex.backend.exception.DataNotFoundException;
import io.github.butex.backend.mapper.ProductFabricMapper;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductFabricService {

    private final ProductFabricRepository productFabricRepository;
    private final ProductFabricMapper productFabricMapper;

    @Transactional
    public ProductFabric create(ProductFabricDTO dto) {
        productFabricRepository.findByFabric(dto.getFabric()).ifPresent(existing -> {
            throw new DataAlreadyExistException("Fabric " + dto.getFabric() + " already exists");
        });

        ProductFabric productFabric = ProductFabric.builder()
                .fabric(dto.getFabric())
                .build();
        return productFabricRepository.save(productFabric);
    }

    public List<ProductFabricDTO> getAll() {
        return productFabricRepository.findAll().stream()
                .map(productFabricMapper::productFabricToProductFabricDTO)
                .collect(Collectors.toList());
    }

    public ProductFabricDTO getById(Long id) {
        return productFabricRepository.findById(id)
                .map(productFabricMapper::productFabricToProductFabricDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Fabric id %s not exists", id)));
    }

    public ProductFabricDTO getByFabric(String fabric) {
        return productFabricRepository.findByFabric(fabric)
                .map(productFabricMapper::productFabricToProductFabricDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Fabric %s not exists", fabric)));
    }
}
