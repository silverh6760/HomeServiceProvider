<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 1/4/2021
  Time: 12:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Expert Page | Welcome</title>
</head>
<body>
<h2>
    <c:if test="${not empty expert }">
        <p>Hello ${expert.name}</p>
    </c:if>

    <c:if test="${empty expert }">
<%--        <script>var expertId="${expert.id}"</script>--%>
        <p>Hello guest</p>
    </c:if>

</h2>
<%--private String name;--%>
<%--private Long basePrice;--%>
<%--private String description;--%>
<%--@OneToOne--%>
<%--private SubCategory subCategory;--%>
<%--@ManyToOne--%>
<%--private Services services;--%>
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
<button id="getAll" class="btn btn-primary">Search SubServices</button><br>

<table id="tb" class="table center">
    <thead><th>Name</th><th>Base Price</th><th>Description</th>
    <th>Category</th><th>Select</th></thead>

    <tbody>

    </tbody>
</table>
<br>
<button id="select" class="btn btn-primary">Select</button>

<p id="myId"></p>


<script>
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

    // $("#getAll").click(function(){
    //     var msg="";
    //     var table = document.getElementById("tb");
    //     for(var i = table.rows.length - 1; i > 0; i--)
    //     {
    //         table.deleteRow(i);
    //     }
    //     $.ajax({
    //         type:"GET",
    //         url:"http://localhost:8080/ServiceManagement/allSubServices",
    //         success :function (result){
    //             $.each(result,function(index,value){
    //                 msg+="<tr><td>"+value.name+"</td><td>"+value.basePrice+"</td><td>"+value.description+"</td><td>"+value.subCategory.name+
    //                     "<td>"+value.services.name+"</td>"+
    //                     "<td><input type=\"checkbox\" class=\"form-check-input checkbox\" id=\"check\" name=\"option\" value=\"something\"></td></tr>";
    //             });
    //             $(msg).appendTo("#tb tbody");
    //         },
    //         error:function (result){
    //             $("#myId").text(JSON.stringify(result));
    //         }
    //     });
    //
    // });

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
                    url:"http://localhost:8080/expert/assignService/"+${expert.id},
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
</body>
</html>
