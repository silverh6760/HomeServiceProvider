<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<body onload="getUserEmail()">
<header>
    <div class="container">
        <div id="branding">
            <h1><span class="highlight">Simin</span> Home Service</h1>
        </div>
        <nav>
            <ul>
                <li><a href="/">Home</a></li>
                <li ><a  href="/expertPage">Expert Page</a></li>
                <li  class="current"><a href="/expertPage/terminationAnnouncement"></a></li>
                <li><a href="/logout">Logout</a></li>
            </ul>
        </nav>
    </div>
</header>

<center>
    <table id="subServiceTB" class="table center w-75">
        <thead><th>ID</th><th>Name</th><th>Base Price</th><th>Description</th>
        <th>Category</th><th>Select</th></thead>

        <tbody>

        </tbody>
    </table >
</center>
<div id="ordersDiv" style="display: none">
    <center>
        <table id="ordersTB" class="table center w-75" >
            <thead><th>ID</th><th>Due Date</th><th>Task Description</th><th>Address</th>
            <th>Proposed Price</th><th>Select</th></thead>

            <tbody>

            </tbody>
        </table>
        <p id="result"></p>
    </center>

</div>
<script>
    var expertEmail;
    function getEmail(){
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                expertEmail = result;
                // $("#myId").text("Hello "+customerEmail);
                // $("#customerEmail").val(customerEmail);
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }

    function getUserEmail(){
        var table = document.getElementById("subServiceTB");
        for(var i = table.rows.length - 1; i > 0; i--)
        {
            table.deleteRow(i);
        }
        var msg="";
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                expertEmail=result;
                $("#expertEmail").val(expertEmail);
                $.ajax({
                    type:"GET",
                    url:"http://localhost:8080/expert/getAssignedSubServices/"+expertEmail,
                    success :function (result){
                        $.each(result,function(index,value){
                            msg+="<tr><td>"+value.id+"</td><td>"+value.name+"</td><td>"+value.basePrice+"</td><td>"+value.description+"</td>"+
                                "<td>"+value.services.name+"</td>"+
                                "<td><button  class=\"btn btn-sm btn-danger btnSelect2\">Orders</button></td></tr>";
                        });
                        $(msg).appendTo("#subServiceTB tbody");
                    },
                    error:function (result){
                        $("#result").text(JSON.stringify(result));
                    }
                });
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }
    var subServiceID;
    var subServiceCurrentRow
    $("#subServiceTB").on('click', '.btnSelect2', function () {
        $("#ordersDiv").css("display", "block");
        var table = document.getElementById("ordersTB");
        for(var i = table.rows.length - 1; i > 0; i--)
        {
            table.deleteRow(i);
        }
        // get the current row

        subServiceCurrentRow = $(this).closest("tr");

        subServiceID = subServiceCurrentRow.find("td:eq(0)").text();
        alert(expertEmail);
        var msg="";
        $.ajax({
            type:"GET",
            url:"http://localhost:8080/expert/getAllOrderComeHomeBySubService/"+subServiceID,
            data:{"email":expertEmail},
            success :function (result){
                $.each(result,function(index,value){
                    msg+="<tr><td>"+value.id+"</td><td>"+value.dueDate+"</td><td>"+value.taskDescription+"</td><td>"+value.address+"</td>"+
                        "<td>"+value.proposedPrice+"</td><td>"+value.orderState+
                        "</td><td><button id=\"termination\"  class=\"btn btn-sm btn-danger btnSelect3\">Announce Termination</button></td></tr>";
                });
                $(msg).appendTo("#ordersTB tbody");
            },
            error:function (result){
                $("#result").text(JSON.stringify(result));
            }
        });

    });

    $("#ordersTB").on('click', '.btnSelect3', function () {
        document.getElementById("result").innerText="";
        var orderCurrentRow = $(this).closest("tr");

        var orderId = orderCurrentRow.find("td:eq(0)").text();
        $.ajax({
            type:"PUT",
            url:"http://localhost:8080/expert/finishOrderByOrderIdEmail/"+expertEmail,
            data:{"orderId":orderId},
            success :function (result){
                $("#result").text(JSON.stringify(result));
            },
            error:function (result){
                $("#result").text(JSON.stringify(result.responseText));
            }
        });

    });
</script>
</body>
</html>
