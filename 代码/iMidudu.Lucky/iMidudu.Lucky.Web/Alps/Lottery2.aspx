<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
        <%
        var sql = "select count(1) from ScanHistory where ScanHistoryId='" + this.Request["ScanHistoryId" ] + "' and not PrizeId   is null";
      //  Response.Write(sql);Response.End();
        if (iMidudu.Lucky.Web.SystemDAO.SqlHelper.Exists(sql))
        {
            Response.Write("该次扫码已失效");
            Response.End();
        }
         %>
<head id="Head1" runat="server">
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
	<link href="/Alps/css/reset.css" rel="stylesheet" type="text/css">
	<link href="/Alps/css/style.css" rel="stylesheet" type="text/css">
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
	<meta name="msapplication-TileImage" content="/Alps/images/touch/ms-touch-icon-144x144-precomposed.png">
	<!-- win 8 磁贴颜色 -->
	<meta name="msapplication-TileColor" content="#ebce74">
	<meta http-equiv="Cache-Control" content="no-siteapp">
    <script src="js/jquery.min.js"></script>
    <script src="js/json2.js"></script>
        <script>
            var deg = -67;
            var old_p_idx = 0;
            var prize = ["thanks", "bear", "thanks", "tv", "bear", "thanks", "kxt", "bear", "thanks", "kxt"];
            var prize = ["2eda98cd-326d-4da8-8a26-23aca4482727", "2eda98cd-326d-4da8-8a26-23aca4482722", "2eda98cd-326d-4da8-8a26-23aca4482727", "2eda98cd-326d-4da8-8a26-23aca4482721", "2eda98cd-326d-4da8-8a26-23aca4482722", "2eda98cd-326d-4da8-8a26-23aca4482727", "2eda98cd-326d-4da8-8a26-23aca4482723", "2eda98cd-326d-4da8-8a26-23aca4482722", "2eda98cd-326d-4da8-8a26-23aca4482727", "2eda98cd-326d-4da8-8a26-23aca4482723"];

            function getPrizeIndex(id) {
                for (var i in prize) {
                    if (prize[i] == id) {
                        return i;
                    }
                }
            }
            function pan(prize, data) {
                var _self = $(this);
                _self = $(".rotate-arrow-text img");
                //锁定按钮
                if (_self.hasClass("act")) {
                    return false;
                }
                _self.addClass('act');
                var new_p_idx = Math.floor(Math.random() * 10); //奖品索引
                new_p_idx = getPrizeIndex(data.PrizeId);
                //console.log(new_p_idx);
                deg += 1440;
                deg += (new_p_idx - old_p_idx) * 36;
                old_p_idx = new_p_idx;
                $(".arrow-img").css({
                    "-webkit-transform": "rotate(" + deg + "deg)",
                    "transform": "rotate(" + deg + "deg)"
                });

                setTimeout(function () {
                    //console.log("end");
                    //解锁按钮
                    _self.removeClass('act');
                    //alert( prize.URL + "?ScanHistoryId=" + data.ScanHistoryId + "&PrizeId=" + data.PrizeId);
                    window.location.href = prize.URL + "?ScanHistoryId=" + data.ScanHistoryId + "&PrizeId=" + data.PrizeId;
                    //var url = "price-4";
                    //switch (prize[new_p_idx]) {
                    //    case "thanks":
                    //        url = "price-4";
                    //        break;
                    //    case "kinder":
                    //        url = "price-3";
                    //        break;
                    //    case "kxt":
                    //        url = "price-2";
                    //        break;
                    //    case "bag":
                    //        url = "price-1";
                    //        break;
                    //    default: break;
                    //}
                    //location.href = url + ".html";
                }, 4000);
            }
            function beginLottery() {
                $(".rotate-cont").attr("disabled", true);
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
                    // IsExist(prize);
                    SavePrize(prize);
                },
                error: function (e) {
                    //alert("PrizeLottery");
                    //alert("PrizeLottery" + e.responseText);
                    $("#msg").html(e.responseText);
                }
            });
        }
        function IsExist() {
            var data = { ScanHistoryId: '<%=this.Request["ScanHistoryId" ]%>' };

            var str = JSON.stringify(data);
            //alert(str);
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/IsExist",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    var url = result.d;
                    //alert(url);
                    if (url == -2) {
                        beginLottery();
                    } else {
                        window.location.href = url + "?ScanHistoryId=" + data.ScanHistoryId;
                    }
                },
                error: function (e) {
                    alert("SavePrize wrong");
                    alert(e.responseText);
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
                    pan(prize, data);
                    // window.location.href = prize.URL + "?ScanHistoryId=" + data.ScanHistoryId + "&PrizeId=" + data.PrizeId;
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
<div class="container"><!-- Everything started here -->
	<div class="get_prc_content">
		<div class="layout-top">
			<img src="/Alps/images/get_prc_layout_top.png" alt="">
		</div>
			<div class="turntable">
				<img src="/Alps/images/circle-3.png" alt="" width="100%">
				<div class="rotate ubox">
					<div class="rotate-cont" onclick="IsExist();">
						<img src="/Alps/images/circle-4.png" alt="" width="100%">
						<div class="rotate-arrow">
							<table>
								<tr>
									<td><img src="/Alps/images/circle-5.png" class="arrow-img" alt="" style="-webkit-transform: rotate(-85deg);"></td>
								</tr>
							</table>
						</div>
						<div class="rotate-arrow-text">
							<table>
								<tr>
									<td><img src="/Alps/images/start-text.png"></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			<!-- <a href="#">
			<img src="images/get_prc_layout_bot.png" alt="">
			</a> -->
		</div>
	</div>
</div>

</body>
    <!-- Javascript with AMD  -->
<%--<script src="/Alps/js/require.js" data-main="/Alps/js/main" ></script>--%>
     <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <script>
<%

            var wechat = iMidudu.Lucky.Web.WebServieFactiory.WeChat;
        var c = wechat.Config(Request.Url.AbsoluteUri);%> 
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: '<%=c.appId %>', // 必填，公众号的唯一标识
                timestamp: <%=c.timestamp %>, // 必填，生成签名的时间戳
                nonceStr: '<%=c.nonceStr %>', // 必填，生成签名的随机串
                signature: '<%=c.signature %>',// 必填，签名，见附录1
                jsApiList: [ 
        'showOptionMenu' 
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
            function onBridgeReady(){
                WeixinJSBridge.call('showOptionMenu');
            }

        
            wx.ready(function () {
                if (typeof WeixinJSBridge == "undefined"){
                    if( document.addEventListener ){
                        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
                    }else if (document.attachEvent){
                        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
                        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
                    }
                }else{
                    onBridgeReady();
                }
            });
        </script>
</html>
