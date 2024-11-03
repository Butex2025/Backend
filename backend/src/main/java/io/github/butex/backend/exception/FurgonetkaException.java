package io.github.butex.backend.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class FurgonetkaException extends RuntimeException {
    public FurgonetkaException(String message) {
        super(message);
    }
}
