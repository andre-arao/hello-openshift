package com.smanager.hello.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/hello")
public class HelloController {

    @Value("${spring.datasource.url}")
    private String url;

    public static final	String ENV_APP_ID = System.getenv("app.id");
    public static final	String ENV_APP_NAME = System.getenv("app.name");

    @GetMapping
    public String hello(){
        return "Hello " +
                "Valor da variavel no application.yaml: " + url +
                "Valor da variavel direto do OpenShift: " + ENV_APP_ID + ENV_APP_NAME;
    }
}
