<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Assign Service | Admin</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<form>
    <div class="w-75 t-3 s-3 e-3  align-items-center" id="expertDiv">
        <table class="table">
            <tbody>
            <h2>Select Expert To Assign Services:</h2>
            <tr>
                <th scope="row">Name</th>
                <td><input id="name" type="text" class="form-control form-control-sm" placeholder="Enter Name"></td>
                <th>Family</th>
                <td><input id="family" type="text" class="form-control form-control-sm" placeholder="Enter Family"></td>
                <th scope="row">Email</th>
                <td><input id="email" type="text" class="form-control form-control-sm" placeholder="Enter Email"></td>
            </tr>
            <tr>
                <th>Service</th>
                <td><input id="subService" type="text" class="form-control form-control-sm" placeholder="Enter Service"></td>
                <th scope="row">Score</th>
                <td><input id="score" type="text" class="form-control form-control-sm" placeholder="Enter Score"></td>
                <th>Confirmation State</th>
                <td>
                    <div class="form-group">
                        <select class="form-control  form-control-sm" id="sel1">
                            <option size="sm">--</option>
                            <option size="sm">CONFIRMED</option>
                            <option size="sm">WAITING_TO_BE_CONFIRMED</option>
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
    <table id="expertTB" class="table">
        <thead>
        <th>Expert ID</th>
        <th>Name</th>
        <th>Family</th>
        <th>Email</th>
        <th>Confirmation State</th>
        <th>Select</th>
<%--        <th>Score</th>--%>
        </thead>

        <tbody>

        </tbody>
    </table>
</div>



<div class="w-75 t-3 s-3 e-3  align-items-center" id="serviceDiv" style="display: none" >
    <form>
        <div class="w-75 t-3 s-3 e-3  align-items-center">
            <table class="table">
                <tbody>
                <tr>
                    <th scope="row">Name</th>
                    <td><input id="serviceName" type="text" class="form-control form-control-sm" placeholder="Enter Name"></td>
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

    <table id="serviceTB" class="table center">
        <thead><th>Service ID</th><th>Name</th><th>Base Price</th><th>Description</th>
        <th>Category</th><th>Select</th><th>Operation</th></thead>

        <tbody>

        </tbody>
    </table>
    <br>
    <button id="select" class="btn btn-primary">Assign</button>
</div>


<div class="w-75 t-3 s-3 e-3  align-items-center" id="expertsOfServiceDiv" style="display: none" >
    <table id="expertServiceTB" class="table center">
        <thead>
        <th>Expert ID</th>
        <th>Name</th>
        <th>Family</th>
        <th>Email</th>
        <th>Operation</th>
        </thead>

        <tbody>

        </tbody>
    </table>
</div>

<p id="myId"></p>


