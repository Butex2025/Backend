package io.github.butex.backend.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SignUpRequestDTO {

    @NotBlank
    @Size(max = 50)
    @Email
    private String email;

    @NotBlank(message = "Firstname cannot be empty")
    @Size(max = 50)
    private String firstName;

    @NotBlank(message = "Lastname cannot be empty")
    @Size(max = 50)
    private String lastName;

    @NotBlank(message = "Password cannot be empty")
    @Length(min = 8, message = "Password must be at least 8 characters long")
    private String password;

    @NotBlank(message = "Confirm Password cannot be empty")
    private String confirmPassword;

    public boolean doPasswordsMatch() {
        return this.password.equals(this.confirmPassword);
    }

}