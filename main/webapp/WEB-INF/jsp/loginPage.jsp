<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 1/19/2021
  Time: 12:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Login | Home Service Provider</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<p>Login</p>
<p>${login_error}</p>
<form method="post" name="form" action="/doLogin" >
    <div class="w-25">
        <div class="form-group">
            <label for="email">Email address</label>
            <input type="email" class="form-control" id="email" name="email"  aria-describedby="emailHelp" placeholder="Enter email" required="true"/>
            <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password"  placeholder="Password" required="true"/>
        </div>
<%--        <div class="form-check">--%>
<%--            <input type="checkbox" class="form-check-input" id="exampleCheck1">--%>
<%--            <label class="form-check-label" for="exampleCheck1">Check me out</label>--%>
<%--        </div>--%>
        <button type="submit" id="submit" class="btn btn-primary">Submit</button>
    </div>
</form>

<a href="/home">Home</a>
<%--<form:form method="post" name="form" action="/home/login" modelAttribute="user">--%>
<%--    <div class="w-25">--%>
<%--        <div class="form-group">--%>
<%--            <label for="email">Email address</label>--%>
<%--            <form:input type="email" class="form-control" id="email" path="email" aria-describedby="emailHelp" placeholder="Enter email" required="true"/>--%>
<%--            <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>--%>
<%--        </div>--%>
<%--        <div class="form-group">--%>
<%--            <label for="password">Password</label>--%>
<%--            <form:input type="password" class="form-control" id="password" path="password" placeholder="Password" required="true"/>--%>
<%--        </div>--%>
<%--        <div class="form-check">--%>
<%--            <input type="checkbox" class="form-check-input" id="exampleCheck1">--%>
<%--            <label class="form-check-label" for="exampleCheck1">Check me out</label>--%>
<%--        </div>--%>
<%--        <button type="submit" id="submit" class="btn btn-primary">Submit</button>--%>
<%--    </div>--%>
<%--</form:form>--%>
</body>
</html>
