<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Login</h2>

<p style="color:red;">
    ${requestScope.error}
</p>

<form action="${pageContext.request.contextPath}/login"
      method="post">

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
        Login
    </button>

</form>

</body>
</html>