package io.github.butex.backend.dal.repository;

import io.github.butex.backend.dal.entity.Order;
import io.github.butex.backend.dal.entity.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findAllByStatusIn(final Collection<OrderStatus> orderStatuses);

    List<Order> findAllByEmailAndStatusNotIn(final String email, final Collection<OrderStatus> orderStatuses);

}
