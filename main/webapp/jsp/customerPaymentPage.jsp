<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="refresh" content="600;http://localhost:8080/customer/expirePaymentPage" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">

    <style>
        .capbox {
            background-color: #BBBBBB;
            background-image: linear-gradient(#BBBBBB, #9E9E9E);
            border: #2A7D05 0px solid;
            border-width: 2px 2px 2px 20px;
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            display: inline-block;
            padding: 5px 8px 5px 8px;
            border-radius: 4px 4px 4px 4px;
        }

        .capbox-inner {
            font: bold 12px arial, sans-serif;
            color: #000000;
            background-color: #E3E3E3;
            margin: 0px auto 0px auto;
            padding: 3px 10px 5px 10px;
            border-radius: 4px;
            display: inline-block;
            vertical-align: middle;
        }

        #CaptchaDiv {
            color: #000000;
            font: normal 25px Impact, Charcoal, arial, sans-serif;
            font-style: italic;
            text-align: center;
            vertical-align: middle;
            background-color: #FFFFFF;
            user-select: none;
            display: inline-block;
            padding: 3px 14px 3px 8px;
            margin-right: 4px;
            border-radius: 4px;
        }

        #CaptchaInput {
            border: #38B000 2px solid;
            margin: 3px 0px 1px 0px;
            width: 105px;
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

    <div class="w-25">
        <p>Timer: <h3 id="counter"></h3></p>
    </div>

<div class="container">
    <div class="row">
        <div class="col-xs-12 col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        Payment Details
                    </h3>
                </div>
                <div class="panel-body">
                    <form role="form">
                        <div class="form-group">
                            <label for="cardNumber">
                                CARD NUMBER</label>
                            <div class="input-group">
                                <input  type="text" class="form-control" id="cardNumber" placeholder="Valid Card Number"
                                       required autofocus />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-7 col-md-7">
                                <div class="form-group">
                                    <label for="expireMonth">
                                        EXPIRY DATE</label>
                                    <div class="col-xs-6 col-lg-6 pl-ziro">
                                        <input type="number" class="form-control" id="expireMonth" placeholder="MM" required />
                                    </div>
                                    <div class="col-xs-6 col-lg-6 pl-ziro">
                                        <input type="number" class="form-control" id="expireYear" placeholder="YY" required /></div>
                                </div>
                            </div>
                            <div class="col-xs-5 col-md-5 pull-right">
                                <div class="form-group">
                                    <label for="cvCode">
                                        CV CODE</label>
                                    <input type="password" class="form-control" id="cvCode" placeholder="CV" required />
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <ul class="nav nav-pills nav-stacked">
                <li class="active"><a href="#"><span class="badge pull-right"><span class="glyphicon glyphicon-usd"></span>${bill.amount}</span> Final Payment</a>
                </li>
            </ul>
            <br/>
            <!-- START CAPTCHA -->
            <br>
            <div class="capbox">

                <div id="CaptchaDiv"></div>

                <div class="capbox-inner">
                    Type the number:<br>

                    <input type="hidden" id="txtCaptcha">
                    <input type="text" name="captchaInput" id="captchaInput" size="15"><br>

                </div>
            </div>
            <br><br>
            <!-- END CAPTCHA -->

            <a class="btn btn-success btn-lg btn-block" id="payBtn" role="button">Pay</a>
        </div>
    </div>
</div>

    <p id="result"></p>

</center>

