# E-Commerce MVC

Simple e-commerce web app using Java Servlets, JSP, MySQL, and Redis.

## Idea

Users can register, login, view products, and add reviews.

Admins can add, update, and delete products.

Redis is used to cache products and reviews, so the app does not need to get the same data from MySQL every time.

## Tools

- Java Servlets
- JSP
- MySQL
- Redis
- JWT
- BCrypt
- Tomcat

## How It Works

Browser → Filters → Servlet → Service → DAO → MySQL