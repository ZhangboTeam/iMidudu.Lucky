<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="mtx-app">
    <%
        var sql = "select count(1) from ScanHistory where scanhistoryid='" + this.Request["ScanHistoryId" ] + "' and not PrizeId   is null";
      //  Response.Write(sql);Response.End();
        if (iMidudu.Lucky.Web.SystemDAO.SqlHelper.Exists(sql))
        {
            Response.Write("该次扫码已失效");
            Response.End();
        }
         %>
<head runat="server">
<%--    <script type="text/javascript">

        //处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外  
        function banBackSpace(e) {
            var ev = e || window.event;//获取event对象     
            var obj = ev.target || ev.srcElement;//获取事件源     

            var t = obj.type || obj.getAttribute('type');//获取事件源类型    

            //获取作为判断条件的事件类型  
            var vReadOnly = obj.getAttribute('readonly');
            var vEnabled = obj.getAttribute('enabled');
            //处理null值情况  
            vReadOnly = (vReadOnly == null) ? false : vReadOnly;
            vEnabled = (vEnabled == null) ? true : vEnabled;

            //当敲Backspace键时，事件源类型为密码或单行、多行文本的，  
            //并且readonly属性为true或enabled属性为false的，则退格键失效  
            var flag1 = (ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea")
                        && (vReadOnly == true || vEnabled != true)) ? true : false;

            //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效  
            var flag2 = (ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea")
                        ? true : false;

            //判断  
            if (flag2) {
                return false;
            }
            if (flag1) {
                return false;
            }
        }

        //禁止后退键 作用于Firefox、Opera  
        document.onkeypress = banBackSpace;
        //禁止后退键  作用于IE、Chrome  
        document.onkeydown = banBackSpace;

</script> --%> 
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
        var deg = -67;
        var old_p_idx = 0;
        var prize = ["thanks", "kinder", "thanks", "kxt", "bag", "thanks", "kxt", "bag", "thanks", "kxt"];
        var prize = ["2eda98cd-326d-4da8-8a26-23aca4482717", "2eda98cd-326d-4da8-8a26-23aca4482711", "2eda98cd-326d-4da8-8a26-23aca4482717", "2eda98cd-326d-4da8-8a26-23aca4482712", "2eda98cd-326d-4da8-8a26-23aca4482713", "2eda98cd-326d-4da8-8a26-23aca4482717", "2eda98cd-326d-4da8-8a26-23aca4482712", "2eda98cd-326d-4da8-8a26-23aca4482713", "2eda98cd-326d-4da8-8a26-23aca4482717", "2eda98cd-326d-4da8-8a26-23aca4482712"];

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
    <%--<%=this.Request["ScanHistoryId" ]%>,
    <%=this.Request["QRCode" ]%>--%>
<div class="container"><!-- Everything started here -->
	<div class="get_prc_content">
		<div class="layout-top">
			<img src="images/get_prc_layout_top.png" alt="">
		</div>
			<div class="turntable">
				<img src="images/circle-3.png" alt="" width="100%">
				<div class="rotate ubox">
					<div class="rotate-cont"  onclick="beginLottery();">
						<img src="images/circle-4.png" alt="" width="100%">
						<div class="rotate-arrow">
							<img src="images/circle-5.png" class="arrow-img" alt="" style="-webkit-transform: rotate(-85deg);">
						</div>
						<div class="rotate-arrow-text">
							<img src="images/start-text.png">
						</div>
					</div>
				</div>
			<!-- <a href="#">
			<img src="images/get_prc_layout_bot.png" alt="">
			</a> -->
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
<%--<script src="js/require.js" data-main="js/main" ></script>--%>
</html>