<script type="text/javascript">

    var cardNumber=false;
    var cvNumber=false;
    var expireMonth=false;
    var expireYear=false;
    var captchaInput=false;
    var captchaValid=false;


    var timer2 = "10:01";
    var interval = setInterval(function() {
        var timer = timer2.split(':');
        //by parsing integer, I avoid all extra string processing
        var minutes = parseInt(timer[0], 10);
         var seconds = parseInt(timer[1], 10);
        --seconds;
        minutes = (seconds < 0) ? --minutes : minutes;
        if (minutes < 0) clearInterval(interval);
        seconds = (seconds < 0) ? 59 : seconds;
        seconds = (seconds < 10) ? '0' + seconds : seconds;
        //minutes = (minutes < 10) ?  minutes : minutes;
        $('#counter').html(minutes + ':' + seconds);
        timer2 = minutes + ':' + seconds;
    }, 1000);



    // Captcha Script

    $("#payBtn").click(function(){
         var card=$("#cardNumber").val();
        var L = card.length;
        if (L < 16 || parseInt(code.substr(1, 10), 10) == 0 || parseInt(code.substr(10, 6), 10) == 0) {
            cardNumber=false;
        }
        else{
            cardNumber=true;
        }
        var cv=$("#cvCode").val();
        var ASCIICode = (cv.which) ? cv.which : cv.keyCode
        if (ASCIICode > 31 && cv.length>4 && (ASCIICode < 48 || ASCIICode > 57)){ cvNumber= false;}
        else {
            cvNumber = true;
        }
        var exMonth=$("#expireMonth").val();
        if(exMonth<0 || exMonth>31){
            expireMonth=false
        }
        else{
            expireMonth=true;
        }
        var exYear=$("#expireYear").val();
        if(exYear<0 || exYear>12){
            expireYear=false
        }
        else{
            expireYear=true;
        }
        var why = "";

        if($("#captchaInput").value == ""){
            why += "- Please Enter CAPTCHA Code.\n";
        }
        if($("#captchaInput").value != ""){
            validCaptcha();
            if(captchaValid == false){
                why += "- The CAPTCHA Code Does Not Match.\n";
            }
        }
        if(why != ""){
            alert(why);
            captchaInput=false;
        }

        if(cardNumber==true){
            if(cvNumber==true){
                if(expireYear==true){
                    if(expireMonth==true){
                        if(captchaValid==true){

                            $.ajax({
                                type: "POST",
                                url: "http://localhost:8080/bill/payBill/" + ${bill.id},
                                data:{"amount":${bill.amount}},
                                success: function (result) {

                                    $("#result").text(JSON.stringify(result));
                                },
                                error: function (result) {
                                    $("#result").text(JSON.stringify(result.responseText));
                                }
                            });
                        }
                        else{
                            alert("Captcha error");
                        }
                    }
                    else{
                        alert("Month Error");
                    }
                }
                else {
                    alert("Year Error");
                }
            }
            else {
                alert("CV Error");
            }
        }
        else{
            alert("Card Number Error");
        }

        <%--$.ajax({--%>
        <%--    type: "POST",--%>
        <%--    url: "http://localhost:8080/bill/payBill/" + ${bill.id},--%>
        <%--    data:{"amount":${bill.amount}},--%>
        <%--    success: function (result) {--%>

        <%--        $("#result").text(JSON.stringify(result));--%>
        <%--    },--%>
        <%--    error: function (result) {--%>
        <%--        $("#result").text(JSON.stringify(result.responseText));--%>
        <%--    }--%>
        <%--});--%>
    });


    function checkCaptcha(){
        var why = "";

        if($("#captchaInput").value == ""){
            why += "- Please Enter CAPTCHA Code.\n";
        }
        if($("#captchaInput").value != ""){
            validCaptcha();
            if(captchaValid == false){
                why += "- The CAPTCHA Code Does Not Match.\n";
            }
        }
        if(why != ""){
            alert(why);
            captchaInput=false;
        }
    }

    var a = Math.ceil(Math.random() * 9)+ '';
    var b = Math.ceil(Math.random() * 9)+ '';
    var c = Math.ceil(Math.random() * 9)+ '';
    var d = Math.ceil(Math.random() * 9)+ '';
    var e = Math.ceil(Math.random() * 9)+ '';

    var code = a + b + c + d + e;
    document.getElementById("txtCaptcha").value = code;
    document.getElementById("CaptchaDiv").innerHTML = code;

    // Validate input against the generated number
    function validCaptcha(){
        var str1 = removeSpaces(document.getElementById('txtCaptcha').value);
        var str2 = removeSpaces(document.getElementById('captchaInput').value);
        if (str1 == str2){
            // return true;
            captchaValid=true;
        }else{
            // return false;
            captchaValid=false;
        }
    }

    // Remove the spaces from the entered and generated code
    function removeSpaces(string){
        return string.split(' ').join('');
    }
</script>
</body>
</html>
