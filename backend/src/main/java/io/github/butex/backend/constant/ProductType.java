package io.github.butex.backend.constant;

public enum ProductType {

    SNEAKERS("Sneakers", "Sneakersy"),
    SPORT("Sports", "Sportowe"),
    SANDALS("Sandals", "Sandały");

    public final String nameEN, namePL;

    ProductType(String nameEN, String namePL) {
        this.nameEN = nameEN;
        this.namePL = namePL;
    }
}
