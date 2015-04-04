<%@ Page Language="C#"   %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html>
<script runat ="server">
         public   string Token
        {
            get
            {
                var cachedToken = System.Web.HttpContext.Current.Cache.Get("token");
                cachedToken = null;
                if (cachedToken == null)
                {
                    CacheItemRemovedCallback("token", null, CacheItemRemovedReason.Expired);
                    cachedToken = System.Web.HttpContext.Current.Cache.Get("token");

                }
                return cachedToken.ToString();
            }
        }
        private  void CacheItemRemovedCallback(string key, object value, CacheItemRemovedReason reason)
        {
            if (key == "token")
            {
                var tokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx8cabe7121f5369a3&secret=6066d7e2e03fbb351a9a4602f07a3a94";
                //              https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx8cabe7121f5369a3&secret=6066d7e2e03fbb351a9a4602f07a3a94
                var response = System.Net.WebRequest.Create(tokenUrl).GetResponse();
                Stream dataStream = response.GetResponseStream();
                // Open the stream using a StreamReader for easy access.
                StreamReader reader = new StreamReader(dataStream);
                // Read the content.
                string responseFromServer = reader.ReadToEnd();
                var newToken = Newtonsoft.Json.JsonConvert.DeserializeObject<TokenResponse>(responseFromServer);
                System.Web.HttpContext.Current.Cache.Add("token", newToken.access_token, null, DateTime.Now.AddSeconds(newToken.expires_in), TimeSpan.Zero, System.Web.Caching.CacheItemPriority.High, CacheItemRemovedCallback);
            }
        }
    
    public class TokenResponse
    {
        public string access_token { get; set; }
        public int expires_in { get; set; }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/jquery.min.js"></script>
</head>
<body>
    <script> <%
            var wechat = iMidudu.Lucky.Web.WebServieFactiory.WeChat; 
             %>
        var data = {ACCESS_TOKEN:'<%=wechat.AccessToken()%>',MEDIA_ID:'FKLZw1OasuKtpQk8o1rDJgLx4GNlrsUNDfX1ST8wFTkUmwgDq1NprPVF6EUBASLW'};
                alert(data.ACCESS_TOKEN);
               //return;
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Webservice.asmx/GetMultimedia",
                    data:JSON.stringify(data),
                    dataType: 'json',
                    success: function (result) {
                        alert(result.d);
                        $("#preview").attr("src",result.d);
                        $("#mediaid").html(data.ACCESS_TOKEN+"<br/>"+data.MEDIA_ID);
                    }
                });
    </script>
</body>
</html>
