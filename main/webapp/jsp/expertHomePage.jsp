<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
    <title>Expert Home Page</title>
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
                <li><a href="/logout">Log Out</a></li>
            </ul>
        </nav>
    </div>
</header>
<center>
<div class="btn-group" role="group" aria-label="Basic example" style="color:white ">
    <button type="button" class="btn btn-secondary"><a href="/expertPage/assignSubService" style="color:white">Assign SubService</a></button>
    <button type="button" class="btn btn-secondary"><a href="/expertPage/seeOrders" style="color:white ">See Orders to Offer</a></button>
    <button type="button" class="btn btn-secondary"><a href="/expertPage/terminationAnnouncement" style="color:white ">Termination Announcement</a></button>
</div>
</center>
</body>
</html>
