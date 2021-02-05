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
    <title>Expert Order Page</title>
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
                <li class="current"><a href="/expertPage/seeOrders">See Orders To Offer</a></li>
                <li ><a href="/expertPage">Expert Page</a></li>
                <li><a href="/logout">Log Out</a></li>
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
</center>
</div>
<p>${message}</p>
<script>
    var expertEmail;
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
        var msg="";
        $.ajax({
            type:"GET",
            url:"http://localhost:8080/expert/getOrdersByAssignedSubService/"+subServiceID,
            success :function (result){
                $.each(result,function(index,value){
                    msg+="<tr><td>"+value.id+"</td><td>"+value.dueDate+"</td><td>"+value.taskDescription+"</td><td>"+value.address+"</td>"+
                        "<td>"+value.proposedPrice+"</td>"+
                        "<td><button  class=\"btn btn-sm btn-danger btnSelect3\" data-toggle=\"modal\" data-target=\"#offerModal\">Make Offer</button></td></tr>";
                });
                $(msg).appendTo("#ordersTB tbody");
            },
            error:function (result){
                $("#result").text(JSON.stringify(result));
            }
        });

    });

    $("#ordersTB").on('click', '.btnSelect3', function () {
       var orderCurrentRow = $(this).closest("tr");

        var orderId = orderCurrentRow.find("td:eq(0)").text();
        $("#ordersId").val(orderId);
    });


</script>
<div class="modal" id="offerModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Enter New Information Please...</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form:form method="POST" name="form" action="/expertPage/seeOrders" modelAttribute="offer" onsubmit="return validate();" >
                    <table>
                        <tr>
                            <td><form:label path="proposedPrice">Proposed Price</form:label></td>
                            <td><form:input path="proposedPrice" id="proposedPrice" name="proposedPrice" required="true"/></td>
                        </tr>
                        <tr>
                            <td><form:label path="durationOfWork">Task Description</form:label></td>
                            <td><form:input type="number" id="durationOfWork" path="durationOfWork" required="true"/></td>
                        </tr>
                        <tr>
                            <td><label>Start Hour</label></td>
                            <td><input type="time" name="time" required="true" /></td>
                        </tr>

                    </table>
                    <form:input type="hidden" path="expert.email" id="expertEmail"/>
                    <form:input type="hidden" path="orders.id" id="ordersId"/>
                    <input id="submit" type="submit" value="Submit" />
                </form:form>
            </div>
            <div class="modal-footer">

            </div>
        </div>
    </div>
</div>
</body>
</html>
