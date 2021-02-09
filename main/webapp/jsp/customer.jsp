<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
          rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
            crossorigin="anonymous"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"
            integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"
            integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj"
            crossorigin="anonymous"></script>
    <title>Customer Page</title>
</head>
<body onload="serviceLoad();getEmail();checkBill();">
<header>
    <div class="container">
        <div id="branding">
            <h1><span class="highlight">Simin</span> Home Service</h1>
        </div>
        <nav>
            <ul>
                <li><a href="/">Home</a></li>
                <li class="current"><a href="/customer">Customer Page</a></li>
                <li >
                    <a id="billPageLi" style="display: none" href="/customer/customerBillPage">Customer Bill Page</a></li>
                <li><a href="/logout">Log Out</a></li>
            </ul>
        </nav>
    </div>
</header>

<%--<div class="btn-group" role="group" aria-label="Basic example">--%>
<%--    <button type="button" class="btn btn-secondary"><a href="#">See Services</a></button>--%>
<%--    <button type="button" class="btn btn-secondary" id="ordersBtnw">See Orders</button>--%>
<%--</div>--%>
<div class="dropdown btn-group" id="serviceDiv" role="group" >
</div>

<button type="button"  class="btn btn-secondary" id="allCustomerOrdersBtn">See All Orders</button>
<button type="button" class="btn btn-secondary" id="ordersBtn">Select Experts For Orders</button>

<%--    <security:authorize access="isAuthenticated()">--%>
<%--        Hello <security:authentication property="principal.username" />--%>
<%--
</security:authorize>--%>
<center>
<br>
<p id="myId" style="float: right"></p>
<br>
</center>
    <br>

<div id="allOrdersDiv">
    <center>
        <table id="allOrdersTB" class="table center w-75" >
            <thead><th>ID</th><th>Due Date</th><th>Task Description</th><th>Address</th>
            <th>Proposed Price</th><th>SubService Name</th><th>Order State</th></thead>

            <tbody>

            </tbody>
        </table>
    </center>
</div>

<div id="ordersDiv">
    <center>
        <table id="ordersTB" class="table center w-75" >
            <thead><th>ID</th><th>Due Date</th><th>Task Description</th><th>Address</th>
            <th>Proposed Price</th><th>SubService Name</th><th>Select</th></thead>

            <tbody>

            </tbody>
        </table>
    </center>
</div>

<p id="result"></p>

<p>${message}</p>
<script>

