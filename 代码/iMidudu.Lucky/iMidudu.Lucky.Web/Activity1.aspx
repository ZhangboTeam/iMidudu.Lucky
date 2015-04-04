<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%
        var returnUrl = string.Format("http://lucky.meduo.com.cn/Ticket1.aspx?QRCode={0}", this.Request["QRCode"]);
        returnUrl = System.Web.HttpContext.Current.Server.UrlEncode(returnUrl);

         %>
    <script>
        function auth() { 
            var authUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=<%=System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] %>/AuthCallback.aspx&response_type=code&scope=snsapi_userinfo&state=<%= returnUrl %>#wechat_redirect";

            window.location = authUrl;
        }
    </script>
</head>
<body> 
    活动1介绍
    <input  type="button" value="确定" onclick="auth();" />
    <%
         var authUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=" + System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] + "/AuthCallback.aspx&response_type=code&scope=snsapi_userinfo&state=" + this.Request["QRCode"] + "#wechat_redirect";
       
     // Response.Write(authUrl);
      //  Response.Redirect(authUrl);
         %>
</body>
</html>
