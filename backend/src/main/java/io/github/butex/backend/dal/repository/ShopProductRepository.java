package io.github.butex.backend.dal.repository;

import io.github.butex.backend.dal.entity.*;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ShopProductRepository extends JpaRepository<ShopProduct, Long> {

    List<ShopProduct> findByProduct(Product productId);

    Optional<ShopProduct> findByShopAndProductAndProductSizeAndProductColor(
            Shop shop,
            Product product,
            ProductSize productSize,
            ProductColor productColor
    );
}
