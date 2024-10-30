package io.github.butex.backend.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class SignInResponseDTO {

    private String email;
    private String token;
    private String roleType;

}