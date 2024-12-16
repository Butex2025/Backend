package io.github.butex.backend.exception;

import lombok.Data;

import java.util.Date;

@Data
public class MessageError {
    private final int statusCode;
    private final Date timestamp;
    private final String message;
    private final String description;

}
