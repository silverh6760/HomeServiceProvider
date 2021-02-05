<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 2/1/2021
  Time: 2:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
    ${subServiceByID.name}
    <title>Title</title>
    <style>
        a:link {
            color: white;
            background-color: transparent;
            text-decoration: none;
        }
        a:visited {
            color: pink;
            background-color: transparent;
            text-decoration: none;
        }
        a:hover {
            color: red;
            background-color: transparent;
            text-decoration: underline;
        }
        a:active {
            color: yellow;
            background-color: transparent;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<header>
    <div class="container">
        <div id="branding">
            <h1><span class="highlight">Simin</span> Home Service</h1>
        </div>
        <nav>
            <ul>
                <li class="current"><a href="/">Home</a></li>
                <li><a href="/loginPage">Login</a></li>
                <li><a href="/register">Register</a></li>
            </ul>
        </nav>
    </div>
</header>
    <center>
<div style="background-color: aqua" class="w-50">
    <img src="/resources/theme/images/gratisography-436H-5000.jpg " width="200px" height="200px" >
    <h3>SubService Name: ${subServiceByID.name}</h3>
    <h3>SubService Base Price: ${subServiceByID.basePrice}</h3>
    <h3>SubService Description: ${subServiceByID.description}</h3>
    <h3>${subServiceByID.description}</h3
    <button class="btn btn-secondary"><a style="text-decoration-color: white" href="/customer">Book An Order</a></button>
</div>

    </center>
</body>
</html>
