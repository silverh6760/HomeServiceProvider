<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body onload="adminFunction()">

<a href="/admin/manageService">Manage Services</a>
<br/>
<a href="/admin/manageExpert">Manage Experts</a>
<br/>
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