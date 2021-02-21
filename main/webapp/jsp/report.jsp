<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> Report Page of Admin</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
</head>
<body>
<header>
    <div class="container">
        <div id="branding">
            <h1><span class="highlight">Simin</span> Home Service</h1>
        </div>
        <nav>
            <ul>
                <li><a href="/">Home</a></li>
                <li><a href="/admin">Admin</a></li>
                <li class="current"><a href="/admin/report">Report</a></li>
                <li><a href="/logout">Log Out</a></li>
            </ul>
        </nav>
    </div>
</header>
<div class="btn-group" role="group" aria-label="Basic example">
    <button type="button" class="btn btn-primary"><a href="/admin/report/expertReport" style="color:white">Expert Report</a></button>
    <button type="button" class="btn btn-primary"><a href="/admin/report/userReport" style="color:white">User Report</a></button>
</div>
</body>
</html>
