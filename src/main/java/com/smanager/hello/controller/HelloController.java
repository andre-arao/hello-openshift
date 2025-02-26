package com.smanager.hello.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@RestController
@RequestMapping(value = "/hello")
public class HelloController {

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public static final String ENV_APP_ID = System.getenv("app.id");
    public static final String ENV_APP_NAME = System.getenv("app.name");

    @GetMapping
    public String hello() {
        String connectionStatus = testDatabaseConnection();

        return "Hello <br> " +
                "<br> Valor da variavel no application.yaml: " + url +
                "<br> Valor da variavel direto do OpenShift: " + ENV_APP_ID + ENV_APP_NAME +
                "<br> Status da conexão com o banco de dados: " + connectionStatus;
    }

    private String testDatabaseConnection() {
        try (Connection connection = getDataSource().getConnection()) {
            return "Conexão bem-sucedida ao banco de dados!";
        } catch (SQLException e) {
            return "Falha na conexão com o banco de dados: " + e.getMessage();
        }
    }

    private DataSource getDataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        return dataSource;
    }
}
