package io.github.butex.backend.dal.repository;

import io.github.butex.backend.dal.entity.ProductColor;
import io.github.butex.backend.dal.entity.ProductFabric;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProductFabricRepository extends JpaRepository<ProductFabric, Long> {
    Optional<ProductFabric> findByFabric(String fabric);
}
