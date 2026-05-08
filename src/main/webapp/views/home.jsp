<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>Home</title>
</head>
<body>

<h1>
  Welcome
  ${sessionScope.loggedInUser.username}
</h1>

<a href="${pageContext.request.contextPath}/views/auth/login.jsp">
  Login
</a>

<br><br>

<a href="${pageContext.request.contextPath}/views/auth/register.jsp">
  Register
</a>

</body>
</html>