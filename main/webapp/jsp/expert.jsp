
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Affordable and professional web design of Simin ">
    <meta name="keywords" content="simin web design,affordable web design,professional web design">
    <meta name="author" content="Simin Hedayati">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
    <title>Expert Page | Welcome</title>
</head>
<body onload="adminFunction()">
<header>
    <div class="container">
        <div id="branding">
            <h1><span class="highlight">Simin</span> Home Service</h1>
        </div>
        <nav>
            <ul>
                <li ><a href="/">Home</a></li>
                <li class="current"><a href="/expertPage/assignSubService">Assign SubService</a></li>
                <li><a href="/expertPage">Expert Page</a></li>
                <li><a href="/logout">Log Out</a></li>
            </ul>
        </nav>
    </div>
</header>
    <security:authorize access="isAuthenticated()">
       Hello <security:authentication property="principal.username" />
    </security:authorize>
    <span id="spa"></span>
<center>
<form>
    <div class="w-75 t-3 s-3 e-3  align-items-center">
        <table class="table">
            <tbody>
            <tr>
                <th scope="row">Name</th>
                <td><input id="name" type="text" class="form-control form-control-sm" placeholder="Enter Name"></td>
                <th>Price</th>
                <td><input id="price" type="text" class="form-control form-control-sm" placeholder="Enter Base Price"></td>
                <th scope="row">Description</th>
                <td><input id="description" type="text" class="form-control form-control-sm" placeholder="Enter Description"></td>
            </tr>
            <tr>
                <th>Service</th>
                <td><input id="service" type="text" class="form-control form-control-sm" placeholder="Enter Service Name"></td>
            </tr>
            </tbody>
        </table>
    </div>
</form>
</center>
<center>
<button id="getAll" class="btn btn-primary">Search SubServices</button><br>

<table id="tb" class="table center w-75">
    <thead><th>Name</th><th>Base Price</th><th>Description</th>
    <th>Category</th><th>Select</th></thead>

    <tbody>

    </tbody>
</table>
    <button id="select" class="btn btn-primary">Select</button>
</center>
<br>


<p id="myId"></p>
<br>
<center>
<button id="getExpertSubService" class="btn btn-primary">See Assigned SubServices</button><br>

<table id="assignedSubServicesTB" class="table center w-75">
    <thead><th>SubService ID</th><th>Name</th><th>Base Price</th><th>Description</th>
    <th>Category</th><th>Operation</th></thead>

    <tbody>

    </tbody>
</table>
</center>
<p id="result"></p>

<script>
    var expertEmail;

    /**********get expert email****************/
    function adminFunction(){
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                expertEmail=result;
                alert(expertEmail);
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }

    $("#spa").append(expertEmail);
    /********Get All Sub Services********************/
    $("#getAll").click(function () {
        var msg = "";
        var table = document.getElementById("tb");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        var name = $("#name").val();
        var price = $("#price").val();
        var description = $("#description").val();
        var service = $("#service").val();


        var arr = {name:name, basePrice:price, description:description, services:{name:service}};
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/ServiceManagement/search",
            data: JSON.stringify(arr),
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                $.each(result, function (index, value) {
                    msg += "<tr><td>" + value.name + "</td><td>" + value.basePrice + "</td><td>" + value.description +
                        "</td><td>" + value.services.name + "</td>" +
                        "<td><input type=\"checkbox\" class=\"form-check-input checkbox\" id=\"check\" name=\"option\" value=\"something\"></td></tr>";
                });
                $(msg).appendTo("#tb tbody");
                //$("#myId").text(JSON.stringify(result));
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    });

    /************get Assigned SubServices*******/

    $("#getExpertSubService").click(function(){
        var msg="";
        var table = document.getElementById("assignedSubServicesTB");
        for(var i = table.rows.length - 1; i > 0; i--)
        {
            table.deleteRow(i);
        }
        $.ajax({
            type:"GET",
            url:"http://localhost:8080/expert/getAssignedSubServices/"+expertEmail,
            success :function (result){
                $.each(result,function(index,value){
                    msg+="<tr><td>"+value.id+"</td><td>"+value.name+"</td><td>"+value.basePrice+"</td><td>"+value.description+"</td>"+
                        "<td>"+value.services.name+"</td>"+
                        "<td><button  class=\"btn btn-sm btn-danger btnSelect2\" data-toggle=\"modal\" data-target=\"#deleteModal\">Delete</button></td></tr>";
                });
                $(msg).appendTo("#assignedSubServicesTB tbody");
            },
            error:function (result){
                $("#result").text(JSON.stringify(result));
            }
        });

    });

    /********Check Box Checked Event********************/

    $("#select").click(function () {
        var arrayOfRows=new Array();
        $("#tb input[type=checkbox]:checked").each(function () {
            arrayOfRows.push($(this).closest('tr'));
        });
        if (arrayOfRows.length == 0) {
            alert("You should select at least one item!");
        }
        else{
            var i=0;
            for(i=0;i<arrayOfRows.length;i++){
                var currentRow=arrayOfRows[i];
                var subServiceName = currentRow.find("td:eq(0)").text();
                //alert(parseInt(expertId));
                $.ajax({
                    type:"POST",
                    url:"http://localhost:8080/expert/assignService/"+expertEmail,
                    data: {"subServiceName":subServiceName},
                    dataType:"json",
                    //contentType: 'application/json; charset=utf-8',
                    success :function(value){
                        document.getElementById("myId").innerText = JSON.stringify(value.responseText);
                        document.getElementById("myId").innerText = "\n";

                    },
                    error:function (value){
                        document.getElementById("myId").append(JSON.stringify(value.responseText));
                        document.getElementById("myId").append("\n");
                    }

                });

            }
            document.getElementById("myId").innerText="";
        }
    });


    // $(".checkbox").change(function() {
    //     if(this.checked) {
    //         arrayOfRows.push($(this).closest('tr'));
    //     }
    // });
</script>
<div class="modal" id="deleteModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Are You Sure You Want to Delete the Subservice?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">CLOSE</button>
                <button type="button" id="deleteExpertFromSub" class="btn btn-danger" data-dismiss="modal">DELETE</button>
            </div>
        </div>
    </div>
</div>
<script>
    /*******delete expert from Services********************/
    var subServiceID;
    var subServiceCurrentRow
    $("#assignedSubServicesTB").on('click', '.btnSelect2', function () {
        // get the current row
        subServiceCurrentRow = $(this).closest("tr");

        subServiceID = subServiceCurrentRow.find("td:eq(0)").text();
    });// get current row 1st TD value

    $("#deleteExpertFromSub").click(function (){

        $.ajax({
            type:"DELETE",
            url:"http://localhost:8080/expert/deleteOneExpertsOfOneSubService/"+parseInt(subServiceID),
            data:{"expertEmail":expertEmail},
            success :function (result){
                subServiceCurrentRow.remove();
                document.getElementById("result").innerText = JSON.stringify(result);
            },
            error:function (result){
                document.getElementById("result").innerText = JSON.stringify(result);
            }
        });

    });
</script>
</body>
</html>
