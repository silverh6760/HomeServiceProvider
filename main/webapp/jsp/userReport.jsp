<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Report</title>
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
                <li><a href="/admin/report">Report</a></li>
                <li class="current"><a href="/admin/report/userReport">User Report</a></li>
                <li><a href="/logout">Log Out</a></li>
            </ul>
        </nav>
    </div>
</header>
<center>
    <form>
        <div class="w-75 t-3 s-3 e-3  align-items-center">
            <table class="table">
                <tbody>
                <tr>
                    <th scope="row">Start Date</th>
                    <td><input id="startDate" type="date" class="form-control form-control-sm" placeholder="Enter Start Date"></td>
                    <th>End Date</th>
                    <td><input id="endDate" type="date" class="form-control form-control-sm" placeholder="Enter End Date"></td>
                </tr>
                </tbody>
            </table>
        </div>
    </form>
    <button id="search" class="btn btn-primary">Search</button>
    <div class="w-75 p-3">
        <table id="tb" class="table">
            <thead>
            <th>Customer ID</th>
            <th>Customer Name</th>
            <th>Customer Family</th>
            <th>Number of Orders Registered</th>
            </thead>

            <tbody>

            </tbody>
        </table>
    </div>
    <p id="myId"></p>
</center>
<script>
    $("#search").click(function () {
        var msg = "";
        var table = document.getElementById("tb");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        var startDate=$("#startDate").val();
        var endDate=$("#endDate").val();
        var array={startDate:startDate , endDate:endDate}
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/orders/reportCustomerOrdersIssued",
            data: JSON.stringify(array),
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                $.each(result, function (index, value) {
                    msg += "<tr><td>" + value.customer.id + "</td><td>" + value.customer.name + "</td><td>" + value.customer.family +
                        "</td><td>" + value.numberOfOrders+"</td></tr>";
                });
                $(msg).appendTo("#tb tbody");
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    });
</script>
</body>
</html>
