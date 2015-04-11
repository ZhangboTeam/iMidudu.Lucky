<%@ Page Language="C#"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录界面</title>

<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/animate.css" />
     
<script type="text/javascript" src="js/jquery.min.js"></script>	  
    <script src="js/queryString.js"></script>
    <script>
        $(function () {
            $("#ok").click(function(){
                Login($("#UserName").val(), $("#pwd").val(), function (success) {
                    //alert(success);
                    if (success){
                        var returnUrl = getQueryStringByName("ReturnUrl");
                        if (returnUrl != "") {
                            returnUrl = decodeURIComponent(returnUrl);
                            window.location.href = returnUrl;
                        }
                        else {
                          
                            window.location.href = "/Admin/Default.aspx";
                        }
                    }
                    else {
                        $(".errorArea").empty().html("login failed");
                    }
                }, function (err) {
                    $(".errorArea").empty().html(err.responseText);
                });
            });
        });
//"{userName:'" + username +"',password:'" +  password+ "'}"
        function Login(username, password, successHanler, failed) {
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/Login1",
                data: "{userName:'" + username + "',password:'" + password + "'}",
                dataType: 'json',
                success: function (result) {
                    if (successHanler != null) {
                        successHanler(result.d);
                    }
                }
            });
        } 
    </script>
</head>
<body>
    <canvas id="christmasCanvas" style="top: 0px; left: 0px; z-index: 5000; position: fixed; pointer-events: none;" width="1285" height="100%"></canvas>



<h2 align="center"><img  src="images/Logo_login.png"/></h2>

<div class="login_frame"></div>

<div class="LoginWindow">
	<div>
		<div class="login">
			<p><input type="text" name="id" id="UserName" placeholder="用户名" value=""/></p>
			<p><input type="password" name="password" id="pwd" placeholder="密码" value=""/></p>
			<p class="login-submit"><button type="submit" class="login-button" id ="ok">登录</button></p>
            <p class="errorArea"></p>
		</div>
	</div>
</div>
	



<script type="text/javascript">
    $(function () {
        $(".btn").click(function () {
            var left = ($(window).width() * (1 - 0.35)) / 2;//box弹出框距离左边的额距离
            var height = ($(window).height() * (1 - 0.5)) / 2;

            $(".box").addClass("animated bounceIn").show().css({ left: left, top: top });
            $(".opacity_bg").css("opacity", "0.3").show();
        });


        $(".colse").click(function () {

            var left = ($(window).width() * (1 - 0.35)) / 2;
            var top = ($(window).height() * (1 - 0.5)) / 2;
            $(".box").show().animate({
                width: "-$(window).width()*0.35",
                height: "-$(window).height()*0.5",
                left: "-" + left + "px",
                top: "-" + top + "px"
            }, 1000, function () {
                var width1 = $(window).width() * 0.35;
                var height1 = $(window).height() * 0.5;
                console.log(width1);
                $(this).css({ width: width1, height: height1 }).hide();
            });

        });
    });
</script>
</body>
</html>
