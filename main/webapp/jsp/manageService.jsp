<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Services</title>
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
                <li  class="current"><a  href="/admin/manageService">Manage Service</a></li>
                <li><a href="/">Home</a></li>
                <li><a href="/admin">Admin</a></li>
                <li><a href="/logout">Logout</a></li>
            </ul>
        </nav>
    </div>
</header>
<center>
<h2>Manage Service</h2>

<div>
    <br>
    <button id="getBtn" class="btn btn-primary">See All Services</button>
    <button  id="insertBtn" class="btn btn-primary"  data-toggle="modal" data-target="#insertModalService">Add a New Service</button>
    <br>
</div>

<div class="w-75 p-3">
    <table id="serviceTB" class="table">
        <thead>
        <th>Service ID</th>
        <th>Name</th>
        <th>Operation</th>
        </thead>

        <tbody>

        </tbody>
    </table>
</div>
<p id="myId"></p>
</center>
<script>
    /***********get All services*************/
    $("#getBtn").click(function () {
        var msg = "";
        var table = document.getElementById("serviceTB");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/ServiceManagement/allServices",
            success: function (result) {
                $.each(result, function (index, value) {
                    msg += "<tr><td>" + value.id + "</td><td>" + value.name +
                        "<td><button class=\"btn btn-sm btn-success btnSelect\" data-toggle=\"modal\" data-target=\"#editServiceModal\">Edit</button>" +
                        "<button  class=\"btn btn-sm btn-danger btnSelect2\" data-toggle=\"modal\" data-target=\"#deleteServiceModal\">Delete</button></td></tr>";
                });
                $(msg).appendTo("#serviceTB tbody");
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    });


</script>
<!--------------INSERT Service------------------>
<div class="modal" id="insertModalService">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Enter New Information Please...</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="serviceName">Service Name</label>
                        <input type="text" class="form-control" id="serviceName" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button  id="insertServiceBtn" class="btn btn-danger" data-dismiss="modal">Insert</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------->

<script>
    var globalServiceId;
    var globalSubServiceId;
    // category:{name:serviceName}
    /*************INSERT Service****************/
    $("#insertServiceBtn").click(function (){
        var serviceName = $("#serviceName").val();
        var arr = {name:serviceName};
        var tId;
        var mess="";
        $.ajax({
            type:"POST",
            url:"http://localhost:8080/ServiceManagement/newService",
            data: JSON.stringify(arr),
            contentType: "application/json",
            success :function(value){
                tId=JSON.stringify(value);
                var h=tId.match(/\d+/g);
                mess="<tr><td>"+h+"</td><td>"+serviceName+"</td>" +
                    "<td><button class=\"btn btn-sm btn-success btnSelect\" data-toggle=\"modal\" data-target=\"#editServiceModal\">Edit</button>" +
                    "<button  class=\"btn btn-sm btn-danger btnSelect2\" data-toggle=\"modal\" data-target=\"#deleteServiceModal\">Delete</button></td></tr>";

                $(mess).appendTo("#serviceTB tbody");
            },
            error:function (value){
                document.getElementById("myId").innerText = JSON.stringify(value.responseText);
            }

        });

    });

    /*****************END**********************/
    /*****************Prefill Edit Modal for Service**********************/
    $("#serviceTB").on('click', '.btnSelect', function () {
        // get the current row
        var currentRow = $(this).closest("tr");

        var serviceId = currentRow.find("td:eq(0)").text(); // get current row 1st TD value
        var serviceName = currentRow.find("td:eq(1)").text(); // get current row 2nd TD

        globalServiceId=serviceId;
        <!-----Prefill Modal----->

        $("#newServiceName").val(serviceName);
    });
</script>

<!-- Edit Modal For Service -->
<div class="modal" id="editServiceModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Enter New Information Please...</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="newServiceName">New Service Name</label>
                        <input type="text" class="form-control" id="newServiceName">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="editServiceBtn" class="btn btn-primary" data-dismiss="modal">Edit</button>
            </div>
        </div>
    </div>
</div>
<!----------------------------------------->
<!---------DELETE MODAL--------------->
<div class="modal" id="deleteServiceModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Are You Sure You Want to Remove the Service?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteService" class="btn btn-danger" data-dismiss="modal">Remove</button>
            </div>
        </div>
    </div>
</div>


<!---------------------------------->
<script>
    /***EDIT Service in table and DB****/
    $("#editServiceBtn").click(function (){
        var tableRow = $("table td").filter(function() {
            return $(this).text() === globalServiceId;
        }).closest("tr");
        tableRow.find("td:eq(1)").text($("#newServiceName").val()); // get current row 1st TD value

        var arr = { name: $("#newServiceName").val()};
        $.ajax({
            type:"PUT",
            url:"http://localhost:8080/ServiceManagement/updateService/"+parseInt(globalServiceId),
            data: JSON.stringify(arr),
            contentType: 'application/json; charset=utf-8',
            success:function(result){
                document.getElementById("myId").innerText = JSON.stringify(result);
            },
            error:function (result){
                document.getElementById("myId").innerText = JSON.stringify(result.responseText);
            }
        });

    });
    /***Delete Service With ID in table and DB****/
    var currentSerRow;
    var currentServiceId;

    $("#serviceTB").on('click', '.btnSelect2', function () {
        document.getElementById("myId").innerText = "";
        // get the current row
        currentSerRow = $(this).closest("tr");

        currentServiceId = currentSerRow.find("td:eq(0)").text(); // get current row 1st TD value
    });
    $("#deleteService").click(function () {

        $.ajax({
            type: "DELETE",
            url: "http://localhost:8080/ServiceManagement/deleteService/" + parseInt(currentServiceId),
            async: false,
            success: function (result) {
                currentSerRow.remove();
                document.getElementById("myId").innerText = JSON.stringify(result);
            },
            error: function (result) {
                document.getElementById("myId").innerText = JSON.stringify(result.responseText);
            }
        });

    });

    /****************END*********************/



</script>


<center>
<h2>Manage Sub Service</h2>

<div>
    <br>
    <button id="getSubBtn" class="btn btn-primary">See All Sub-Services</button>
    <button  id="insertSubBtn" class="btn btn-primary"  data-toggle="modal" data-target="#insertModalSubService">Add a New Sub Service</button>
    <br>
</div>

<div class="w-75 p-3">
    <table id="subServiceTB" class="table">
        <thead>
        <th>Sub-service ID</th>
        <th>Name</th>
        <th>Base Price</th>
        <th>Description</th>
        <th>Service Name</th>
        <th>Operation</th>
        </thead>

        <tbody>

        </tbody>
    </table>
</div>
<p id="myId2"></p>
</center>

<script>
    /***********get the all subServices*************/
    $("#getSubBtn").click(function () {
        var msg = "";
        var table = document.getElementById("subServiceTB");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/ServiceManagement/allSubServices",
            success: function (result) {
                $.each(result, function (index, value) {
                    msg += "<tr><td>" + value.id + "</td><td>" + value.name +"</td><td>"+value.basePrice+"</td><td>"+
                        value.description+"</td><td>"+value.services.name+
                        "</td><td><button class=\"btn btn-sm btn-success btnSelect3\" data-toggle=\"modal\" data-target=\"#editSubServiceModal\">Edit</button>" +
                        "<button  class=\"btn btn-sm btn-danger btnSelect4\" data-toggle=\"modal\" data-target=\"#deleteSubServiceModal\">Delete</button></td></tr>";
                });
                $(msg).appendTo("#subServiceTB tbody");
            },
            error: function (result) {
                $("#myId2").text(JSON.stringify(result));
            }
        });
    });

    /***********fill the insert modal with get ajax call for services select option*************/
    $("#insertSubBtn").click(function () {
        var sel = $("#serviceSelect");
        sel.empty();
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/ServiceManagement/allServices",
            success: function (result) {
                $.each(result, function (index, value) {
                    sel.append('<option value="' + value.name + '">' + value.name + '</option>');
                });
            },
            error: function (result) {
                $("#myId2").text(JSON.stringify(result));
            }
        });
    });

