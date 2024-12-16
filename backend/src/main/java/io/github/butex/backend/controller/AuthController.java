package io.github.butex.backend.controller;

import io.github.butex.backend.dal.entity.User;
import io.github.butex.backend.dto.auth.SignInRequestDTO;
import io.github.butex.backend.dto.auth.SignInResponseDTO;
import io.github.butex.backend.dto.auth.SignUpRequestDTO;
import io.github.butex.backend.dto.UserDTO;
import io.github.butex.backend.dto.auth.SignUpResponseDTO;
import io.github.butex.backend.service.UserService;
import io.github.butex.backend.auth.JwtUtil;
import io.github.butex.backend.util.PasswordUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
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
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;
    private final AuthenticationManager authenticationManager;
    private final JwtUtil jwtUtils;

    @PostMapping("/signin")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody SignInRequestDTO signInRequestDTO) {
        if (userService.validateUser(signInRequestDTO.getEmail(), signInRequestDTO.getPassword())) {
            return ResponseEntity.badRequest().body("Passwords do not match");
        }

        User user = userService.getUserByEmail(signInRequestDTO.getEmail());
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(signInRequestDTO.getEmail(), signInRequestDTO.getPassword())
        );

        String jwtToken = jwtUtils.generateJwtToken(authentication);
        return ResponseEntity.ok(new SignInResponseDTO(signInRequestDTO.getEmail(), jwtToken, user.getRole().getRoleName().name()));
    }

    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@Valid @RequestBody SignUpRequestDTO signUpRequestDTO) {
        if (!signUpRequestDTO.getPassword().equals(signUpRequestDTO.getConfirmPassword())) {
            return ResponseEntity.badRequest().body("Passwords do not match");
        }

        if (!PasswordUtil.isValid(signUpRequestDTO.getPassword())) {
            ResponseEntity.badRequest().body("Password not strong");
        }

        UserDTO newUser = userService.createNewUser(signUpRequestDTO);
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(signUpRequestDTO.getEmail(), signUpRequestDTO.getPassword())
        );

        String jwtToken = jwtUtils.generateJwtToken(authentication);

        return ResponseEntity.ok(new SignUpResponseDTO(newUser, jwtToken));
    }
}
