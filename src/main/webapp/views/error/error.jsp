<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Integer errorCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
  String errorMessage = (String) request.getAttribute("errorMessage");
  String requestMessage = (String) request.getAttribute("jakarta.servlet.error.message");

  if (errorCode == null) {
    errorCode = (Integer) request.getAttribute("errorCode");
    if (errorCode == null) {
      errorCode = 500;
    }
  }

  if (errorMessage == null) {
    errorMessage = requestMessage;
  }

  String title = "Error";
  String heading = "Error";
  String description = "An unexpected error occurred.";
  String color = "#e74c3c";

  if (errorCode != null) {
    switch (errorCode) {
      case 403:
        title = "403 - Forbidden";
        heading = "Access Denied";
        description = "You do not have permission to access this resource.";
        color = "#e74c3c";
        break;
      case 404:
        title = "404 - Not Found";
        heading = "Page Not Found";
        description = "The page you are looking for does not exist.";
        color = "#e67e22";
        break;
      case 500:
        title = "500 - Server Error";
        heading = "Internal Server Error";
        description = errorMessage != null ? errorMessage : "Something went wrong on our end. Please try again later.";
        color = "#e74c3c";
        break;
    }
  }
%>
<html>
<head>
  <title><%= title %></title>
  <style>
    body { font-family: Arial, sans-serif; text-align: center; padding: 80px 20px; background: #f5f5f5; }
    .error-container { max-width: 500px; margin: auto; background: white; padding: 40px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h1 { color: <%= color %>; font-size: 48px; margin: 0; }
    h2 { color: #333; }
    p { color: #666; }
    a { color: #3498db; text-decoration: none; }
    a:hover { text-decoration: underline; }
  </style>
</head>
<body>
<div class="error-container">
  <h1><%= errorCode %></h1>
  <h2><%= heading %></h2>
  <p><%= description %></p>
  <a href="${pageContext.request.contextPath}/home">Go Back Home</a>
</div>
</body>
</html>
