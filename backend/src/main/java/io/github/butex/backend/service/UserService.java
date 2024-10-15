package io.github.butex.backend.service;

import io.github.butex.backend.auth.PassEncoder;
import io.github.butex.backend.dao.entity.RoleEntity;
import io.github.butex.backend.dao.entity.RoleType;
import io.github.butex.backend.dao.entity.UserEntity;
import io.github.butex.backend.dao.repository.UserRepository;
import io.github.butex.backend.dto.SignUpRequestDTO;
import io.github.butex.backend.exception.DataNotFoundException;
import io.github.butex.backend.exception.UserExistException;
import io.github.butex.backend.mapper.UserMapper;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@AllArgsConstructor
public class UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleService roleService;

    private final UserMapper userMapper;

    private final PasswordEncoder passwordEncoder = new PassEncoder();

    public UserEntity getUserByEmail(final String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new DataNotFoundException("User Not Found with email: " + email));
    }

    @Transactional
    public void createNewUser(final SignUpRequestDTO signUpRequestDTO) {
        if (userRepository.findByEmail(signUpRequestDTO.getEmail()).isPresent()) {
            throw new UserExistException("User already exist");
        }
        RoleEntity roleEntity = roleService.findRoleByRoleType(RoleType.USER);

        UserEntity userEntity = new UserEntity(signUpRequestDTO.getEmail(), signUpRequestDTO.getFirstName(), signUpRequestDTO.getLastName(), signUpRequestDTO.getPassword(), roleEntity);
        userEntity.setPasswordHash(passwordEncoder.encode(userEntity.getPasswordHash()));
        userRepository.save(userEntity);
    }

    public boolean validateUser(final String email, final String password) {
        UserEntity userEntity = getUserByEmail(email);
        return passwordEncoder.matches(passwordEncoder.encode(password), userEntity.getPasswordHash());
    }

}
