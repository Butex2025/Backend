package io.github.butex.backend.constant;

public enum DeliveryService {

    INPOST(10091112),
    DPD(10091106);

    public final Integer id;

    DeliveryService(Integer id) {
        this.id = id;
    }

    public static Integer fromName(String service) {
        for (DeliveryService value : DeliveryService.values()) {
            if (value.name().equals(service)) {
                return value.id;
            }
        }

        return -1;
    }
}