</script>
<!--------------INSERT Sub Service------------------>
<div class="modal" id="insertModalSubService">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Enter New Sub-Service Info</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <select class="form-select" id="serviceSelect" aria-label="Default select example">
                            <option selected>Open this select service</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="insertSubServiceName">Sub Service Name</label>
                        <input type="text" class="form-control" id="insertSubServiceName" required>
                    </div>
                    <div class="form-group">
                        <label for="insertPrice">Sub Service Price</label>
                        <input type="text" class="form-control" id="insertPrice" required>
                    </div>
                    <div class="form-group">
                        <label for="insertDescription">Sub Service Description</label>
                        <input type="text" class="form-control" id="insertDescription" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="insertSubService" class="btn btn-danger" data-dismiss="modal">Insert</button>
            </div>
        </div>
    </div>
</div>
<!---------DELETE MODAL to Delete Sub Service--------------->
<div class="modal" id="deleteSubServiceModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Are You Sure You Want to Remove the SubService?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteSubService" class="btn btn-danger" data-dismiss="modal">Remove</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------->
<script>
    // , services:{name:serviceName}
    /*************INSERT Sub Service****************/
    $("#insertSubService").click(function (){
        var serviceName =  $("#serviceSelect").children("option:selected").val();
        var subServiceName = $("#insertSubServiceName").val();
        var price = $("#insertPrice").val();
        var description = $("#insertDescription").val();
        var arr = {name:subServiceName, basePrice:price, description:description};
        var tId;
        var mess="";
        if(parseInt(price)>0) {
            $.ajax({
                type: "POST",
                url: "http://localhost:8080/ServiceManagement/newSubService/" + serviceName,
                data: JSON.stringify(arr),
                contentType: "application/json",
                success: function (value) {
                    tId = JSON.stringify(value);
                    var h = tId.match(/\d+/g);
                    mess = "<tr><td>" + h + "</td><td>" + subServiceName + "</td><td>" + price + "</td><td>" + description + "</td><td>" + serviceName +
                        "</td><td><button class=\"btn btn-sm btn-success btnSelect3\" data-toggle=\"modal\" data-target=\"#editSubServiceModal\">Edit</button>" +
                        "<button  class=\"btn btn-sm btn-danger btnSelect4\" data-toggle=\"modal\" data-target=\"#deleteSubServiceModal\">Delete</button></td></tr>";

                    $(mess).appendTo("#subServiceTB tbody");
                },
                error: function (value) {
                    document.getElementById("myId2").innerText = JSON.stringify(value.responseText);
                }

            });
        }
        else {
            alert("the price amount is negative!")
        }

    });
    /*****************END**********************/
