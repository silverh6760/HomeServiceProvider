<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 1/19/2021
  Time: 12:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Home</title>
</head>
<body>
<h2>
    <c:if test="${not empty user }" >
        <p>Hello ${user.name}</p>
    </c:if>

    <c:if test="${empty user }">
        <p>Hello guest</p>
    </c:if>

</h2>
<a href="/home/loginPage">Login</a>
<a href="/logout">logout</a>
</body>
</html>
