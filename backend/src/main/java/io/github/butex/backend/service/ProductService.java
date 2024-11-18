package io.github.butex.backend.service;

import io.github.butex.backend.dal.entity.Product;
import io.github.butex.backend.dal.entity.ProductColor;
import io.github.butex.backend.dal.entity.ProductFabric;
import io.github.butex.backend.dal.entity.ProductType;
import io.github.butex.backend.dal.repository.ProductFabricRepository;
import io.github.butex.backend.dal.repository.ProductRepository;

import io.github.butex.backend.dal.repository.ProductTypeRepository;
import io.github.butex.backend.dto.ProductColorDTO;
import io.github.butex.backend.dto.ProductDTO;
import io.github.butex.backend.exception.DataAlreadyExistException;
import io.github.butex.backend.exception.DataBadRequestException;
import io.github.butex.backend.exception.DataNotFoundException;
import io.github.butex.backend.mapper.ProductMapper;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.coyote.BadRequestException;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Log4j2
public class ProductService {

    private final ProductRepository productRepository;
    private final ProductTypeRepository productTypeRepository;
    private final ProductFabricRepository productFabricRepository;
    private final ProductMapper productMapper;

    @Transactional
    public ProductDTO create(ProductDTO dto) {
        ProductFabric productFabric = productFabricRepository.findByFabric(dto.getProductFabric().getFabric())
                .orElseThrow(() -> new DataBadRequestException(String.format("Fabric %s not found", dto.getProductFabric().getFabric())));
        ProductType productType = productTypeRepository.findByType(dto.getProductType().getType())
                .orElseThrow(() -> new DataBadRequestException(String.format("Type %s not found", dto.getProductType().getType())));

        if(productRepository.findByProductTypeAndProductFabric(productType, productFabric).isEmpty()) {
            throw new DataAlreadyExistException("Product already exist");
        }

        Product product = Product.builder()
                .name(dto.getName())
                .brand(dto.getBrand())
                .price(dto.getPrice())
                .image(dto.getImage())
                .productFabric(productFabric)
                .productType(productType)
                .build();

        return productMapper.productToProductDTO(productRepository.save(product));
    }

    public List<ProductDTO> getAll() {
        return productRepository.findAll().stream()
                .map(productMapper::productToProductDTO)
                .collect(Collectors.toList());
    }

    public ProductDTO getById(Long id) {
        return productRepository.findById(id)
                .map(productMapper::productToProductDTO)
                .orElseThrow(() -> new DataNotFoundException(String.format("Product %s not exists", id)));
    }
}