</script>


<script>
    /***Delete Sub Service With ID in table and DB****/
    var currentSubRow;
    var currentSubServiceId;


    $("#subServiceTB").on('click', '.btnSelect4', function () {
        document.getElementById("myId").innerText = "";
        // get the current row
         currentSubRow = $(this).closest("tr");

        currentSubServiceId = currentSubRow.find("td:eq(0)").text(); // get current row 1st TD value
    });

        $("#deleteSubService").click(function (){

            $.ajax({
                type:"DELETE",
                url:"http://localhost:8080/ServiceManagement/deleteSubService/"+parseInt(currentSubServiceId),
                async: false,
                success :function (result){
                    document.getElementById("myId2").innerText = JSON.stringify(result);
                    currentSubRow.remove();
                },
                error:function (result){
                    document.getElementById("myId2").innerText = JSON.stringify(result.responseText);
                }
            });
        });


    /****************END*********************/

    /*****************Prefill Edit Modal for Sub Service**********************/
    $("#subServiceTB").on('click', '.btnSelect3', function () {
        // get the current row
        var currentRow = $(this).closest("tr");

        var subServiceID = currentRow.find("td:eq(0)").text(); // get current row 1st TD value
        var subServiceName = currentRow.find("td:eq(1)").text(); // get current row 2nd TD
        var subServiceBasePrice = currentRow.find("td:eq(2)").text(); // get current row 2nd TD
        var subServiceDescription = currentRow.find("td:eq(3)").text(); // get current row 2nd TD

        globalSubServiceId=subServiceID;
        <!-----Prefill Modal----->

        $("#newSubServiceName").val(subServiceName);
        $("#newSubServiceBasePrice").val(subServiceBasePrice);
        $("#newSubServiceDescription").val(subServiceDescription);
    });

</script>

<!-- Edit Modal For Service -->
<div class="modal" id="editSubServiceModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Enter New Information Please...</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="newSubServiceName">New SubService Name</label>
                        <input type="text" class="form-control" id="newSubServiceName" required>
                    </div>
                    <div class="form-group">
                        <label for="newSubServiceBasePrice">New Base Price</label>
                        <input type="number" class="form-control" id="newSubServiceBasePrice" required>
                    </div>
                    <div class="form-group">
                        <label for="newSubServiceDescription">New Description</label>
                        <input type="text" class="form-control" id="newSubServiceDescription" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="editSubServiceBtn" class="btn btn-primary" data-dismiss="modal">Edit</button>
            </div>
        </div>
    </div>
</div>
<!----------------------------------------->

<script>
    /***EDIT Service in table and DB****/
    $("#editSubServiceBtn").click(function (){
        var tableRow = $("#subServiceTB td").filter(function() {
            return $(this).text() === globalSubServiceId;
        }).closest("tr");
        var price=$("#newSubServiceBasePrice").val();
        if(parseInt(price)>0) {

        tableRow.find("td:eq(1)").text($("#newSubServiceName").val()); // get current row 1st TD value
        tableRow.find("td:eq(2)").text($("#newSubServiceBasePrice").val()); // get current row 1st TD value
        tableRow.find("td:eq(3)").text($("#newSubServiceDescription").val()); // get current row 1st TD value



            var arr = {
                name: $("#newSubServiceName").val(), basePrice: price,
                description: $("#newSubServiceDescription").val()
            };
            $.ajax({
                type: "PUT",
                url: "http://localhost:8080/ServiceManagement/updateSubService/" + parseInt(globalSubServiceId),
                data: JSON.stringify(arr),
                contentType: 'application/json',
                success: function (result) {
                    document.getElementById("myId2").innerText = JSON.stringify(result);
                },
                error: function (result) {
                    document.getElementById("myId2").innerText = JSON.stringify(result.responseText);
                }
            });
        }
        else{
            alert("price is negative!")
        }

    });
</script>
</body>
</html>
