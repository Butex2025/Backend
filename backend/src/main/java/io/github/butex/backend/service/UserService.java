package io.github.butex.backend.service;

import io.github.butex.backend.auth.PassEncoder;
import io.github.butex.backend.dal.entity.Role;
import io.github.butex.backend.constant.RoleType;
import io.github.butex.backend.dal.entity.User;
import io.github.butex.backend.dal.repository.UserRepository;
import io.github.butex.backend.dto.auth.SignUpRequestDTO;
import io.github.butex.backend.dto.UserDTO;
import io.github.butex.backend.exception.DataNotFoundException;
import io.github.butex.backend.exception.UserExistException;
import io.github.butex.backend.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final RoleService roleService;
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder = new PassEncoder();

    public User getUserByEmail(final String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new DataNotFoundException("User Not Found with email: " + email));
    }

    public UserDTO createNewUser(final SignUpRequestDTO signUpRequestDTO) {
        if (userRepository.findByEmail(signUpRequestDTO.getEmail()).isPresent()) {
            throw new UserExistException("User already exist");
        }

        Role role = roleService.findRoleByRoleType(RoleType.USER);

        User user = new User();
        user.setEmail(signUpRequestDTO.getEmail());
        user.setFirstName(signUpRequestDTO.getFirstName());
        user.setLastName(signUpRequestDTO.getLastName());
        user.setPasswordHash(passwordEncoder.encode(signUpRequestDTO.getPassword()));
        user.setRole(role);

        User savedUser = userRepository.save(user);
        return userMapper.userToUserDTO(savedUser);
    }

    public boolean validateUser(final String email, final String password) {
        User user = getUserByEmail(email);
        return passwordEncoder.matches(passwordEncoder.encode(password), user.getPasswordHash());
    }

}
