package com.omar.ecommercemvc.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/ecommerce-mvc";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "12345";
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
