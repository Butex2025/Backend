package io.github.butex.backend.util;

import java.util.regex.Pattern;

public final class PasswordUtil {

    /*
    ^: indicates the string’s beginning
    (?=.*[a-z]): makes sure that there is at least one small letter
    (?=.*[A-Z]): needs at least one capital letter
    (?=.*\\d): requires at least one digit
    (?=.*[@#$%^&+=]): provides a guarantee of at least one special symbol
    .{8,20}: imposes the minimum length of 8 characters and the maximum length of 20 characters
    $: terminates the string
    */
    private static final String PASSWORD_REGEX = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,20}$";

    private PasswordUtil() {
    }

    public static boolean isValid(final String password) {
        Pattern pattern = Pattern.compile(PASSWORD_REGEX, Pattern.CASE_INSENSITIVE);
        return pattern.matcher(password).matches();
    }
}
