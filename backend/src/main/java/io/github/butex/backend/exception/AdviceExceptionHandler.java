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
        return prepareErrorResponseEntity(HttpStatus.NOT_FOUND, ex, request);

    }

    @ExceptionHandler({UserExistException.class})
    public ResponseEntity<MessageError> userExistException(UserExistException ex, WebRequest request) {
        return prepareErrorResponseEntity(HttpStatus.BAD_REQUEST, ex, request);
    }

    private ResponseEntity<MessageError> prepareErrorResponseEntity(HttpStatus httpStatus, RuntimeException ex, WebRequest request){
        MessageError messageError = new MessageError(
                httpStatus.value(),
                new Date(),
                ex.getMessage(),
                request.getDescription(false));

        return new ResponseEntity<>(messageError, httpStatus);
    }
}
