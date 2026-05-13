package com.omar.ecommercemvc.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter({"/*"})
public class ExceptionHandlerFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        try {
            chain.doFilter(request, response);
        } catch (Exception e) {
            String message = e.getMessage();
            if (e instanceof ServletException) {
                Throwable rootCause = ((ServletException) e).getRootCause();
                if (rootCause != null && rootCause.getMessage() != null) {
                    message = rootCause.getMessage();
                }
            }

            response.setStatus(500);
            request.setAttribute("errorCode", 500);
            request.setAttribute("errorMessage", message != null ? message : "An unexpected error occurred.");

            try {
                request.getRequestDispatcher("/views/error/error.jsp").forward(request, response);
            } catch (Exception forwardError) {
                System.out.println(" Error page forward failed: " + forwardError.getMessage());
            }
        }
    }
}
