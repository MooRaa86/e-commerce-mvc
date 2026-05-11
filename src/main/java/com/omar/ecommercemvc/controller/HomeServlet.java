package com.omar.ecommercemvc.controller;

import com.omar.ecommercemvc.model.Product;
import com.omar.ecommercemvc.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final ProductService productService =
            new ProductService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products =
                productService.getAllProducts();

        request.setAttribute("products", products);

        request.getRequestDispatcher(
                "/views/home.jsp"
        ).forward(request, response);

    }

}