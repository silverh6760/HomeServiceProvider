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
    <title>Done Orders</title>
</head>
<body onload="seeDoneOrders();seeAllBills()">
<header>
    <div class="container">
        <div id="branding">
            <h1><span class="highlight">Simin</span> Home Service</h1>
        </div>
        <nav>
            <ul>
                <li><a href="/">Home</a></li>
                <li ><a href="/expertPage">Expert Page</a></li>
                <li class="current"><a href="/expertPage/seeDoneOrders">See Done Orders</a></li>
                <li><a href="/logout">Log Out</a></li>
            </ul>
        </nav>
    </div>
</header>
<center>
    <table id="doneOrdersTB" class="table center w-75">
        <thead><th>Order ID</th><th>SubService Name</th><th>Customer Name</th><th>Score</th></thead>

        <tbody>

        </tbody>
    </table>
    <br>
    <table id="expertBillTB" class="table center w-75">
        <thead><th>Bill ID</th><th>SubService Name</th><th>Customer Name</th><th>Paying Status</th></thead>

        <tbody>

        </tbody>
    </table>
    <br>
    <div class="w-25" style="background-color: aqua ; border: 1px">
        <h6>SALARY: </h6><h6 id="salary"></h6>
    </div>
    <p id="result"></p>
</center>

<script>
    var expertEmail;
    function seeDoneOrders(){
        var table = document.getElementById("doneOrdersTB");
        var table2 = document.getElementById("expertBillTB");
        for(var i = table.rows.length - 1; i > 0; i--)
        {
            table.deleteRow(i);
        }
        for(var i = table2.rows.length - 1; i > 0; i--)
        {
            table2.deleteRow(i);
        }
        var msg="";
        var msg2="";
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                expertEmail=result;
                $.ajax({
                    type:"GET",
                    url:"http://localhost:8080/expert/getCommentsForDoneOrders/"+expertEmail,
                    success :function (result){
                        $.each(result,function(index,value){
                            msg+="<tr><td>"+value.order.id+"</td><td>"+value.order.subServices.name+"</td><td>"+value.user.name+"</td><td>"+value.score+"</td>"+
                               "</tr>";
                        });
                        $(msg).appendTo("#doneOrdersTB tbody");
                    },
                    error:function (result){
                        $("#result").text(JSON.stringify(result));
                    }
                });
                $.ajax({
                            type:"GET",
                            url:"http://localhost:8080/expert/getBillsByExpert/"+expertEmail,
                            success :function (result){
                                $.each(result,function(index,value){
                                    msg2+="<tr><td>"+value.id+"</td><td>"+value.orders.subServices.name+"</td><td>"+value.orders.customer.name+"</td><td>"+value.paymentStatus+"</td>"+
                                        "</tr>";
                                });
                                $(msg2).appendTo("#expertBillTB tbody");
                            },
                            error:function (result){
                                $("#result").text(JSON.stringify(result));
                            }
                        });

                $.ajax({
                    type:"GET",
                    url:"http://localhost:8080/expert/getTotalSalary/"+expertEmail,
                    success :function (result){
                        $("#salary").append(result.balance)
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

</script>
</body>

</html>
