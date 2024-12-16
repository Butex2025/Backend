package io.github.butex.backend.dal.repository;

import io.github.butex.backend.dal.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    Optional<Product> findByProductTypeAndProductFabric(final ProductType productType, final ProductFabric productFabric);

}
