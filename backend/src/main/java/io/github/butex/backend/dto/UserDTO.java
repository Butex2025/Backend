package io.github.butex.backend.dto;

import io.github.butex.backend.dal.entity.RoleEntity;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserDTO {

    private final Integer id;
    private final String email;
    private final String firstName;
    private final String lastName;
    private final String passwordHash;
    private final LocalDateTime dateJoined = LocalDateTime.now();
    private final RoleEntity role;

}
