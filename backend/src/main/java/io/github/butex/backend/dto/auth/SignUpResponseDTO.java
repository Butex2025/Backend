package io.github.butex.backend.dto.auth;

import io.github.butex.backend.dto.UserDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SignUpResponseDTO {

    private UserDTO userDTO;
    private String token;

}
