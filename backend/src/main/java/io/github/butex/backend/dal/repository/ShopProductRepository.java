package io.github.butex.backend.dal.repository;

import io.github.butex.backend.dal.entity.*;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ShopProductRepository extends JpaRepository<ShopProduct, Long> {
    boolean existsByShopAndProductAndProductColorAndProductSizeAndProductFabricAndProductType(
            Shop shop,
            Product product,
            ProductColor productColor,
            ProductSize productSize,
            ProductFabric productFabric,
            ProductType productType
    );
}
