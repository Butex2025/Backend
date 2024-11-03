package io.github.butex.backend.dal.entity;

import io.github.butex.backend.constant.ProductColor;
import io.github.butex.backend.constant.ProductFabric;
import io.github.butex.backend.constant.ProductType;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String brand;
    private BigDecimal price;

    @Lob
    private byte[] image;

    @ElementCollection
    private List<Double> sizes;

    @Enumerated(EnumType.STRING)
    @ElementCollection(targetClass = ProductColor.class)
    private List<ProductColor> colors;

    @Enumerated(EnumType.STRING)
    private ProductFabric fabric;

    @Enumerated(EnumType.STRING)
    private ProductType productType;
}
