<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Integer errorCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
  String errorMessage = (String) request.getAttribute("errorMessage");
  String requestMessage = (String) request.getAttribute("jakarta.servlet.error.message");

  if (errorCode == null) {
    errorCode = (Integer) request.getAttribute("errorCode");
    if (errorCode == null) errorCode = 500;
  }
  if (errorMessage == null) errorMessage = requestMessage;

  String title = "Error", heading = "Something went wrong", description = "An unexpected error occurred.";
  String iconColor = "#ef4444";

  if (errorCode != null) {
    switch (errorCode) {
      case 403:
        title = "403 — Forbidden"; heading = "Access Denied";
        description = "You don't have permission to access this resource.";
        iconColor = "#f59e0b"; break;
      case 404:
        title = "404 — Not Found"; heading = "Page Not Found";
        description = "The page you're looking for doesn't exist.";
        iconColor = "#6366f1"; break;
      case 429:
        title = "429 — Too Many Requests"; heading = "Slow Down!";
        description = "You've made too many requests. Please wait a moment and try again.";
        iconColor = "#f59e0b"; break;
      case 500:
        title = "500 — Server Error"; heading = "Internal Server Error";
        description = errorMessage != null ? errorMessage : "Something went wrong on our end. Please try again later.";
        iconColor = "#ef4444"; break;
    }
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%= title %></title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Inter', sans-serif; background: #f1f5f9; min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 24px; }
    .card { background: #fff; border-radius: 16px; box-shadow: 0 4px 24px rgba(0,0,0,0.08); padding: 48px 40px; max-width: 460px; width: 100%; text-align: center; }
    .code { font-size: 72px; font-weight: 700; color: <%= iconColor %>; line-height: 1; margin-bottom: 16px; }
    h1 { font-size: 22px; font-weight: 600; color: #1e293b; margin-bottom: 10px; }
    p { font-size: 14px; color: #64748b; line-height: 1.6; margin-bottom: 28px; }
    a { display: inline-block; padding: 10px 24px; background: #6366f1; color: #fff; text-decoration: none; border-radius: 8px; font-size: 14px; font-weight: 500; transition: background 0.2s; }
    a:hover { background: #4f46e5; }
  </style>
</head>
<body>
<div class="card">
  <div class="code"><%= errorCode %></div>
  <h1><%= heading %></h1>
  <p><%= description %></p>
  <a href="${pageContext.request.contextPath}/home">Go Back Home</a>
</div>
</body>
</html>
