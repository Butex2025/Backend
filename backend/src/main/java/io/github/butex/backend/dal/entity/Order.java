package io.github.butex.backend.dal.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Getter
@Setter
@Table(name = "orders")
@JsonIgnoreProperties(ignoreUnknown = true)
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "order_id")
    private List<OrderProduct> products;
    private String name;
    private String street;
    private String postcode;
    private String city;
    private String email;
    private String phoneNumber;
    private String service;
    private Double finalPrice;

    @Enumerated(EnumType.STRING)
    private OrderStatus status = OrderStatus.PROCESSING;

}
