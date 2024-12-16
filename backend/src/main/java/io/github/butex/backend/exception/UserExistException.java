package io.github.butex.backend.exception;

public class UserExistException extends RuntimeException {

    public UserExistException(final String msg) {
        super(msg);
    }

}
