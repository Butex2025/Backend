package io.github.butex.backend.controller;

import io.github.butex.backend.dto.ProductDTO;
import io.github.butex.backend.dto.ProductDetailsDTO;
import io.github.butex.backend.service.ProductService;
import io.github.butex.backend.service.ShopProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("/api/v1/product")
@RestController
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final ShopProductService shopProductService;

    @GetMapping
    public ResponseEntity<List<ProductDTO>> getAllProducts() {
        return ResponseEntity.ok(productService.getAll());
    }

    @GetMapping(path = "/{id}")
    public ResponseEntity<ProductDTO> getProduct(@PathVariable Long id) {
        ProductDTO product = productService.getById(id);
        if (product == null) {
            return ResponseEntity.noContent().build();
        }

        return ResponseEntity.ok(product);
    }

    /**
     * Endpoint do pobierania szczegółów produktu wraz z dostępnymi kolorami, rozmiarami i sklepami.
     *
     * @param productId ID produktu, dla którego pobierane są szczegóły.
     * @return Szczegóły produktu zawierające kolory, rozmiary i sklepy, lub status 404, jeśli produkt nie istnieje.
     */
    @GetMapping("/{productId}/details")
    public ResponseEntity<ProductDetailsDTO> getProductDetails(@PathVariable Long productId) {
        try {
            ProductDetailsDTO productDetails = shopProductService.getProductDetailsById(productId);
            return ResponseEntity.ok(productDetails);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }
}