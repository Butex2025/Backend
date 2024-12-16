package io.github.butex.backend.dal.repository;

import io.github.butex.backend.dal.entity.ProductColor;
import io.github.butex.backend.dal.entity.Shop;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ShopRepository extends JpaRepository<Shop, Long> {
    Optional<Shop> findByNameAndCityAndStreet(String name, String city, String street);

}
