package io.github.butex.backend.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import java.util.Date;

@RestControllerAdvice
public class AdviceExceptionHandler {

    @ExceptionHandler({DataNotFoundException.class})
    public ResponseEntity<MessageError> dataNotFoundException(DataNotFoundException ex, WebRequest request) {
        MessageError message = new MessageError(
                HttpStatus.NOT_FOUND.value(),
                new Date(),
                ex.getMessage(),
                request.getDescription(false));

        return new ResponseEntity<>(message, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({UserExistException.class})
    public ResponseEntity<MessageError> userExistException(UserExistException ex, WebRequest request) {
        MessageError message = new MessageError(
                HttpStatus.BAD_REQUEST.value(),
                new Date(),
                ex.getMessage(),
                request.getDescription(false));

        return new ResponseEntity<>(message, HttpStatus.BAD_REQUEST);
    }
}
