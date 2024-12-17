package io.github.butex.backend.controller;

import io.github.butex.backend.dal.entity.Order;
import io.github.butex.backend.dal.entity.OrderStatus;
import io.github.butex.backend.dal.entity.ProductColor;
import io.github.butex.backend.dal.entity.ProductFabric;
import io.github.butex.backend.dal.entity.ProductType;
import io.github.butex.backend.dal.entity.ShopProduct;
import io.github.butex.backend.dal.repository.ProductColorRepository;
import io.github.butex.backend.dal.repository.ProductFabricRepository;
import io.github.butex.backend.dal.repository.ProductTypeRepository;
import io.github.butex.backend.dal.repository.ShopProductRepository;
import io.github.butex.backend.dto.ChangeOrderStatusRequestDTO;
import io.github.butex.backend.dto.ChangeProductQuantityRequestDTO;
import io.github.butex.backend.dto.ProductDTO;
import io.github.butex.backend.service.OrderService;
import io.github.butex.backend.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@RequestMapping("/api/v1/admin")
@RestController
@RequiredArgsConstructor
public class AdminController {

    private final OrderService orderService;
    private final ProductService productService;
    private final ProductTypeRepository productTypeRepository;
    private final ProductFabricRepository productFabricRepository;
    private final ProductColorRepository productColorRepository;
    private final ShopProductRepository shopProductRepository;

    @PutMapping(path = "/order-status")

    public ResponseEntity<Order> changeOrderStatus(@RequestBody ChangeOrderStatusRequestDTO requestDTO) {
        Order order = orderService.changeOrderStatus(requestDTO.getOrderId(), requestDTO.getStatus());
        if (order == null) {
            return ResponseEntity.badRequest().build();
        }

        return ResponseEntity.ok(order);
    }

    @GetMapping(path = "/order")
    public ResponseEntity<List<Order>> getOrders() {
        return ResponseEntity.ok(orderService.getAllOrder());
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

    @GetMapping(path = "/order-status")
    public ResponseEntity<List<String>> getOrderStatuses() {
        return ResponseEntity.ok(Arrays.stream(OrderStatus.values()).map(Enum::name).toList());
    }

    @GetMapping(path = "/product-color")
    public ResponseEntity<List<ProductColor>> getProductColors() {
        return ResponseEntity.ok(productColorRepository.findAll());
    }

    @GetMapping(path = "/product-type")
    public ResponseEntity<List<ProductType>> getProductTypes() {
        return ResponseEntity.ok(productTypeRepository.findAll());
    }

    @GetMapping(path = "/product-fabric")
    public ResponseEntity<List<ProductFabric>> getProductFabric() {
        return ResponseEntity.ok(productFabricRepository.findAll());
    }

    @PostMapping(path = "/product-type")
    public ResponseEntity<ProductType> createProductType(@RequestBody ProductType productType) {
        ProductType savedProductType = productTypeRepository.save(productType);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedProductType);
    }

    @PutMapping(path = "/product-type/{id}")
    public ResponseEntity<ProductType> updateProductType(@PathVariable Long id, @RequestBody ProductType productType) {
        return productTypeRepository.findById(id)
                .map(existingProductType -> {
                    existingProductType.setType(productType.getType());
                    ProductType updatedProductType = productTypeRepository.save(existingProductType);
                    return ResponseEntity.ok(updatedProductType);
                })
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    @DeleteMapping(path = "/product-type/{id}")
    public ResponseEntity<Void> deleteProductType(@PathVariable Long id) {
        if (productTypeRepository.existsById(id)) {
            productTypeRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @PostMapping(path = "/product-fabric")
    public ResponseEntity<ProductFabric> createProductFabric(@RequestBody ProductFabric productFabric) {
        ProductFabric savedProductFabric = productFabricRepository.save(productFabric);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedProductFabric);
    }

    @PutMapping(path = "/product-fabric/{id}")
    public ResponseEntity<ProductFabric> updateProductFabric(@PathVariable Long id, @RequestBody ProductFabric productFabric) {
        return productFabricRepository.findById(id)
                .map(existingProductFabric -> {
                    existingProductFabric.setFabric(productFabric.getFabric());
                    ProductFabric updatedProductFabric = productFabricRepository.save(existingProductFabric);
                    return ResponseEntity.ok(updatedProductFabric);
                })
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    @DeleteMapping(path = "/product-fabric/{id}")
    public ResponseEntity<Void> deleteProductFabric(@PathVariable Long id) {
        if (productFabricRepository.existsById(id)) {
            productFabricRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @PutMapping(path = "/shop-product-quantity/{id}")
    public ResponseEntity<ShopProduct> changeProductQuantity(@PathVariable Long id, @RequestParam Long newQuantity) {
        ShopProduct shopProduct = shopProductRepository.findById(id).orElse(null);
        if(shopProduct == null){
            return ResponseEntity.notFound().build();
        }

        shopProduct.setQuantity(newQuantity);
        ShopProduct save = shopProductRepository.save(shopProduct);
        return ResponseEntity.ok(save);
    }


    @PostMapping(path = "/shop-product")
    public ResponseEntity<ShopProduct> createShopProduct(@RequestBody ShopProduct shopProduct) {
        ShopProduct savedShopProduct = shopProductRepository.save(shopProduct);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedShopProduct);
    }

    // Update ShopProduct
    @PutMapping(path = "/shop-product/{id}")
    public ResponseEntity<ShopProduct> updateShopProduct(@PathVariable Long id, @RequestBody ShopProduct shopProduct) {
        return shopProductRepository.findById(id)
                .map(existingShopProduct -> {
                    existingShopProduct.setShop(shopProduct.getShop());
                    existingShopProduct.setProduct(shopProduct.getProduct());
                    existingShopProduct.setProductSize(shopProduct.getProductSize());
                    existingShopProduct.setProductColor(shopProduct.getProductColor());
                    existingShopProduct.setQuantity(shopProduct.getQuantity());
                    ShopProduct updatedShopProduct = shopProductRepository.save(existingShopProduct);
                    return ResponseEntity.ok(updatedShopProduct);
                })
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    // Delete ShopProduct
    @DeleteMapping(path = "/shop-product/{id}")
    public ResponseEntity<Void> deleteShopProduct(@PathVariable Long id) {
        if (shopProductRepository.existsById(id)) {
            shopProductRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @GetMapping(path = "/shop-product")
    public ResponseEntity<List<ShopProduct>> createShopProduct() {
        return ResponseEntity.ok(shopProductRepository.findAll());
    }

}
