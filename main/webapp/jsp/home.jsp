<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 1/19/2021
  Time: 12:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>

    <title>Home</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
<%--    <link rel="stylesheet" href="/css/style.css" type="text/css">--%>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
<%--    <link href=/resources/theme/css/style.css"/" rel="stylesheet">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
          rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<style>

</style>


</head>
<body onload="serviceLoad()">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

<%--<a href="/home/loginPage">Login</a>--%>
<%--<br>--%>
<%--<a href="/logout">logout</a>--%>
<%--<br>--%>
<%--<a href="/user/register">register new user</a>--%>
<%--<br>--%>

<%--<div class="dropdown btn-group" id="serviceDiv" role="group" >--%>
<%--</div>--%>

<p id="myId"></p>
<header>
    <div class="container">
        <div id="branding">
            <h1><span class="highlight">Simin</span> Home Service</h1>
        </div>
        <nav>
            <ul>
                <li class="current"><a href="/">Home</a></li>
                <li><a href="/loginPage">Login</a></li>
                <li><a href="/user/register">Register</a></li>
            </ul>
        </nav>
    </div>
</header>

<section id="showcase">
    <div class="container">
        <div class="dropdown btn-group" id="serviceDiv" role="group" >
        </div>
        <h1>Simin Home Service Provider</h1>
        <!-- <p>The Best Services will be Served According to Your Needs...</p>  -->
    </div>
</section>
<section id="newsletter">
    <div class="container">
        <h1>Subscribe To Our Newsletter</h1>
        <form>
            <input type="email" placeholder="Enter Email">
            <button type="submit" class="button_1">Subscribe</button>
        </form>
    </div>

</section>
<section id="boxes">
    <div class="container">
        <div class="box">
            <img src="/resources/theme/images/html5.png">
            <h3>HTML5 Markup</h3>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit consectetur adipiscing elit consectetur adipiscing elit.</p>
        </div>
        <div class="box">
            <img src="/resources/theme/images/download3.png">
            <h3>CSS3 Styling</h3>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit consectetur adipiscing elit consectetur adipiscing elit.</p>
        </div>
        <div class="box">
            <img src="/resources/theme/images/download.png">
            <h3>Graphic Design</h3>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit consectetur adipiscing elit consectetur adipiscing elit.</p>
        </div>
    </div>
</section>

<footer>
    <p>Simin Web Design, Copyright &copy; 2020 </p>
</footer>
<script>
    // onclick=\"dropFunc( "+value.id+ ")\"
    var serviceName;
    function serviceLoad() {
        var msg = "";
        var msg2 = ""
        var div = document.getElementById("serviceDiv");

        $.ajax({
            type: "GET",
            url: "http://localhost:8080/ServiceManagement/allFullServices",
            async:false,
            success: function (result) {
                $.each(result, function (index, value) {
                    serviceName=value.name;
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


    function dropFunc(id){
        document.getElementById("x_"+id).innerHTML="";
        var msg2="";
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/ServiceManagement/allSubServicesByID/"+id,
            success: function (result) {

                $.each(result, function (index, value) {
                    msg2 +=
                        "<a class=\"dropdown-item\" href=\"user/subService/"+value.id+"\" >"+value.name+"</a>";
                });
                $("#x_"+id).append(msg2);
                //$(msg2).appendTo(id);
                //$("#myId").innerHTML="";


                // document.getElementById("serviceDiv").appendChild(msg);
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });

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


</script>
</body>
</html>
