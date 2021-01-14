<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Services</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="d-flex text-secondary bg-info justify-content-center p-3">
    <h1>Welcome ...</h1>
</div>

<div>
    <br>
    <button class="btn btn-primary"  data-toggle="modal" data-target="#insertModalService">Create Service</button>
    <button class="btn btn-primary"  data-toggle="modal" data-target="#insertModalSubService">Create Sub Service</button>
    <br>
    <p id="myId"></p>
</div>

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
                        <label for="insertServiceName">Service Name</label>
                        <input type="text" class="form-control" id="insertServiceName" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="insertService" class="btn btn-danger" data-dismiss="modal">Create</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------->
<!--------------INSERT Sub Service------------------>
<div class="modal" id="insertModalSubService">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Enter New Information Please...</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="insertServiceName1">Service Name</label>
                        <input type="text" class="form-control" id="insertServiceName1" required>
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
                <button type="button" id="insertSubService" class="btn btn-danger" data-dismiss="modal">Create</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------->
<script>
    /*************INSERT Service****************/
    $("#insertService").click(function (){
        var serviceName = $("#insertServiceName").val();
        var arr = {name:serviceName, category:{name:serviceName}};
        $.ajax({
            type:"POST",
            url:"http://localhost:8080/services/newService",
            data: JSON.stringify(arr),
            contentType: "application/json",
            success :function(value){
                document.getElementById("myId").innerText = JSON.stringify(value);
            },
            error:function (value){
                document.getElementById("myId").innerText = JSON.stringify(value);
            }

        });

    });
    /*****************END**********************/
    /*************INSERT Sub Service****************/
    $("#insertSubService").click(function (){
        var serviceName = $("#insertServiceName1").val();
        var subServiceName = $("#insertSubServiceName").val();
        var price = $("#insertPrice").val();
        var description = $("#insertDescription").val();
        var arr = {name:subServiceName, basePrice:price, description:description, subCategory:{name:subServiceName}, services:{name:serviceName}};
        $.ajax({
            type:"POST",
            url:"http://localhost:8080/services/newSubService",
            data: JSON.stringify(arr),
            contentType: "application/json",
            success :function(value){
                document.getElementById("myId").innerText = JSON.stringify(value);
            },
            error:function (value){
                document.getElementById("myId").innerText = JSON.stringify(value);
            }

        });

    });
    /*****************END**********************/
</script>
</body>
</html>
