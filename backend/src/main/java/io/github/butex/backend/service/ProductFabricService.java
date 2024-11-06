package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.ProductFabric;
import io.github.butex.backend.dal.repository.ProductFabricRepository;
import io.github.butex.backend.dto.ProductFabricDTO;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ProductFabricService {

    @Autowired
    private ProductFabricRepository productFabricRepository;

    public ProductFabric getOrCreate(ProductFabricDTO dto) {
        return productFabricRepository.findByFabric(dto.getFabric())
                .orElseGet(() -> create(dto));
    }

    public ProductFabric create(ProductFabricDTO dto) {
        productFabricRepository.findByFabric(dto.getFabric()).ifPresent(existing -> {
            throw new IllegalArgumentException("Fabric " + dto.getFabric() + " already exists");
        });

        ProductFabric productFabric = ProductFabric.builder()
                .fabric(dto.getFabric())
                .build();
        return productFabricRepository.save(productFabric);
    }

    public List<ProductFabricDTO> getAll() {
        return productFabricRepository.findAll().stream()
                .map(fabric -> new ProductFabricDTO(fabric.getId(), fabric.getFabric()))
                .collect(Collectors.toList());
    }

    public ProductFabricDTO getById(Long id) {
        return productFabricRepository.findById(id)
                .map(fabric -> new ProductFabricDTO(fabric.getId(), fabric.getFabric()))
                .orElse(null); // Możesz zamienić na wyjątek, jeśli wymagane
    }

    public ProductFabricDTO getByFabric(String fabric) {
        return productFabricRepository.findByFabric(fabric)
                .map(f -> new ProductFabricDTO(f.getId(), f.getFabric()))
                .orElse(null); // Możesz zamienić na wyjątek, jeśli wymagane
    }
}
