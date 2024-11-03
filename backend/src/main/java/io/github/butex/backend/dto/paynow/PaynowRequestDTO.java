package io.github.butex.backend.dto.paynow;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@Builder
public class PaynowRequestDTO {

    private Integer amount;
    private String currency;
    private String externalId;
    private String description;
    private PaynowBuyerDTO buyer;
}
