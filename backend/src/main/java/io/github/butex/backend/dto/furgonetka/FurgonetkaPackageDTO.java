package io.github.butex.backend.dto.furgonetka;

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
public class FurgonetkaPackageDTO {

    private Integer width;
    private Integer depth;
    private Integer height;
    private float weight;
    private String description;
}
