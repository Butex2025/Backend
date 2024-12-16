package io.github.butex.backend.dto;

import io.github.butex.backend.dal.entity.OrderStatus;
import lombok.Data;

@Data
public class ChangeOrderStatusRequestDTO {

    private Long orderId;
    private OrderStatus status;
}
