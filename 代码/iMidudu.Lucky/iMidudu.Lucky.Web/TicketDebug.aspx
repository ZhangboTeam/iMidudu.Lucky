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
	<title>登记资料</title>
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
</head>
<body>  
    <%//=this.Request["QRCode"]    %>
    <%//=this.Request["wxcode"] %> 

        
<%--        openId:<%=openResponse.openid %>
        <br />
        userInfo:
        openid <%=r.openid %><br />
        country <%=r.country %><br />
        province <%=r.province %><br />
        city <%=r.city %><br />
        headimgurl <%=r.headimgurl %>
        <img src="<%=r.headimgurl %>" width="100" />
        <br />
        language <%=r.language %><br />
        nickname <%=r.nickname %><br />
        sex <%=r.sex==1?"男" :"女" %><br />
        <%-- subscribe <%=r.subscribe %><%=r.subscribe==0?"No":"Yes" %><br />
           unionid <%=r.unionid %><br />--%>
    
       <%--appId: '<%=c.appId %>',
                timestamp: <%=c.timestamp %>, 
                nonceStr: '<%=c.nonceStr %>',
                signature: '<%=c.signature %>',--%>
    <div class="container"><!-- Everything started here -->
	<img src="images/page_bg-01.png" alt="" class="bg-img-1">
	<div class="upload_invoice_modal">
		<div class="upload_inv_inner">
			<h2 class="title">发票号码<span class="sub-title">（信息供抽奖需求）</span></h2>
			<input type="text" class="inputsty mgb-sty1 background-color：fff" id="TicketNumber"  placeholder="请输入发票号码" >
            <%--<img id="Img1" width="300" />--%>
			<input type="button" class="buttonsty mgb-sty1" id="chooseImage" value="上传发票照片">
            <input type="button" id="uploadImage" value="上传小票照片" hidden  />
            <input type="button" id="downloadImage" value="下载小票照片"  hidden/> 
			<input type="button" class="buttonsty2 mgb-sty1" value="确定" onclick="goOn();">
            <%--<%= SuuSee.UserInfo.CurrentUser().data.city%>--%>
		</div>
	</div>
</div>

<%--    <input type="button" id="chooseImage" value="选择小票照片" />--%>
  <%-- <img id="preview" width="300" />--%>
<%--     <br />
    <input type="text" id="TicketNumber" />
    <br />
     <input type="button" id="ok"  value="确定" onclick="goOn();"/>--%>
    
         
    <div id="mediaid">

    </div>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
      
</body>
    <!-- Javascript with AMD  -->
    <script src="js/require.js" data-main="js/main" ></script>
</html>
