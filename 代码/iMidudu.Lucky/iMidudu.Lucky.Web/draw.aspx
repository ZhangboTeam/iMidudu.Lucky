<%@ Page Language="C#"   %>
<%
    var url = "https://lucky.meduo.com.cn/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=" + System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] + "/demo.aspx&response_type=code&scope=snsapi_base&state=" + Request["bonus"];
    this.Response.Redirect(url);   
%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta charset="utf-8"/>
  <title> </title>
	<meta content="telephone=no" name="format-detection" />
	<!-- 让IE浏览器用最高级内核渲染页面 还有用 Chrome 框架的页面用webkit 内核
	================================================== -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<!-- IOS6全屏 Chrome高版本全屏
	================================================== -->
	<meta name="apple-mobile-web-app-capable" content="yes"/>
	<meta name="mobile-web-app-capable" content="yes"/> 
	<!-- 让360双核浏览器用webkit内核渲染页面
	================================================== -->
	<meta name="renderer" content="webkit"/>
	<!-- Mobile Specific Metas
	================================================== -->
	<!-- !!!注意 minimal-ui 是IOS7.1的新属性，最小化浏览器UI，但是在iOS8.1突然被取消 -->
	<meta name="viewport" content="width=device-width,maximum-scale=1, maximum-scale=1"/>
	<meta content="telephone=no" name="format-detection" />
	<!-- CSS
	================================================== -->
	<link href="css/reset.css" rel="stylesheet" type="text/css"/>
	<link href="css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
      accessToken:<%=WX.Token %>
    <h1>
            <a href="https://lucky.meduo.com.cn/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=<%=System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] %>/demo.aspx&response_type=code&scope=snsapi_userinfo&state=<%=this.Request["bonus"] %>#wechat_redirect">点击授权</a>
    </h1>

</body>
</html>
