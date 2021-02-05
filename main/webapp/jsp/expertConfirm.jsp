<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 1/17/2021
  Time: 2:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>
    <c:if test="${not empty expert}" >
        <p>Hello ${expert.name}.Wait for admin Confirmation.</p>
    </c:if>

    <c:if test="${empty expert }">
        <p>Hello guest</p>
    </c:if>

</h2>
</body>
</html>
