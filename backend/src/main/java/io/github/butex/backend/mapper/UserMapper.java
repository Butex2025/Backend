package io.github.butex.backend.mapper;

import io.github.butex.backend.dal.entity.UserEntity;
import io.github.butex.backend.dto.UserDTO;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UserMapper {

    UserDTO userToUserDTO(UserEntity user);
}
