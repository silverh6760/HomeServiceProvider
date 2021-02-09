<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Orders Page</title>
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
                <li class="current"><a href="/admin/ordersSearch">Orders Search</a></li>
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
                    <th scope="row">Service Name</th>
                    <td><input id="serviceName" type="text" class="form-control form-control-sm" placeholder="Enter Service Name"></td>
                    <th>SubService Name</th>
                    <td><input id="subServiceName" type="text" class="form-control form-control-sm" placeholder="Enter SubService Name"></td>
                </tr>
                <tr>
                    <th>Due Date</th>
                    <td><input id="dueDate" type="date"
                               class="form-control form-control-sm"></td>
                    <th scope="row">Order Date</th>
                    <td><input id="orderDate" type="date"  class="form-control form-control-sm"></td>
                    <th>Order State</th>
                    <td>
                        <div class="form-group">
                            <select class="form-control  form-control-sm" id="sel1">
                                <option size="sm">--</option>
                                <option size="sm">WAITING_FOR_EXPERTS_OFFER</option>
                                <option size="sm">WAITING_FOR_EXPERT_SELECTION</option>
                                <option size="sm">WAITING_FOR_EXPERT_TO_COME</option>
                                <option size="sm">FINISHED</option>
                            </select>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </form>
    <button id="search" class="btn btn-primary">Search</button>
    <div class="w-75 p-3">
        <table id="tb" class="table">
            <thead>
            <th>Orders ID</th>
            <th>SubService Name</th>
            <th>Service Name</th>
            <th>Due Date</th>
            <th>Order Date</th>
            <th>Order Status</th>
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
        var serviceName = $("#serviceName").val();
        var subServiceName = $("#subServiceName").val();
        var dueDate=$("#dueDate").val();
        var orderDate=$("#orderDate").val();
      //   if($("#dueDate").val()!==null){
      //       var date=$("#dueDate").val();
      //       var dueDate =new Date(date);
      //   }
      // if($("#orderDate").val()!==null){
      //     var date2=$("#orderDate").val();
      //     var orderDate = new Date(date2);
      // }
        var orderStatus = null;
        if($("#sel1").val() != "--"){
            orderStatus = $("#sel1").val();
        }

        var arr = {orderDate:orderDate, dueDate:dueDate, orderState:orderStatus, subServices:{name: subServiceName,services:{name:serviceName}}};
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/orders/search",
            data: JSON.stringify(arr),
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                $.each(result, function (index, value) {
                    msg += "<tr><td>" + value.id + "</td><td>" + value.subServices.name + "</td><td>" + value.subServices.services.name + "</td><td>" + value.dueDate +
                        "</td><td>" + value.orderDate + "</td><td>" + value.orderState + "</td>" +
                      "</tr>";
                });
                $(msg).appendTo("#tb tbody");
                //$("#myId").text(JSON.stringify(result));
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    });
</script>
</body>
</html>
