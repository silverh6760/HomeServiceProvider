<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
</head>
<body onload="getBills();">
<header>
    <div class="container">
        <div id="branding">
            <h1><span class="highlight">Simin</span> Home Service</h1>
        </div>
        <nav>
            <ul>
                <li ><a href="/">Home</a></li>
                <li><a href="/customer">Customer Page</a></li>
                <li class="current"><a href="/customer/customerBillPage">Customer Bill Page</a></li>
                <li><a href="/logout">Log Out</a></li>
            </ul>
        </nav>
    </div>
</header>
  <security:authorize access="isAuthenticated()">
     Hello <security:authentication property="principal.username" />
</security:authorize>
<center>
    <div id="allBillsDiv">
            <table id="allBillsTB" class="table center w-75" >
                <thead><th>ID</th><th>Amount</th><th>Expert Name</th>
                <th>Issue Date</th><th>SubService Name</th><th>PAY</th></thead>
                <tbody>

                </tbody>
            </table>
    </div>
    <p id="result"></p>
   <input type="hidden" id="customerEmail">
</center>
<script>
    // <a style='color: white' href=\"/customer/customerPaymentPage/"+value.id+"\" >PAY THE BILL</a>
    function getBills(){
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                customerEmail = result
                $("#customerEmail").val(customerEmail);
                var table = document.getElementById("allBillsTB");
                for (var i = table.rows.length - 1; i > 0; i--) {
                    table.deleteRow(i);
                }
                var msg = "";
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/bill/getAllCustomerBill/" + customerEmail,
                    success: function (result) {
                        $.each(result, function (index, value) {
                            msg += "<tr><td>" + value.id + "</td><td>" + value.amount + "</td><td>" + value.expert.name + "</td><td>" + value.issueDate + "</td>" +
                                "<td>" + value.orders.subServices.name +
                                "</td><td><button  class=\"btn btn-sm btn-primary btnSelect2\" >PAY THE BILL</button></td>" +
                                "<td><button onclick=\"makeComment( "+value.id+ ")\"  class=\"btn btn-sm btn-primary btnSelect3\" >COMMENT</button></td></tr>";

                        });
                        $(msg).appendTo("#allBillsTB tbody");
                    },
                    error: function (result) {
                        $("#result").text(JSON.stringify(result));
                    }
                });
            },
            error: function (result) {
            $("#result").text(JSON.stringify(result));
        }
    });
    }

    $("#allBillsTB").on('click', '.btnSelect2', function () {
        var billCurrentRow = $(this).closest("tr");

        var billId = billCurrentRow.find("td:eq(0)").text();
        alert(parseInt(billId));
        var url="http://localhost:8080/customer/customerPaymentPage/"+parseInt(billId);
        window.open(url,"_blank");
    });
    // $("#allBillsTB").on('click', '.btnSelect3', function () {
    //     var billCurrentRow = $(this).closest("tr");
    //
    //     var billId = billCurrentRow.find("td:eq(0)").text();
    //
    // });
</script>

<div class="modal" id="commentModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Make an Order</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form >
                    <div class="form-group">
                        <label for="expertScore">Expert Score</label>
                        <input type="number" class="form-control" id="expertScore" required autofocus>
                    </div>
                    <div class="form-group">
                        <label for="commentDescription">Example textarea</label>
                        <textarea class="form-control" id="commentDescription" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button  id="insertCommentBtn" class="btn btn-danger" data-dismiss="modal">Make a Comment</button>
            </div>
        </div>
    </div>
</div>

<script>

    function makeComment(id){
        document.getElementById("result").innerText="";
        $('#commentModal').modal('show');

        $("#insertCommentBtn").click(function (){
            var score=$("#expertScore").val();
            var description=$("#commentDescription").val();
            var array={score:score , description:description}
            $.ajax({
                type:"POST",
                url:"http://localhost:8080/comment/insertComment/"+id,
                data: JSON.stringify(array),
                contentType: "application/json",
                success :function(value){
                    document.getElementById("result").innerText = JSON.stringify(value);
                },
                error:function (value){
                    document.getElementById("result").innerText = JSON.stringify(value.responseText);
                }

            });
        });
    }
</script>

</body>
</html>
