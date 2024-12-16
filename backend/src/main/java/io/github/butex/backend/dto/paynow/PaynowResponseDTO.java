package io.github.butex.backend.dto.paynow;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class PaynowResponseDTO {

    private String redirectUrl;
    private String paymentId;
    private String status;
}
