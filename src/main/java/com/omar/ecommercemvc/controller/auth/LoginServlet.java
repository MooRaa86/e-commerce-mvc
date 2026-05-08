package com.omar.ecommercemvc.controller.auth;

import com.omar.ecommercemvc.model.User;
import com.omar.ecommercemvc.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService =
            new AuthService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        User user =
                authService.login(email, password);

        if (user != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "loggedInUser",
                    user
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/home"
            );

        } else {

            request.setAttribute(
                    "error",
                    "Invalid Email or Password"
            );

            request.getRequestDispatcher(
                    "/views/auth/login.jsp"
            ).forward(request, response);

        }

    }

}