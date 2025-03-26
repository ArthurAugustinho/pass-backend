package com.pass;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.pass")
public class PassBackendApplication {
    public static void main(String[] args) {
        SpringApplication.run(PassBackendApplication.class, args);
    }
}
