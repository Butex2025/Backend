package io.github.butex.backend.constant;

public enum ProductFabric {

    LEATHER("Leather", "Skóra"),
    SYNTHETIC_LEATHER("Synthetic leather", "Skóra syntetyczna");
    public final String nameEN, namePL;

    ProductFabric(String nameEN, String namePL) {
        this.nameEN = nameEN;
        this.namePL = namePL;
    }
}
