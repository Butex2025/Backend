package io.github.butex.backend.mapper;

import io.github.butex.backend.dao.entity.User;
import io.github.butex.backend.dto.UserDTO;
import org.mapstruct.Mapper;

@Mapper
public interface UserMapper {

    UserDTO userToUserDTO(User user);
}
