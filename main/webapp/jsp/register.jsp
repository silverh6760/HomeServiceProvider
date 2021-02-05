<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 12/4/2020
  Time: 11:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register User</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">

    <style>
        form {
            border: 4px solid darkcyan;
            border-radius: 5px;
            height: 400px;
            width: 400px;
            background-color: darkturquoise;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;

        }

    </style>
</head>
<body>

<header>
    <div class="container">
        <div id="branding">
            <h1><span class="highlight">Simin</span> Home Service</h1>
        </div>
        <nav>
            <ul>
                <li class="current"><a href="/user">Home</a></li>
                <li><a href="/loginPage">Login</a></li>
            </ul>
        </nav>
    </div>
</header>
<center>
<h3>Register Page</h3>

<div id="divElement">
<form:form method="POST" name="form" action="/user/register" modelAttribute="user"
           enctype="multipart/form-data" onsubmit="return validate() ;" >
    <table>
        <tr>
            <td><form:label path="name">Name</form:label></td>
            <td><form:input id="name" path="name" name="name" required="true"  /><p id="nameEr"></p></td>
        </tr>
        <tr>
            <td><form:label path="family">Family</form:label></td>
            <td><form:input id="family" path="family" required="true"/><p id="familyEr"></p></td>
        </tr>
        <tr>
            <td><form:label path="email">Email</form:label></td>
            <td><form:input id="email" path="email" required="true" /><p id="result1"></p></td>
        </tr>
        <tr>
            <td><form:label path="password">Password</form:label></td>
            <td><form:input type="password" id="password" path="password" required="true" /><br><p id="result2"></p></td>
        </tr>
        <tr>
            <td>userRole :</td>
            <td><form:select onchange="myFunction()"  path="userRole" items="${userRoleList}" id="selectOption"/><p id="result3"></p></td>
            <td><form:errors path="userRole" cssClass="error" /></td>
        </tr>

    </table>
    <div id="photoTR">
        <label >Photo</label>
        <input id="imageFile" type="file" name="image" accept="image/jpg"/>
        <p id="imageResult"></p><p id="imageType"></p>
    </div><br>
    <input id="submit" type="submit" value="Submit" />
<%--    <button type="submit" id="submit" value="submit">Register</button>--%>
</form:form>
</div>
</center>

<%--    <button id="getAll" type="button">Get All</button>--%>
    <p id="result"></p>
<%--<img src="/@{${user.photoImagePath}}"  alt=""/>--%>

<!--ERROR Handling-->
<h2>${message}</h2>
<h2>${message2}</h2>

