package io.github.butex.backend.dal.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
@Table(name = "shop_product", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"shop_id", "product_id", "product_color_id", "product_size_id"})
})
public class ShopProduct {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "shop_id", nullable = false)
    private Shop shop;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @ManyToOne
    @JoinColumn(name = "product_size_id", nullable = false)
    private ProductSize productSize;

    @ManyToOne
    @JoinColumn(name = "product_color_id", nullable = false)
    private ProductColor productColor;

    private Long quantity;


}