<script>

    /*********Search of Expert********/
    $("#search").click(function () {
        var msg = "";
        var table = document.getElementById("expertTB");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        var email = $("#email").val();
        var name = $("#name").val();
        var family = $("#family").val();
        var subService = $("#subService").val();
        var score = $("#score").val();
        var confirmationState = null;
        if($("#sel1").val() != "--"){
            confirmationState = $("#sel1").val();
        }

        var arr = {name:name, family:family, email:email, confirmationState:confirmationState, score:score, subServicesList:[{name: subService}]};
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/expert/search",
            data: JSON.stringify(arr),
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                $.each(result, function (index, value) {
                    msg += "<tr><td>" + value.id + "</td><td>" + value.name + "</td><td>" + value.family + "</td><td>" + value.email +
                        "</td><td>" + value.confirmationState + "</td>" +
                        "<td> <input class=\"form-check-input radioB\" type=\"radio\" name=\"flexRadioDefault\" onchange=\"changeHandler()\"></td></tr>";
                });
                $(msg).appendTo("#expertTB tbody");
                //$("#myId").text(JSON.stringify(result));
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    });

    /*************End of Expert Search***************/
    var expertID;
    function changeHandler(){
        $("#serviceDiv").css("display", "block");
        var currentRow= $('input[name="flexRadioDefault"]:checked').closest('tr');
        expertID=currentRow.find("td:eq(0)").text();
    }

    /**************get all Sub Services**********/

    $("#getAll").click(function () {
        var msg = "";
        var table = document.getElementById("serviceTB");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        var name = $("#serviceName").val();
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
                    msg += "<tr><td>" + value.id + "</td><td>" + value.name + "</td><td>" + value.basePrice + "</td><td>" + value.description +
                        "</td><td>" + value.services.name + "</td>" +
                        "<td><input type=\"checkbox\" class=\"form-check-input checkbox\" id=\"check\" name=\"option\" value=\"something\"></td>" +
                        "<td><button  class=\"btn btn-sm btn-danger btnSelect1\">Experts</button></td>" +
                        "</tr>";
                });
                $(msg).appendTo("#serviceTB tbody");
                //$("#myId").text(JSON.stringify(result));
            },
            error: function (result) {
                //$("#myId").text(JSON.stringify(result));
            }
        });
    });


    $("#select").click(function () {
        var arrayOfRows=new Array();
        $("#serviceTB input[type=checkbox]:checked").each(function () {
            arrayOfRows.push($(this).closest('tr'));
        });
        if (arrayOfRows.length == 0) {
            alert("You should select at least one item!");
        }
        else{
            var i=0;
            for(i=0;i<arrayOfRows.length;i++){
                var currentRow=arrayOfRows[i];
                var subServiceName = currentRow.find("td:eq(1)").text();
                //alert(parseInt(expertId));
                $.ajax({
                    type:"POST",
                    url:"http://localhost:8080/expert/assignService/"+parseInt(expertID),
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

    // $(".radioB").click(function () {
    //     alert("test");
    // });
    // $('input:radio[name="flexRadioDefault"]').change(function(){
    //     alert("test");
    //     if ($(this).val() == 'Yes') {
    //         //true
    //     }
    //     else {
    //         //false
    //     }
    // });
    // $("input:radio[id=radio1]").click(function() {
    //     alert("test");
    //         console.log("salam");
    // })
    // $('#expertTB tbody :radio[name="flexRadioDefault"]').change(function() {
    //     alert("test");
    //     console.log("salam");
    // });
    //     $('input:radio').OnChange(function(){
    //         // if($(this).val() == 'Yes'){
    //             alert("test");
    //         // }
    //     });


    // $(".radioB").click(function (){
    //     $("#serviceDiv").css("display", "block");
    //     document.getElementById("myId").innerText="Hello";
    // });

    // $(".radioB").attr('checked', 'checked').each(function (){
    //     $("#serviceDiv").css("display", "block");
    //     document.getElementById("myId").innerText="Hello";
    // });

</script>
<!---------DELETE MODAL--------------->
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
                <p>Are You Sure You Want to Delete the Ticket?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">CLOSE</button>
                <button type="button" id="deleteTicket" class="btn btn-danger" data-dismiss="modal">DELETE</button>
            </div>
        </div>
    </div>
</div>
<script>
    /*******delete expert from Services********************/
    // $("#tb").on('click', '.btnSelect2', function () {
    //     // get the current row
    //     var currentRow = $(this).closest("tr");
    //
    //     var ticketId = currentRow.find("td:eq(0)").text(); // get current row 1st TD value
    //
    //     $("#deleteTicket").click(function (){
    //
    //         $.ajax({
    //             type:"DELETE",
    //             url:"http://localhost:8080/TicketHibernate_war/api/tickets/"+parseInt(ticketId),
    //             success :function (result){
    //                 currentRow.remove();
    //             },
    //             error:function (result){
    //                 document.getElementById("myId").innerText = JSON.stringify(result);
    //             }
    //         });
    //
    //     });
    //
    // });
</script>
<!---------------------------------->
</body>
</html>
