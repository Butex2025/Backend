package io.github.butex.backend.dto.furgonetka;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@Builder
public class FurgonetkaPackageRequestDTO {

    private FurgonetkaPackagePickupDTO pickup;
    private FurgonetkaPackageReceiverDTO receiver;
    private Integer service_id;
    private List<FurgonetkaPackageDTO> parcels;
    private String type;
}
