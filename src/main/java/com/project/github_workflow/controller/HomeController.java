package com.project.github_workflow.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {
    @GetMapping("/")
    public String home() {
        return "Hello, welcome to Spring Boot!";
    }

    @GetMapping("/user")
    public String getUser() {
        return "Hello, welcome to Spring Boot!";
    }


}
