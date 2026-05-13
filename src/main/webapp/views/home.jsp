<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.omar.ecommercemvc.model.Product" %>
<%@ page import="com.omar.ecommercemvc.model.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home - ShopMVC</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --primary: #6366f1;
      --primary-hover: #4f46e5;
      --danger: #ef4444;
      --danger-hover: #dc2626;
      --warning: #f59e0b;
      --success: #22c55e;
      --bg: #f1f5f9;
      --card: #ffffff;
      --text: #1e293b;
      --muted: #64748b;
      --border: #e2e8f0;
      --radius: 12px;
    }
    body { font-family: 'Inter', sans-serif; background: var(--bg); min-height: 100vh; }
    /* Navbar */
    .navbar { background: #1e293b; padding: 0 32px; height: 60px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; }
    .navbar-brand { font-size: 18px; font-weight: 700; color: #fff; }
    .navbar-brand em { color: var(--primary); font-style: normal; }
    .navbar-right { display: flex; align-items: center; gap: 16px; }
    .navbar-right span { font-size: 13px; color: #94a3b8; }
    .badge { background: var(--warning); color: #fff; padding: 2px 8px; border-radius: 20px; font-size: 11px; font-weight: 600; }
    .btn-logout { font-size: 13px; color: #94a3b8; text-decoration: none; padding: 6px 12px; border-radius: 6px; transition: background 0.2s, color 0.2s; }
    .btn-logout:hover { background: #334155; color: #fff; }
    /* Container */
    .container { max-width: 1200px; margin: 0 auto; padding: 32px 24px; }
    .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 28px; flex-wrap: wrap; gap: 12px; }
    .page-header h1 { font-size: 24px; font-weight: 700; color: var(--text); }
    .btn { display: inline-flex; align-items: center; gap: 6px; padding: 9px 18px; border-radius: 8px; font-size: 14px; font-weight: 500; font-family: 'Inter', sans-serif; text-decoration: none; border: none; cursor: pointer; transition: background 0.2s; }
    .btn-primary { background: var(--primary); color: #fff; }
    .btn-primary:hover { background: var(--primary-hover); }
    .btn-danger { background: var(--danger); color: #fff; }
    .btn-danger:hover { background: var(--danger-hover); }
    .btn-sm { padding: 6px 12px; font-size: 12px; }
    .btn-outline { background: transparent; color: var(--primary); border: 1px solid var(--primary); }
    .btn-outline:hover { background: var(--primary); color: #fff; }
    /* Grid */
    .products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(270px, 1fr)); gap: 22px; }
    .product-card { background: var(--card); border-radius: var(--radius); overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,0.06); transition: transform 0.2s, box-shadow 0.2s; display: flex; flex-direction: column; }
    .product-card:hover { transform: translateY(-4px); box-shadow: 0 8px 24px rgba(0,0,0,0.1); }
    .product-card img { width: 100%; height: 200px; object-fit: cover; }
    .product-card .body { padding: 18px; flex: 1; display: flex; flex-direction: column; gap: 6px; }
    .product-card h3 { font-size: 16px; font-weight: 600; color: var(--text); }
    .product-card .price { font-size: 20px; font-weight: 700; color: var(--success); }
    .product-card .desc { font-size: 13px; color: var(--muted); line-height: 1.5; flex: 1; }
    .product-card .actions { display: flex; gap: 8px; flex-wrap: wrap; margin-top: 12px; }
    /* Empty */
    .empty { text-align: center; padding: 60px 20px; color: var(--muted); }
    .empty p { font-size: 16px; margin-top: 8px; }
    /* Danger zone */
    .danger-zone { margin-top: 48px; padding: 20px 24px; border: 1px solid #fecaca; border-radius: var(--radius); background: #fff5f5; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; }
    .danger-zone p { font-size: 14px; color: var(--danger); font-weight: 500; }
    .danger-zone small { display: block; font-size: 12px; color: var(--muted); font-weight: 400; margin-top: 2px; }
  </style>
</head>
<body>
<%
  User loggedInUser = (User) session.getAttribute("loggedInUser");
  List<Product> products = (List<Product>) request.getAttribute("products");
%>

<nav class="navbar">
  <div class="navbar-brand">Shop<em>MVC</em></div>
  <div class="navbar-right">
    <span>
      <%= loggedInUser.getUsername() %>
      <% if ("ADMIN".equals(loggedInUser.getRole())) { %><span class="badge">Admin</span><% } %>
    </span>
    <a class="btn-logout" href="${pageContext.request.contextPath}/logout">Logout</a>
  </div>
</nav>

<div class="container">
  <div class="page-header">
    <h1>Products</h1>
    <% if ("ADMIN".equals(loggedInUser.getRole())) { %>
      <a class="btn btn-primary" href="${pageContext.request.contextPath}/add-product">+ Add Product</a>
    <% } %>
  </div>

  <% if (products == null || products.isEmpty()) { %>
    <div class="empty">
      <p>No products available yet.</p>
    </div>
  <% } else { %>
    <div class="products-grid">
      <% for (Product p : products) { %>
        <div class="product-card">
          <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
            <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
          <% } else { %>
            <img src="https://placehold.co/270x200?text=No+Image" alt="No image">
          <% } %>
          <div class="body">
            <h3><%= p.getName() %></h3>
            <p class="price">$<%= p.getPrice() %></p>
            <p class="desc"><%= p.getDescription() != null ? p.getDescription() : "" %></p>
            <div class="actions">
              <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/product?id=<%= p.getId() %>">View</a>
              <% if ("ADMIN".equals(loggedInUser.getRole())) { %>
                <a class="btn btn-outline btn-sm" href="${pageContext.request.contextPath}/update-product?id=<%= p.getId() %>">Edit</a>
                <form action="${pageContext.request.contextPath}/delete-product" method="post" onsubmit="return confirm('Delete this product?');" style="display:inline;">
                  <input type="hidden" name="id" value="<%= p.getId() %>">
                  <button class="btn btn-danger btn-sm" type="submit">Delete</button>
                </form>
              <% } %>
            </div>
          </div>
        </div>
      <% } %>
    </div>
  <% } %>

  <div class="danger-zone">
    <div>
      <p>Delete Account</p>
      <small>This action is permanent and cannot be undone.</small>
    </div>
    <form action="${pageContext.request.contextPath}/delete-account" method="post" onsubmit="return confirm('Are you sure? This cannot be undone.');">
      <button class="btn btn-danger" type="submit">Delete My Account</button>
    </form>
  </div>
</div>
</body>
</html>
