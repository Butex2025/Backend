package io.github.butex.backend.dal.repository;

import io.github.butex.backend.dal.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {

    List<Payment> findAllByStatusIsNot(String status);

    Optional<Payment> findByOrderId(final Long orderId);
}
