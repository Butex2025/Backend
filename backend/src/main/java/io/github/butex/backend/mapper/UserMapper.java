package io.github.butex.backend.mapper;

import io.github.butex.backend.dao.entity.UserEntity;
import io.github.butex.backend.dto.UserDTO;
import org.mapstruct.Mapper;

@Mapper
public interface UserMapper {

    UserDTO userToUserDTO(UserEntity user);
}
