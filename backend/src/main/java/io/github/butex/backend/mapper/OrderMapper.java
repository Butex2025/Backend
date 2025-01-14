package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.Order;
import io.github.butex.backend.dal.entity.OrderProduct;
import io.github.butex.backend.dto.NotificationOrderDTO;
import io.github.butex.backend.dto.OrderDTO;
import io.github.butex.backend.dto.OrderProductDTO;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface OrderMapper {

    OrderDTO orderToOrderDTO(Order order);

    List<NotificationOrderDTO> ordersToNotificationOrderDTOs(List<Order> order);

    Order orderDTOToOrder(OrderDTO orderDTO);

    List<OrderProduct> orderProductDTOToOrderProduct(List<OrderProductDTO> orderProductList);
}
