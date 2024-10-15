package io.github.butex.backend.controller;

import io.github.butex.backend.dao.entity.UserEntity;
import io.github.butex.backend.dto.SignInRequestDTO;
import io.github.butex.backend.dto.SignInResponseDTO;
import io.github.butex.backend.dto.SignUpRequestDTO;
import io.github.butex.backend.service.UserService;
import io.github.butex.backend.utils.JwtUtils;
import io.github.butex.backend.utils.PasswordUtils;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/v1/auth")
@RestController
public class AuthController {

    @Autowired
    private UserService userService;

//    @Autowired
//    private OwnerDetailService ownerDetailService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtils jwtUtils;

    @PostMapping("/signin")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody SignInRequestDTO signInRequestDTO) {

        if (userService.validateUser(signInRequestDTO.getEmail(), signInRequestDTO.getPassword())) {
            return ResponseEntity.badRequest().body("Password not match");
        }
        UserEntity userEntity = userService.getUserByEmail(signInRequestDTO.getEmail());

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        signInRequestDTO.getEmail(),
                        signInRequestDTO.getPassword())
        );
        String jwtToken = jwtUtils.generateJwtToken(authentication);
        return ResponseEntity.ok(new SignInResponseDTO(signInRequestDTO.getEmail(), jwtToken, userEntity.getRole().getRoleName().name()));
    }

    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@Valid @RequestBody SignUpRequestDTO signUpRequestDTO) {
        if (!signUpRequestDTO.doPasswordsMatch()) {
            return ResponseEntity.badRequest().body("Password not match");
        }
        if (!PasswordUtils.isValid(signUpRequestDTO.getPassword())) {
            ResponseEntity.badRequest().body("Password not strong");
        }

        userService.createNewUser(signUpRequestDTO);
        return ResponseEntity.ok("User created successfully");
    }
}
