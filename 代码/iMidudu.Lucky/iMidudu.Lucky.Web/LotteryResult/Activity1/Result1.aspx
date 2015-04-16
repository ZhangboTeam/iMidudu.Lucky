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
	<title>手机验证</title>
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
	<link href="/css/reset.css" rel="stylesheet" type="text/css">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
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
	<meta name="msapplication-TileImage" content="/images/touch/ms-touch-icon-144x144-precomposed.png">
	<!-- win 8 磁贴颜色 -->
	<meta name="msapplication-TileColor" content="#3372DF">
	<meta http-equiv="Cache-Control" content="no-siteapp">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/json2.js"></script>
    <script>
        function sendValidCode() {
            var Mobile = $("#Mobile").val();
            $("#smsCode").attr("disabled", true);
            var data = { mobile: Mobile };
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/SendValidCodeToMobile",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    var r = $(result).text();
                    //var rr = JSON.parse(r);
                    //if (rr.code != 0) {
                    //     $("#r").html("短信验证码已发送到手机:" + m);
                         var count = 60;
                         var iii = setInterval(function () {
                             $("#smsCode").attr("disabled", true);
                             $("#smsCode").val(count);
                             $("#r").html(--count);
                             if (count == 0) {
                                 $("#smsCode").removeAttr("disabled");
                                 $("#smsCode").val("获取验证码");
                                      clearInterval(iii); $("#r").html("");
                                }
                             }, 1000);
                      //}
                      //else {
                      //     alert(rr.msg);
                      //}
                },
                error: function (result) {
                    alert(result.responseText);
                }
            });
        }
        function AcceptInsert() {
            var UserName = $("#UserName").val();
            var Sex = $("input[name=Sex]:checked").val();
            var Mobile = $("#Mobile").val();
            var ValidCode = $("#Code").val();
            var Address = $("#Address").val();
            var ScanHistoryId = $("#ScanHistoryId").val();
            if (UserName == "") {
                alert("请输入姓名"); return;
            }
            if (Mobile == "") {
                alert("请输入手机"); return;
            }
            if (ValidCode == "") {
                alert("请输入验证码"); return;
            }
            if (Address == "") {
                alert("请输入地址"); return;
            }
            var data = {
                UserName: UserName,
                Sex: Sex,
                Mobile: Mobile,
                ValidCode: ValidCode,
                Address: Address,
                ScanHistoryId: ScanHistoryId
            };
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/InsertAccept",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    //alert(result.d);
                    //var r = $(data).text();

                    if (result.d == 1) {
                        alert("验证码不正确");
                        //window.location.reload();
                    } else {
                        window.location.href = "/BigPrizeNum.aspx";
                    }
                }
            })
        }
    </script>
</head>
<body>
    <input id="ScanHistoryId" value="<%=this.Request["ScanHistoryId"]  %>" type="hidden" />
<%--  ScanHistoryId:  <%=this.Request["ScanHistoryId" ]%>,
   PrizeId: <%=this.Request["PrizeId" ]%>
    <hr />
    抽奖结果1
    <hr />--%>
    <div class="container"><!-- Everything started here -->
	<div class="ckp-content">
		<img src="images/bot-pic-01.png" alt="" class="bot-pic">
		<div class="ckp-top-img-wrap">
			<img src="/images/top-pic-01.png" alt="">
		</div>
		<form action="" class="ckp-form">
			<div class="inner">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<th>姓名</th>
							<td><input type="text" class="inputsty" id="UserName"></td>
						</tr>
						<tr>
							<th>性别</th>
							<td class="hasRadioSty">
								<input type="radio" name="Sex"  value="1" checked="checked">
								<label for="radio" style="margin-right:20px">男</label>
								<input type="radio" name="Sex"  value="0">
								<label for="radio">女</label>
							</td>
						</tr>
						<tr>
							<th>手机号</th>
							<td><input type="text" class="inputsty" id="Mobile"></td>
						</tr>
						<tr>
							<th>地址</th>
							<td><input type="text" id="Address" class="inputsty"></td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="send-ckp">
									<input type="text" class="inputsty" id="Code" placeholder="请输入验证码">
									<input type="button" class="send_btn" id="smsCode" value="获取验证码" onclick="sendValidCode();">
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="ckp-text-sty01">验证码将在10分钟内发送到手机上，如果10分钟后没有收到验证码请重新获取验证码.</td>
						</tr>
						<tr>
							<td colspan="2" class="ckp-text-sty02">请注意：请务必填写您真实准确的姓名、手机号码及地址，否则您将无法获得奖品.</td>
						</tr>
						<tr>
							<td colspan="2" class="ckb-sub-btn">
								<input type="button" id="ok" class="button-sty2 button-sty4" onclick="AcceptInsert();" >
                                <%--<input type="button" class="button-sty2">--%>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
		<div class="clear">&nbsp;</div>
	</div>
	
</div>
</body>
    <!-- Javascript with AMD  -->
<script src="/js/require.js" data-main="/js/main" ></script>
</html>