var customerEmail;
/********** get email *****************/
    function getEmail(){
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                customerEmail = result;
                $("#myId").text("Hello "+customerEmail);
                $("#customerEmail").val(customerEmail)
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/bill/checkCustomerBill/"+customerEmail,
                    async:false,
                    success: function (result) {
                        if(result===true){
                            $("#billPageLi").css("display","block");
                            $("#billPageLi").focus();
                            alert("You have Bills to pay!");
                        }
                    },
                    error: function (result) {
                        $("#myId").text(JSON.stringify(result));
                    }
                });
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }
    /*********** check Bill*****************/
    function checkBill(){
        // alert("salam");
        // $("#billPageLi").css("display","none");
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/bill/checkCustomerBill/"+customerEmail,
            async:false,
            success: function (result) {
                if(result===true){
                    $("#billPageLi").css("display","block");
                    $("#billPageLi").css("color","blue");
                    alert("You have Bills to pay!");
                }
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }
/********** service load *****************/
    function serviceLoad() {
        var msg = "";
        var div = document.getElementById("serviceDiv");

        $.ajax({
            type: "GET",
            url: "http://localhost:8080/ServiceManagement/allFullServices",
            async:false,
            success: function (result) {
                $.each(result, function (index, value) {
                    msg +=
                        "<button class=\"btn btn-secondary dropdown-toggle\"  type=\"button\" onclick=\"dropFunc( "+value.id+ ")\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n" +
                        value.name +
                        "</button>"+"<div class=\"dropdown-menu\"  id=\"x_"+value.id+"\"></div>"
                });

                $(msg).appendTo("#serviceDiv");
                // document.getElementById("serviceDiv").appendChild(msg);
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }
    // onclick=\"makeOrder( "+value.id+ ")\"

    function dropFunc(id){
        document.getElementById("x_"+id).innerHTML="";
        var msg2="";
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/ServiceManagement/allSubServicesByID/"+id,
            success: function (result) {
                $.each(result, function (index, value) {
                    msg2 +=
                        "<a class=\"dropdown-item\" onclick=\"makeOrder( "+value.id+ ")\" >"+value.name+"</a>";
                });
                $("#x_"+id).append(msg2);
                // $(msg2).appendTo("#x_"+id);
                //$("#myId").innerHTML="";


                // document.getElementById("serviceDiv").appendChild(msg);
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }


    function makeOrder(subId){

                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/ServiceManagement/getOneSubService/"+subId,
                    success: function (result) {
                           $("#subServiceId").val(result.id);
                    },
                    error: function (result) {
                        $("#myId").text(JSON.stringify(result));
                    }
                });
        $('#orderModal').modal('show');

    }

    $(document).ready(function(){
        // Show hide popover
        $(".dropdown-toggle").click(function(){
            //  $(this).find(".dropdown-menu").slideToggle();
            $('.dropdown-toggle').dropdown()
        });
    });
    // function myFunction(){
    //     $('.dropdown-toggle').dropdown()
    // }

    $(document).on("click", function (event) {
        $('.dropdown-toggle').dropdown('hide')
    });





    <%--function orderModalPopUp(){--%>
    <%--    &lt;%&ndash;var subServiceId=${subServiceByID.id};&ndash;%&gt;--%>
    <%--    $.ajax({--%>
    <%--        type: "GET",--%>
    <%--        url: "http://localhost:8080/username",--%>
    <%--        success: function (result) {--%>

    <%--            customerEmail=result;--%>

    <%--            // if(subServiceId!==null){--%>
    <%--            //     $("#subServiceId").val(subServiceId);--%>
    <%--                $("#customerEmail").val(customerEmail);--%>
    <%--                // $('#orderModal').modal('show');--%>
    <%--            // }--%>

    <%--        },--%>
    <%--        error: function (result) {--%>
    <%--            $("#myId").text(JSON.stringify(result));--%>
    <%--        }--%>
    <%--    });--%>

    <%--}--%>

    /**************orders with state of expert selection ajax call*****************/
   $("#ordersBtn").click(function(){

        var table = document.getElementById("ordersTB");
        for(var i = table.rows.length - 1; i > 0; i--)
        {
            table.deleteRow(i);
        }
                var msg="";
                $.ajax({
                    type:"GET",
                    url:"http://localhost:8080/customer/orderByCustomerEmailForExpertSelection/"+customerEmail,
                    success :function (result){
                        $.each(result,function(index,value){
                            msg+="<tr><td>"+value.id+"</td><td>"+value.dueDate+"</td><td>"+value.taskDescription+"</td><td>"+value.address+"</td>"+
                                "<td>"+value.proposedPrice+"</td><td>"+value.subServices.name+
                                "</td><td><button  class=\"btn btn-sm btn-danger btnSelect2\" data-toggle=\"modal\" data-target=\"#expertOffersModal\" >Offers</button></td></tr>";
                        });
                        $(msg).appendTo("#ordersTB tbody");
                    },
                    error:function (result){
                        $("#result").text(JSON.stringify(result));
                    }
                });

    });
    $("#allCustomerOrdersBtn").click(function(){
       // $("#ordersDiv").css("display", "none");

        var table = document.getElementById("allOrdersTB");
        for(var i = table.rows.length - 1; i > 0; i--)
        {
            table.deleteRow(i);
        }
        var msg="";
        $.ajax({
            type:"GET",
            url:"http://localhost:8080/customer/allOrdersByCustomerEmail/"+customerEmail,
            success :function (result){
                $.each(result,function(index,value){
                    msg+="<tr><td>"+value.id+"</td><td>"+value.dueDate+"</td><td>"+value.taskDescription+"</td><td>"+value.address+"</td>"+
                        "<td>"+value.proposedPrice+"</td><td>"+value.subServices.name+"</td><td>"+value.orderState+
                        "</td></td></tr>";
                });
                $(msg).appendTo("#allOrdersTB tbody");
            },
            error:function (result){
                $("#result").text(JSON.stringify(result));
            }
        });

    });
</script>
<!----Offer Modal---->
<div class="modal" id="orderModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Make an Order</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form:form method="POST" name="form" action="/customer/order" modelAttribute="orders" onsubmit="return validate();" >
                    <table>
                        <tr>
                            <td><label>Due Date</label></td>
                            <td><input type="date" id="dueDate" name="userDate" required="true"/></td>
                        </tr>
                        <tr>
                            <td><form:label path="taskDescription">Task Description</form:label></td>
                            <td><form:input id="taskDescription" path="taskDescription" required="true"/></td>
                        </tr>
                        <tr>
                            <td><form:label path="address">Address</form:label></td>
                            <td><form:input id="address" path="address" required="true" /></td>
                        </tr>
                        <tr>
                            <td><form:label path="proposedPrice">Price</form:label></td>
                            <td><form:input type="number" id="proposedPrice" path="proposedPrice" required="true" /></td>
                        </tr>
                    </table>
                    <form:input type="hidden" path="customer.email" id="customerEmail"/>
                    <form:input type="hidden" path="subServices.id" id="subServiceId"/>
                    <input id="submit" type="submit" value="Submit" />
                </form:form>
            </div>
            <div class="modal-footer">
                <button  id="insertServiceBtn" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>


    $("#ordersTB").on('click', '.btnSelect2', function () {
        var table = document.getElementById("expertsOffersTB");
        for(var i = table.rows.length - 1; i > 0; i--)
        {
            table.deleteRow(i);
        }
        // get the current row

        var ordersCurrentRow = $(this).closest("tr");

        var orderId = ordersCurrentRow.find("td:eq(0)").text();
        var msg="";
        $.ajax({
            type:"GET",
            url:"http://localhost:8080/customer/orderOffer/"+orderId,
            success :function (result){
                $.each(result,function(index,value){
                    msg+="<tr><td>"+value.id+"</td><td>"+value.expert.name+"</td><td>"+value.expert.score+"</td><td>"+value.proposedPrice+"</td>"+
                        "<td>"+value.durationOfWork+"</td><td>"+value.startHour+"</td>"+
                        "<td><button  class=\"btn btn-sm btn-danger btnSelect3\">Select</button></td></tr>";
                });
                $(msg).appendTo("#expertsOffersTB tbody");
            },
            error:function (result){
                $("#result").text(JSON.stringify(result));
            }
        });
    });
</script>
<!----Experts' Offers Modal---->
<div class="modal" id="expertOffersModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Enter New Information Please...</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <div  id="expertOffersTB" >
                    <table id="expertsOffersTB" class="table center">
                        <thead>
                        <th>Offer ID</th>
                        <th>Expert</th>
                        <th onclick="">Expert Score</th>
                        <th onclick="">Price</th>
                        <th>Duration Of Work</th>
                        <th>Start Hour</th>
                        <th>Select</th>
                        </thead>

                        <tbody>

                        </tbody>
                    </table>
                    <p id="result2"></p>
                </div>
            </div>
            <div class="modal-footer">
                <%--                <button  id="insertServiceBtn" class="btn btn-danger" data-dismiss="modal">Insert</button>--%>
            </div>
        </div>
    </div>
</div>
<script>
    $("#expertsOffersTB").on('click', '.btnSelect3', function () {
        // $("#ordersDiv").css("display", "block");
        // var table = document.getElementById("expertsOffersTB");
        // for(var i = table.rows.length - 1; i > 0; i--)
        // {
        //     table.deleteRow(i);
        // }
        // get the current row

        var offerCurrentRow = $(this).closest("tr");

        var offerId = offerCurrentRow.find("td:eq(0)").text();
        $.ajax({
            type:"PUT",
            url:"http://localhost:8080/customer/order/"+offerId,
            success :function (result){
                $("#result2").text(JSON.stringify(result))
            },
            error:function (result){
                $("#result2").text(JSON.stringify(result.responseText));
            }
        });
    });
</script>
</body>
</html>
