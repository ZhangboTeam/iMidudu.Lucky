<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="mtx-app">
<head runat="server">
    <!-- 
* 开发人员书写规范:
* 1.所有缩进都用 TAB， 而不是空格。
* 2.非必要，禁止用行内样式例如 <div style="display:block"> 
 -->
	<!-- Basic Page Needs
	================================================== -->
	<meta charset="utf-8">
	<title>抽奖大转盘</title>
	<meta name="description" content="">
	<meta name="author" content="J.Chen">
	<!-- 让360双核浏览器用webkit内核渲染页面 !!! 注意，这行最好放在前面，防止浏览器开始解析的时候采用其它内置的渲染方案
	================================================== -->
	<meta name="renderer" content="webkit">
	<!-- 让IE浏览器用最高级内核渲染页面 还有用 Chrome 框架的页面用webkit 内核
	================================================== -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<!-- IOS6全屏 Chrome高版本全屏
	================================================== -->
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="mobile-web-app-capable" content="yes"> 
	<!-- Mobile Specific Metas
	================================================== -->
	<!-- !!!注意 minimal-ui 是IOS7.1的新属性，最小化浏览器UI，但是在iOS8.1突然被取消 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<!-- 指定苹果设备添加到主屏的标题 -->
	<meta name="apple-mobile-web-app-title" content="title2">
	<!-- CSS
	================================================== -->
	<link href="css/reset.css" rel="stylesheet" type="text/css">
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<!-- Favicons
	================================================== -->
	<link rel="shortcut icon" href="favicon.ico" >
	<!-- Android 主屏图标
	================================================== -->	
	<link rel="icon" sizes="196x196" href="touch-icon.png">
	<!-- IOS 主屏图标
	================================================== -->
	<link rel="apple-touch-icon" href="touch-icon-iphone.png">
	<link rel="apple-touch-icon" sizes="76x76" href="touch-icon-ipad.png">
	<link rel="apple-touch-icon" sizes="120x120" href="touch-icon-iphone-retina.png">
	<link rel="apple-touch-icon" sizes="152x152" href="touch-icon-ipad-retina.png">
	
	<!-- Tile icon for Win8 (144x144 + tile color) -->
	<!-- win 8 磁贴图标 -->
	<meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">
	<!-- win 8 磁贴颜色 -->
	<meta name="msapplication-TileColor" content="#3372DF">
	<meta http-equiv="Cache-Control" content="no-siteapp">
    <script src="js/jquery.min.js"></script>
    <script src="js/json2.js"></script>
    <script>
        function beginLottery() {
            var data = { QRCode: '<%=this.Request["QRCode" ]%>' };

            var str = JSON.stringify(data);
            //alert(str);
            //window.location.href = '/LotteryResult/Activity1/Result1.aspx';
            //return;
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/PrizeLottery",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    var prize = result.d;
                    SavePrize(prize);
                },
                error: function (e) {
                    //alert("PrizeLottery");
                    //alert("PrizeLottery" + e.responseText);
                    $("#msg").html(e.responseText);
                }
            });
        }
        function SavePrize(prize) {
            var data = { ScanHistoryId: '<%=this.Request["ScanHistoryId" ]%>', PrizeId: prize.PrizeId };

            var str = JSON.stringify(data);
            //alert(str);
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/SavePrize",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    prize.URL = "/LotteryResult/Activity1/Result.aspx";
                    window.location.href = prize.URL + "?ScanHistoryId=" + data.ScanHistoryId + "&PrizeId=" + data.PrizeId;
                },
                error: function (e) {
                    alert("SavePrize wrong");
                    alert(e.responseText);
                }
            });
        }

    </script>
</head>
<body>
    <%--<%=this.Request["ScanHistoryId" ]%>,
    <%=this.Request["QRCode" ]%>--%>
    <div class="container"><!-- Everything started here -->
	<div class="get_prc_content">
		<div class="layout-top">
			<img src="images/get_prc_layout_top.png" alt="">
		</div>
		<div class="layout-bot">
			<a href="#"><img src="images/get_prc_layout_bot.png" alt="" onclick="beginLottery();"></a>
		</div>
	</div>
</div>

    <%--<div style="width:400px;height:400px;">
        抽奖大转盘
    </div>
    <div id="msg"></div>--%>
    <%--<input id="beginLottery" type="button" value="开始抽奖" onclick="beginLottery();" />--%>

</body>
    <!-- Javascript with AMD  -->
<script src="js/require.js" data-main="js/main" ></script>
</html>
