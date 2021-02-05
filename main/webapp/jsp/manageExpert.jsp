
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
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
                <li><a href="/home">Home</a></li>
                <li><a href="/admin">Admin</a></li>
                <li class="current"><a href="/admin/manageExpert">Manage Expert</a></li>
                <li><a href="/logout">Log Out</a></li>
            </ul>
        </nav>
    </div>
</header>

<button type="button" class="btn btn-secondary">
    <a href="/admin/manageExpert/confirmNewExpert">Confirm New Experts</a></button>
<button type="button" class="btn btn-secondary">
        <a href="/admin/manageExpert/expertSearch">Expert Search</a></button>
<button type="button" class="btn btn-secondary">
    <a href="/admin/manageExpert/expertAssignment">Expert Services Assignment</a></button>
</body>
</html>