<script>
    var imageFile=$("#imageFile").val();
    var userRoleValid=false;
    var emailValid;
    var passwordValid;
   var maxFileSize=true;
   var imageFormat=true;
   var nameSize;
   var familySize;

    /*************check name Input****************/
    $("#name").on("input", function () {
       if( $(this).val().length>10){
           document.getElementById("nameEr").innerText = "the size of name should upto 10!!";
           nameSize=false;
       }else{
           document.getElementById("nameEr").innerText = "";
           nameSize=true;
       }
    });
    /*************check family Input****************/
    $("#family").on("input", function () {
        if( $(this).val().length>20){
            document.getElementById("familyEr").innerText = "the size of family should upto 20!!";
            familySize=false;
        }else{
            document.getElementById("familyEr").innerText = "";
            familySize=true;
        }
    });

    /*************check user Role****************/
    function myFunction() {
        if($("#selectOption").val() === "--") {
            document.getElementById("result3").innerText = "the User Role is Null!!";
            userRoleValid = false;
        }else{
            document.getElementById("result3").innerText ="";
            userRoleValid=true;
        }
        if($("#selectOption").val() !== "EXPERT" ){
             $("#photoTR").css("display", "none");
            $("#imageFile").prop('required',false);
        }else if($("#selectOption").val() === "EXPERT"){
            $("#photoTR").css("display", "block");
            $("#imageFile").prop('required',true);
        }
    }
    /*************check image size and format****************/
    $('#imageFile').bind('change', function() {
        if(this.files[0].size>512000){
            document.getElementById("imageResult").innerText = "the size is wrong!!";
            maxFileSize=false;
        }
        else{
            document.getElementById("imageResult").innerText ="";
            maxFileSize=true;
        }
        if (!(this.files && this.files[0] && this.files[0].name.match(/\.(jpg)$/)) ){
            document.getElementById("imageType").innerText ="the format is wrong!";
            imageFormat=false;
        }
        else{
            document.getElementById("imageType").innerText ="";
            imageFormat=true;
        }

        //this.files[0].size gets the size of your file.

    });

    /*************check email****************/


    $("#email").on("input", function () {

                var email = $("#email").val();
                var name = $("#name").val();
                var family = $("#family").val();
                var password = $("#password").val();
                var userRole = $("#userRole").val();
                var arr = {
                    name: "name",
                    family: "family",
                    email: email,
                    password: "123",
                    userRole: "ADMIN",
                    enabled: false
                };
                var pattern = /^\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i
                if(!pattern.test(email)){
                    document.getElementById("result1").innerText = "the email format is wrong!!";
                    emailValid = false;
                }
                else {
                    //alert(" ggg"+email);
                    $.ajax({
                        type: "POST",
                        url: "http://localhost:8080/user/checkEmail",
                        data: JSON.stringify(arr),
                        contentType: 'application/json; charset=utf-8',
                        success: function (result) {
                            if (result == false) {
                                emailValid = false;
                                document.getElementById("result1").innerText = "the email already exists!!";
                                $("#email").css({
                                    border: "3px red solid"
                                });

                            } else {
                                $("#email").css({
                                    border: "3px green solid"
                                });
                                document.getElementById("result1").innerText = "";
                                emailValid = true;
                            }
                        },
                        error: function (result) {
                            // $("#result").text(JSON.stringify(result));
                        }
                    });
                }
         });
    /*************check password****************/

        $("#password").on("input", function () {
            //alert("The text has been changed.");
            var email = $("#email").val();
            var name = $("#name").val();
            var family = $("#family").val();
            var password = $("#password").val();
            var userRole = $("#userRole").val();
            var arr = {
                name: "name",
                family: "family",
                email: "email",
                password: password,
                userRole: "ADMIN",
                enabled: false
            };
            $.ajax({
                type: "POST",
                url: "http://localhost:8080/user/checkPassword",
                data: JSON.stringify(arr),
                contentType: 'application/json; charset=utf-8',
                success: function (result) {
                    if (result == false) {
                        document.getElementById("result2").innerText = "the password format is wrong!";
                        $( "#password" ).css({
                            border: "3px red solid"
                        });
                        passwordValid= false;
                    } else {
                        $("#password").css({
                            border: "3px green solid"
                        });
                        document.getElementById("result2").innerText = "";
                      passwordValid=true;

                        //document.getElementById("submit").disabled = false;
                    }
                },
                error: function (result) {
                    // $("#result").text(JSON.stringify(result));
                }
            });
        });
    /*************check file size****************/
    // $("#imageFile").on("input", function () {
    //
    //     if(imageFile===null){
    //         emptyFile=true;
    //         document.getElementById("imageResult").innerText = "choose a photo!!";
    //     }
    //
    //     $.ajax({
    //         type:"POST",
    //         url:"http://localhost:8080/user/checkFileSize",
    //         data: {"multipartFile":imageFile},
    //         dataType:"json",
    //         //contentType: 'application/json; charset=utf-8',
    //         success :function(value){
    //             if(value===false){
    //                 document.getElementById("imageResult").innerText = "Maz Size Limit Exceeds!!";
    //                 maxFileSize=false;
    //             }else {
    //                 document.getElementById("imageResult").innerText ="";
    //                 maxFileSize=true;
    //             }
    //
    //         },
    //         error:function (value){
    //             // document.getElementById("myId").append(JSON.stringify(value.responseText));
    //             // document.getElementById("myId").append("\n");
    //         }
    //
    //     });
    // });

    /*************validate****************/
        function validate(){
            if(userRoleValid!==false) {
                    if (passwordValid === true && emailValid === true &&
                        userRoleValid === true && maxFileSize===true &&
                        imageFormat===true && nameSize===true && familySize===true) {
                        return true;
                    } else {
                        if (emailValid === false && passwordValid === true) {
                            $("#email").focus();
                        } else if (passwordValid === false && emailValid === true) {
                            $("#password").focus();
                        } else if (passwordValid === false && emailValid === false) {
                            $("#email").focus();
                        } else if (passwordValid === true && emailValid === false) {
                            $("#email").focus();
                        }

                        return false;
                    }
                return true;
            }
            else {
                document.getElementById("result3").innerText = "the User Role is Null!!";
                return false;

            }
        }

</script>
<footer>
    <p>Simin Web Design, Copyright &copy; 2020 </p>
</footer>
</body>
</html>
