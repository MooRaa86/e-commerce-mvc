package com.omar.ecommercemvc.config;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {

        Connection connection =
                dbConnection.getConnection();

        if (connection != null) {

            System.out.println("Connected Successfully");

        }

    }
}
