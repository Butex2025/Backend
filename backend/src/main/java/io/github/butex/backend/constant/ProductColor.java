package io.github.butex.backend.constant;

public enum ProductColor {

    BLACK("Black", "Czarny"),
    WHITE("White", "Biały"),
    GRAY("Gray", "Szary");

    public final String nameEN, namePL;

    ProductColor(String nameEN, String namePL) {
        this.nameEN = nameEN;
        this.namePL = namePL;
    }
}
