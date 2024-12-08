package io.github.butex.backend.dal.entity;

public enum OrderStatus {
    // Statusy związane z płatnościami
    PAYMENT_PENDING,     // Oczekiwanie na płatność
    PAYMENT_COMPLETED,   // Płatność zrealizowana
    PAYMENT_FAILED,      // Płatność nie powiodła się

    // Statusy związane z przetwarzaniem zamówienia
    PROCESSING,          // Zamówienie jest przetwarzane
    READY_FOR_SHIPMENT,  // Gotowe do wysyłki
    OUT_OF_STOCK,        // Brak towaru na stanie

    // Statusy związane z przesyłką
    SHIPPED,             // Wysłano
    IN_TRANSIT,          // W trasie
    DELIVERED,           // Dostarczono
    DELIVERY_FAILED,     // Nieudana dostawa

    // Inne statusy błędów
    CANCELED,            // Zamówienie anulowane
    RETURNED             // Zwrot zamówienia
}
