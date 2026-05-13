<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.omar.ecommercemvc.model.Review" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Review</title>
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
      --radius: 12px;
    }
    body { font-family: 'Inter', sans-serif; background: var(--bg); min-height: 100vh; }
    .navbar { background: #1e293b; padding: 0 32px; height: 60px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; }
    .navbar-brand { font-size: 18px; font-weight: 700; color: #fff; }
    .navbar-brand em { color: var(--primary); font-style: normal; }
    .navbar-links a { color: #94a3b8; text-decoration: none; font-size: 13px; padding: 6px 12px; border-radius: 6px; transition: background 0.2s, color 0.2s; }
    .navbar-links a:hover { background: #334155; color: #fff; }
    .container { max-width: 520px; margin: 0 auto; padding: 32px 24px; }
    .back-link { display: inline-flex; align-items: center; gap: 6px; color: var(--muted); font-size: 13px; text-decoration: none; margin-bottom: 24px; transition: color 0.2s; }
    .back-link:hover { color: var(--primary); }
    .card { background: var(--card); border-radius: var(--radius); box-shadow: 0 2px 12px rgba(0,0,0,0.06); padding: 32px; }
    .card h2 { font-size: 20px; font-weight: 600; color: var(--text); margin-bottom: 24px; }
    .form-group { margin-bottom: 16px; }
    label { display: block; font-size: 13px; font-weight: 500; color: var(--text); margin-bottom: 6px; }
    select, textarea { width: 100%; padding: 10px 14px; border: 1px solid var(--border); border-radius: 8px; font-size: 14px; font-family: 'Inter', sans-serif; color: var(--text); background: #f8fafc; outline: none; transition: border-color 0.2s, box-shadow 0.2s; }
    select:focus, textarea:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(99,102,241,0.12); background: #fff; }
    textarea { min-height: 100px; resize: vertical; }
    button[type="submit"] { width: 100%; padding: 11px; background: var(--primary); color: #fff; border: none; border-radius: 8px; font-size: 15px; font-weight: 500; font-family: 'Inter', sans-serif; cursor: pointer; transition: background 0.2s; margin-top: 4px; }
    button[type="submit"]:hover { background: var(--primary-hover); }
  </style>
</head>
<body>
<%
  Review review = (Review) request.getAttribute("review");
  String productId = (String) request.getAttribute("productId");
%>
<nav class="navbar">
  <div class="navbar-brand">Shop<em>MVC</em></div>
  <div class="navbar-links">
    <a href="${pageContext.request.contextPath}/home">Home</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
  </div>
</nav>

<div class="container">
  <a class="back-link" href="${pageContext.request.contextPath}/product?id=<%= productId %>">&#8592; Back to Product</a>

  <div class="card">
    <h2>Update Your Review</h2>

    <form action="${pageContext.request.contextPath}/update-review" method="post">
      <input type="hidden" name="reviewId" value="<%= review.getId() %>">
      <input type="hidden" name="productId" value="<%= productId %>">
      <div class="form-group">
        <label for="rating">Rating</label>
        <select name="rating" id="rating" required>
          <option value="5" <%= review.getRating() == 5 ? "selected" : "" %>>★★★★★ — Excellent</option>
          <option value="4" <%= review.getRating() == 4 ? "selected" : "" %>>★★★★☆ — Good</option>
          <option value="3" <%= review.getRating() == 3 ? "selected" : "" %>>★★★☆☆ — Average</option>
          <option value="2" <%= review.getRating() == 2 ? "selected" : "" %>>★★☆☆☆ — Poor</option>
          <option value="1" <%= review.getRating() == 1 ? "selected" : "" %>>★☆☆☆☆ — Terrible</option>
        </select>
      </div>
      <div class="form-group">
        <label for="comment">Your Review</label>
        <textarea name="comment" id="comment" placeholder="Share your experience..."><%= review.getComment() != null ? review.getComment() : "" %></textarea>
      </div>
      <button type="submit">Update Review</button>
    </form>
  </div>
</div>
</body>
</html>
