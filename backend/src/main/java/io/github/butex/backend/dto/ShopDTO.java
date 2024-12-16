package io.github.butex.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ShopDTO {

    private Long id;
    private String name;
    private String city;
    private String street;
    private String postcode;
    private Double latitude;
    private Double longitude;

}
