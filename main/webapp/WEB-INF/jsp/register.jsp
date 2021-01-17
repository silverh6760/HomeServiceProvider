<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 12/4/2020
  Time: 11:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <title>Register User</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<h3>Welcome, Enter The User Details</h3>


<form:form method="POST" name="form" action="/user/register" modelAttribute="user"
           enctype="multipart/form-data" onsubmit="return validate() ;" >
    <table>
        <tr>
            <td><form:label path="name">Name</form:label></td>
            <td><form:input id="name" path="name" name="name" required="true"  /></td>
        </tr>
        <tr>
            <td><form:label path="family">Family</form:label></td>
            <td><form:input id="family" path="family" required="true"/></td>
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
            <td><form:select path="userRole" items="${userRoleList}" required="true"/></td>
            <td><form:errors path="userRole" cssClass="error" /></td>
        </tr>
        <tr>
            <td><label >Photo</label></td>
            <td><input type="file" name="image" accept="image/jpg" required="true" /></td>
        </tr>
        <tr>
            <td><input id="submit" type="submit" value="Submit" onclick="return checkEmail();"/>Register</td>
        </tr>
    </table>
</form:form>

<%--    <button id="getAll" type="button">Get All</button>--%>
    <p id="result"></p>
<%--<img src="/@{${user.photoImagePath}}"  alt=""/>--%>
<script>
    // function disableSubmitButton(){
    //     //document.getElementById("submit").disabled = true;
    // }
    // $("#getAll").click( function(){
    //     $.ajax({
    //         type:"GET",
    //         url:"http://localhost:8080/user/allUsers",
    //         success :function (result){
    //             console.log("hello");
    //             console.log(result);
    //             console.log(result.name);
    //             document.getElementById("result").innerText = JSON.stringify(result);
    //         },
    //         error:function (result){
    //             $("#result").text(JSON.stringify(result));
    //         }
    //     });
    // });
    /*************check email****************/
    // $("#email").change(function(){
    //     $("#email").on("input", function () {
            //alert("The text has been changed.");

    var emailValid;
    var passwordValid;

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
                //alert(" ggg"+email);
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8080/user/checkEmail",
                    data: JSON.stringify(arr),
                    contentType: 'application/json; charset=utf-8',
                    success: function (result) {
                        if (result == false) {
                            emailValid=false;
                            document.getElementById("result1").innerText = "the email already exists!!";
                            $("#email").css({
                                border: "3px red solid"
                            });

                        } else {
                            $("#email").css({
                                border: "3px green solid"
                            });
                            document.getElementById("result1").innerText = "";
                           emailValid=true;
                        }
                    },
                    error: function (result) {
                        // $("#result").text(JSON.stringify(result));
                    }
                });
         });

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
        function validate(){
            if(passwordValid===true && emailValid===true){

                return true;}
            else{
                if(emailValid===false && passwordValid===true){
                    $("#email").focus();
                }
                else if(passwordValid===false && emailValid===true){
                    $("#password").focus();
                }
                else if(passwordValid===false && emailValid===false){
                    $("#email").focus();
                }
                return false;
                }
        }

</script>
</body>
</html>
