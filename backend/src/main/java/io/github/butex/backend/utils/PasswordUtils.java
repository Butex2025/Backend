package io.github.butex.backend.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PasswordUtils {

    public static boolean isValid(final String password) {

//    ^: indicates the string’s beginning
//        (?=.*[a-z]): makes sure that there is at least one small letter
//        (?=.*[A-Z]): needs at least one capital letter
//        (?=.*\\d): requires at least one digit
//        (?=.*[@#$%^&+=]): provides a guarantee of at least one special symbol
//        .{8,20}: imposes the minimum length of 8 characters and the maximum length of 20 characters
//        $: terminates the string
        String regExpn = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,20}$";

        Pattern pattern = Pattern.compile(regExpn, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }

}
