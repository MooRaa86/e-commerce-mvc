<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --primary: #6366f1;
      --primary-hover: #4f46e5;
      --bg: #f1f5f9;
      --card: #ffffff;
      --text: #1e293b;
      --muted: #64748b;
      --border: #e2e8f0;
      --error: #ef4444;
      --success: #22c55e;
      --radius: 12px;
    }
    body { font-family: 'Inter', sans-serif; background: var(--bg); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
    .card { background: var(--card); border-radius: var(--radius); box-shadow: 0 4px 24px rgba(0,0,0,0.08); padding: 40px; width: 100%; max-width: 400px; }
    .logo { text-align: center; margin-bottom: 28px; }
    .logo span { font-size: 22px; font-weight: 600; color: var(--text); }
    .logo span em { color: var(--primary); font-style: normal; }
    h2 { font-size: 20px; font-weight: 600; color: var(--text); margin-bottom: 6px; text-align: center; }
    .subtitle { text-align: center; color: var(--muted); font-size: 14px; margin-bottom: 24px; }
    .alert { padding: 10px 14px; border-radius: 8px; font-size: 13px; margin-bottom: 16px; }
    .alert-error { background: #fef2f2; color: var(--error); border: 1px solid #fecaca; }
    .alert-success { background: #f0fdf4; color: var(--success); border: 1px solid #bbf7d0; }
    .form-group { margin-bottom: 16px; }
    label { display: block; font-size: 13px; font-weight: 500; color: var(--text); margin-bottom: 6px; }
    input { width: 100%; padding: 10px 14px; border: 1px solid var(--border); border-radius: 8px; font-size: 14px; font-family: 'Inter', sans-serif; color: var(--text); background: #f8fafc; transition: border-color 0.2s, box-shadow 0.2s; outline: none; }
    input:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(99,102,241,0.12); background: #fff; }
    button[type="submit"] { width: 100%; padding: 11px; background: var(--primary); color: #fff; border: none; border-radius: 8px; font-size: 15px; font-weight: 500; font-family: 'Inter', sans-serif; cursor: pointer; transition: background 0.2s; margin-top: 4px; }
    button[type="submit"]:hover { background: var(--primary-hover); }
    .footer-link { text-align: center; margin-top: 20px; font-size: 13px; color: var(--muted); }
    .footer-link a { color: var(--primary); text-decoration: none; font-weight: 500; }
    .footer-link a:hover { text-decoration: underline; }
  </style>
</head>
<body>
<div class="card">
  <div class="logo"><span>Shop<em>MVC</em></span></div>
  <h2>Welcome back</h2>
  <p class="subtitle">Sign in to your account</p>

  <% List<String> errors = (List<String>) request.getAttribute("errors"); %>
  <% if (errors != null && !errors.isEmpty()) { %>
    <% for (String err : errors) { %>
      <div class="alert alert-error"><%= err %></div>
    <% } %>
  <% } else if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">${requestScope.error}</div>
  <% } %>

  <% if ("true".equals(request.getParameter("deleted"))) { %>
    <div class="alert alert-success">Your account has been deleted successfully.</div>
  <% } %>

  <form action="${pageContext.request.contextPath}/login" method="post">
    <div class="form-group">
      <label for="email">Email</label>
      <input type="email" id="email" name="email" placeholder="you@example.com" required>
    </div>
    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" placeholder="••••••••" required>
    </div>
    <button type="submit">Sign in</button>
  </form>

  <div class="footer-link">
    Don't have an account? <a href="${pageContext.request.contextPath}/views/auth/register.jsp">Register</a>
  </div>
</div>
</body>
</html>
