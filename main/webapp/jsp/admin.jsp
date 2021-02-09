<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">

</head>
<body onload="adminFunction()">

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

<div class="btn-group" role="group" aria-label="Basic example">
    <button type="button" class="btn btn-secondary"><a href="/admin/manageService" style="color:white">Manage Services</a></button>
    <button type="button" class="btn btn-secondary"><a href="/admin/manageExpert" style="color:white">Manage Experts</a></button>
    <button type="button" class="btn btn-secondary"><a href="/admin/userSearch" style="color:white">User Search</a></button>
    <button type="button" class="btn btn-primary"><a href="/admin/ordersSearch" style="color:white">Orders Search</a></button>
</div>

<script>
    function adminFunction(){
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
              alert(result);
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }
</script>

</body>
</html>