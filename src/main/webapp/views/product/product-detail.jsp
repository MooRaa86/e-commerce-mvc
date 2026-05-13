<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.omar.ecommercemvc.model.Product" %>
<%@ page import="com.omar.ecommercemvc.model.Review" %>
<%@ page import="com.omar.ecommercemvc.model.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Details</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --primary: #6366f1;
      --primary-hover: #4f46e5;
      --danger: #ef4444;
      --danger-hover: #dc2626;
      --success: #22c55e;
      --star: #f59e0b;
      --bg: #f1f5f9;
      --card: #ffffff;
      --text: #1e293b;
      --muted: #64748b;
      --border: #e2e8f0;
      --radius: 12px;
    }
    body { font-family: 'Inter', sans-serif; background: var(--bg); min-height: 100vh; }
    .navbar { background: #1e293b; padding: 0 32px; height: 60px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; }
    .navbar-brand { font-size: 18px; font-weight: 700; color: #fff; }
    .navbar-brand em { color: var(--primary); font-style: normal; }
    .navbar-links a { color: #94a3b8; text-decoration: none; font-size: 13px; padding: 6px 12px; border-radius: 6px; transition: background 0.2s, color 0.2s; }
    .navbar-links a:hover { background: #334155; color: #fff; }
    .container { max-width: 960px; margin: 0 auto; padding: 32px 24px; }
    .back-link { display: inline-flex; align-items: center; gap: 6px; color: var(--muted); font-size: 13px; text-decoration: none; margin-bottom: 24px; transition: color 0.2s; }
    .back-link:hover { color: var(--primary); }
    /* Product */
    .product-card { background: var(--card); border-radius: var(--radius); box-shadow: 0 2px 12px rgba(0,0,0,0.06); overflow: hidden; display: flex; gap: 0; margin-bottom: 36px; }
    .product-card img { width: 380px; min-height: 280px; object-fit: cover; flex-shrink: 0; }
    .product-info { padding: 32px; flex: 1; display: flex; flex-direction: column; gap: 12px; }
    .product-info h1 { font-size: 24px; font-weight: 700; color: var(--text); }
    .product-info .price { font-size: 28px; font-weight: 700; color: var(--success); }
    .product-info .desc { font-size: 14px; color: var(--muted); line-height: 1.7; }
    @media (max-width: 640px) { .product-card { flex-direction: column; } .product-card img { width: 100%; min-height: 220px; } }
    /* Reviews */
    .section-title { font-size: 18px; font-weight: 600; color: var(--text); margin-bottom: 16px; }
    .review-card { background: var(--card); border-radius: var(--radius); padding: 18px; box-shadow: 0 1px 6px rgba(0,0,0,0.05); margin-bottom: 14px; }
    .review-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px; }
    .review-user { font-weight: 600; font-size: 14px; color: var(--text); }
    .review-date { font-size: 12px; color: var(--muted); }
    .stars { color: var(--star); font-size: 16px; margin-bottom: 8px; letter-spacing: 2px; }
    .review-comment { font-size: 14px; color: var(--muted); line-height: 1.6; }
    .review-actions { display: flex; gap: 8px; margin-top: 12px; }
    .btn { display: inline-flex; align-items: center; padding: 6px 12px; border-radius: 6px; font-size: 12px; font-weight: 500; font-family: 'Inter', sans-serif; text-decoration: none; border: none; cursor: pointer; transition: background 0.2s; }
    .btn-primary { background: var(--primary); color: #fff; }
    .btn-primary:hover { background: var(--primary-hover); }
    .btn-danger { background: var(--danger); color: #fff; }
    .btn-danger:hover { background: var(--danger-hover); }
    .no-reviews { color: var(--muted); font-size: 14px; font-style: italic; padding: 20px 0; }
    /* Add review form */
    .add-review { background: var(--card); border-radius: var(--radius); padding: 24px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); margin-top: 24px; }
    .add-review h3 { font-size: 16px; font-weight: 600; color: var(--text); margin-bottom: 16px; }
    .form-group { margin-bottom: 14px; }
    .form-group label { display: block; font-size: 13px; font-weight: 500; color: var(--text); margin-bottom: 6px; }
    select, textarea { width: 100%; padding: 10px 14px; border: 1px solid var(--border); border-radius: 8px; font-size: 14px; font-family: 'Inter', sans-serif; color: var(--text); background: #f8fafc; outline: none; transition: border-color 0.2s, box-shadow 0.2s; }
    select:focus, textarea:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(99,102,241,0.12); background: #fff; }
    textarea { min-height: 90px; resize: vertical; }
    .btn-submit { padding: 10px 24px; background: var(--primary); color: #fff; border: none; border-radius: 8px; font-size: 14px; font-weight: 500; font-family: 'Inter', sans-serif; cursor: pointer; transition: background 0.2s; }
    .btn-submit:hover { background: var(--primary-hover); }
  </style>
</head>
<body>
<%
  Product product = (Product) request.getAttribute("product");
  List<Review> reviews = (List<Review>) request.getAttribute("reviews");
  User loggedInUser = (User) session.getAttribute("loggedInUser");
%>

<nav class="navbar">
  <div class="navbar-brand">Shop<em>MVC</em></div>
  <div class="navbar-links">
    <a href="${pageContext.request.contextPath}/home">Home</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
  </div>
</nav>

<div class="container">
  <a class="back-link" href="${pageContext.request.contextPath}/home">&#8592; Back to Products</a>

  <div class="product-card">
    <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
      <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
    <% } else { %>
      <img src="https://placehold.co/380x280?text=No+Image" alt="No image">
    <% } %>
    <div class="product-info">
      <h1><%= product.getName() %></h1>
      <p class="price">$<%= product.getPrice() %></p>
      <p class="desc"><%= product.getDescription() != null ? product.getDescription() : "No description available." %></p>
    </div>
  </div>

  <p class="section-title">Reviews (<%= reviews != null ? reviews.size() : 0 %>)</p>

  <% if (reviews == null || reviews.isEmpty()) { %>
    <p class="no-reviews">No reviews yet. Be the first to review!</p>
  <% } else { %>
    <% for (Review r : reviews) { %>
      <div class="review-card">
        <div class="review-header">
          <span class="review-user"><%= r.getUsername() %></span>
          <span class="review-date"><%= r.getCreatedAt() != null ? r.getCreatedAt().toString().substring(0, 10) : "" %></span>
        </div>
        <div class="stars">
          <% for (int i = 1; i <= 5; i++) { %><%= i <= r.getRating() ? "★" : "☆" %><% } %>
        </div>
        <p class="review-comment"><%= r.getComment() != null ? r.getComment() : "" %></p>
        <% if (loggedInUser != null && (r.getUserId().equals(loggedInUser.getId()) || "ADMIN".equals(loggedInUser.getRole()))) { %>
          <div class="review-actions">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/update-review?id=<%= r.getId() %>&productId=<%= product.getId() %>">Edit</a>
            <form action="${pageContext.request.contextPath}/delete-review" method="post" onsubmit="return confirm('Delete this review?');" style="display:inline;">
              <input type="hidden" name="id" value="<%= r.getId() %>">
              <button class="btn btn-danger" type="submit">Delete</button>
            </form>
          </div>
        <% } %>
      </div>
    <% } %>
  <% } %>

  <div class="add-review">
    <h3>Write a Review</h3>
    <form action="${pageContext.request.contextPath}/add-review" method="post">
      <input type="hidden" name="productId" value="<%= product.getId() %>">
      <div class="form-group">
        <label for="rating">Rating</label>
        <select name="rating" id="rating" required>
          <option value="5">★★★★★ — Excellent</option>
          <option value="4">★★★★☆ — Good</option>
          <option value="3">★★★☆☆ — Average</option>
          <option value="2">★★☆☆☆ — Poor</option>
          <option value="1">★☆☆☆☆ — Terrible</option>
        </select>
      </div>
      <div class="form-group">
        <label for="comment">Comment</label>
        <textarea name="comment" id="comment" placeholder="Share your experience..."></textarea>
      </div>
      <button class="btn-submit" type="submit">Submit Review</button>
    </form>
  </div>
</div>
</body>
</html>
