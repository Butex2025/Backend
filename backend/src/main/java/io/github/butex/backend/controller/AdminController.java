package io.github.butex.backend.controller;


import io.github.butex.backend.dal.entity.Order;
import io.github.butex.backend.dal.entity.ShopProduct;
import io.github.butex.backend.dto.ChangeOrderStatusRequestDTO;
import io.github.butex.backend.dto.ChangeProductQuantityRequestDTO;
import io.github.butex.backend.dto.ProductDTO;
import io.github.butex.backend.service.OrderService;
import io.github.butex.backend.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/v1/admin")
@RestController
@RequiredArgsConstructor
public class AdminController {

    private final OrderService orderService;
    private final ProductService productService;


    @PutMapping(path = "/order-status")
    public ResponseEntity<Order> changeOrderStatus(@RequestBody ChangeOrderStatusRequestDTO requestDTO) {
        Order order = orderService.changeOrderStatus(requestDTO.getOrderId(), requestDTO.getStatus());
        if (order == null) {
            return ResponseEntity.badRequest().build();
        }

        return ResponseEntity.ok(order);
    }

    @PutMapping(path = "/product-quantity")
    public ResponseEntity<ShopProduct> changeProductQuantity(@RequestBody ChangeProductQuantityRequestDTO requestDTO) {
        ShopProduct shopProduct = productService.changeQuantity(requestDTO.getProductId(), requestDTO.getQuantity());
        if (shopProduct == null) {
            return ResponseEntity.badRequest().build();
        }

        return ResponseEntity.ok(shopProduct);
    }


    @PostMapping(path = "/product")
    public ResponseEntity<ProductDTO> createProduct(@RequestBody ProductDTO productDTO) {
        ProductDTO resultProductDTO = productService.create(productDTO);
        if (resultProductDTO == null) {
            return ResponseEntity.badRequest().build();
        }

        return ResponseEntity.ok(resultProductDTO);
    }


    @DeleteMapping(path = "/product/{id}")
    public ResponseEntity<?> deleteProduct(@PathVariable Long id) {
        productService.delete(id);
        return ResponseEntity.ok().build();
    }

    @PutMapping(path = "/product")
    public ResponseEntity<ProductDTO> updateProduct(@RequestBody ProductDTO productDTO) {
        ProductDTO resultProductDTO = productService.update(productDTO);
        if (resultProductDTO == null) {
            return ResponseEntity.badRequest().build();
        }

        return ResponseEntity.ok(resultProductDTO);
    }

}
