package io.github.butex.backend.configuration;

import io.github.butex.backend.dto.*;
import io.github.butex.backend.service.*;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.math.BigDecimal;
import java.util.*;

@Component
@RequiredArgsConstructor
public class DummyDataInitializer {

    private final ProductColorService productColorService;
    private final ProductFabricService productFabricService;
    private final ProductSizeService productSizeService;
    private final ProductTypeService productTypeService;
    private final ShopService shopService;
    private final ProductService productService;
    private final ShopProductService shopProductService;

    private static final List<String> BRANDS = List.of("Nike", "Adidas", "Puma", "Reebok", "Converse", "New Balance", "Vans", "Under Armour", "Timberland");
    private static final List<String> COLORS_LIST = Arrays.asList("Red", "Blue", "Green");
    private static final List<String> FABRICS_LIST = Arrays.asList("Leather", "Cotton", "Synthetic");
    private static final List<Double> SIZES_LIST = Arrays.asList(42.0, 43.0, 44.5);
    private static final List<String> TYPES_LIST = Arrays.asList("Sneakers", "Boots", "Sandals");
    private static final List<ShopDTO> SHOPS_LIST = Arrays.asList(
            new ShopDTO(null, "Shop A", "Warsaw", "Main St", "00-001", 52.2297, 21.0122),
            new ShopDTO(null, "Shop B", "Krakow", "Market Sq", "30-002", 50.0647, 19.9450),
            new ShopDTO(null, "Shop C", "Gdansk", "Long St", "80-001", 54.3520, 18.6466)
    );

    private final Random random = new Random();

    private static final Map<String, String> filenameByType = Map.of(
            "Sneakers", "trampki.jpg",
            "Boots", "sportowe.jpg",
            "Sandals", "kozaki.jpg"
    );

    @PostConstruct
    public void init() {
        initializeColors();
        initializeFabrics();
        initializeSizes();
        initializeTypes();
        initializeShops();

        initializeProducts();
    }

    private void initializeColors() {
        COLORS_LIST.forEach(color -> {
            try {
                productColorService.create(new ProductColorDTO(null, color));
            } catch (IllegalArgumentException e) {
                System.out.println("Color already exists: " + color);
            }
        });
    }

    private void initializeFabrics() {
        FABRICS_LIST.forEach(fabric -> {
            try {
                productFabricService.create(new ProductFabricDTO(null, fabric));
            } catch (IllegalArgumentException e) {
                System.out.println("Fabric already exists: " + fabric);
            }
        });
    }

    private void initializeSizes() {
        SIZES_LIST.forEach(size -> {
            try {
                productSizeService.create(new ProductSizeDTO(null, size));
            } catch (IllegalArgumentException e) {
                System.out.println("Size already exists: " + size);
            }
        });
    }

    private void initializeTypes() {
        TYPES_LIST.forEach(type -> {
            try {
                productTypeService.create(new ProductTypeDTO(null, type));
            } catch (IllegalArgumentException e) {
                System.out.println("Type already exists: " + type);
            }
        });
    }

    private void initializeShops() {
        SHOPS_LIST.forEach(shop -> {
            try {
                shopService.create(shop);
            } catch (IllegalArgumentException e) {
                System.out.println("Shop already exists: " + shop.getName() + ", " + shop.getCity());
            }
        });
    }

    private void initializeProducts() {

        if(!productService.getAll().isEmpty()) {
            return;
        }

        List<ProductDTO> products = new ArrayList<>();
        for (int i = 0; i < 15; i++) {
            String randomType = getRandomType();  // Wybieramy losowy typ tylko raz
            ProductDTO product = ProductDTO.builder()
                    .name("Product " + (i + 1))
                    .brand(getRandomBrand())
                    .price(getRandomPrice())
                    .productFabric(getRandomFabricDTO())
                    .productType(getRandomTypeDTO())
                    .image(getImageForType(randomType))  // Ustawiamy obraz na podstawie typu
                    .build();
            products.add(productService.create(product));
        }

        products.forEach(product -> {
            for (int j = 0; j < 5; j++) {
                ShopProductDTO shopProduct = ShopProductDTO.builder()
                        .shop(getRandomShopDTO())
                        .product(product)
                        .productSize(getRandomSizeDTO())
                        .productColor(getRandomColorDTO())
                        .quantity((long) (random.nextInt(50) + 1))
                        .build();
                try {
                    shopProductService.create(shopProduct);
                } catch (IllegalArgumentException e) {
                    System.out.println("Duplicate ShopProduct combination: " + e.getMessage());
                }
            }
        });
    }

    private byte[] getImageForType(String type) {
        String filename = filenameByType.get(type);
        if (filename == null) {
            System.out.println("Image file not found for type: " + type);
            return null;
        }

        try (InputStream is = getClass().getResourceAsStream("/images/" + filename)) {
            if (is == null) {
                System.out.println("Error: File " + filename + " not found in resources");
                return null;
            }
            return is.readAllBytes();
        } catch (Exception e) {
            System.out.println("Error loading image: " + e.getMessage());
            return null;
        }
    }

    private String getRandomBrand() {
        return BRANDS.get(random.nextInt(BRANDS.size()));
    }

    private BigDecimal getRandomPrice() {
        return BigDecimal.valueOf(50 + (random.nextDouble() * 450)).setScale(2, BigDecimal.ROUND_HALF_UP);
    }

    private String getRandomType() {
        return TYPES_LIST.get(random.nextInt(TYPES_LIST.size()));
    }

    // Metody do losowego wybierania DTO z bazy danych
    private ShopDTO getRandomShopDTO() {
        List<ShopDTO> shops = shopService.getAll();
        return shops.get(random.nextInt(shops.size()));
    }

    private ProductColorDTO getRandomColorDTO() {
        List<ProductColorDTO> colors = productColorService.getAll();
        return colors.get(random.nextInt(colors.size()));
    }

    private ProductSizeDTO getRandomSizeDTO() {
        List<ProductSizeDTO> sizes = productSizeService.getAll();
        return sizes.get(random.nextInt(sizes.size()));
    }

    private ProductFabricDTO getRandomFabricDTO() {
        List<ProductFabricDTO> fabrics = productFabricService.getAll();
        return fabrics.get(random.nextInt(fabrics.size()));
    }

    private ProductTypeDTO getRandomTypeDTO() {
        List<ProductTypeDTO> types = productTypeService.getAll();
        return types.get(random.nextInt(types.size()));
    }
}
