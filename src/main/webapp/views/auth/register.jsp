<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>Register</title>
</head>
<body>

<h2>Register</h2>

<form action="${pageContext.request.contextPath}/register"
      method="post">

  <input type="text"
         name="username"
         placeholder="Username"
         required>

  <br><br>

  <input type="email"
         name="email"
         placeholder="Email"
         required>

  <br><br>

  <input type="password"
         name="password"
         placeholder="Password"
         required>

  <br><br>

  <button type="submit">
    Register
  </button>

</form>

</body>
</html>