package io.github.butex.backend.dto.furgonetka;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@Builder
public class FurgonetkaPackagePickupDTO {

    private String street;
    private String postcode;
    private String city;
    private String name;
    private String company;
    private String email;
    private String phone;
    private String point;

    @JsonProperty("country_code")
    private String countryCode;
}
