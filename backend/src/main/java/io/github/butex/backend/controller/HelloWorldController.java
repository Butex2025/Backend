package io.github.butex.backend.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/hello-world")
public class HelloWorldController {

    @GetMapping("/all")
    public ResponseEntity<String> getHelloWorld() {
        return ResponseEntity.ok("Hello World <3");
    }

    @GetMapping("/user")
    public ResponseEntity<String> getUserHelloWorld() {
        return ResponseEntity.ok("User Hello World <3");
    }

    @GetMapping("/admin")
    public ResponseEntity<String> getAdminHelloWorld() {
        return ResponseEntity.ok("Admin Hello World <3");
    }

}