<%@ Page Language="C#"   %>

<%
    var QRCode = this.Request["brandcode"];
    QRCode = Server.UrlEncode(QRCode);
        QRCode = QRCode.Replace("+", "");
   // Response.Write(QRCode); Response.End();
    
    
    
    if (QRCode.IndexOf("%20")>-1)
    {
        QRCode = QRCode.Replace("%20", "");
    }
    if (string.IsNullOrEmpty(QRCode))
    {
        this.Response.Write("no brandcode");
    }
    else
    {
        var url = iMidudu.Lucky.Web.WebServieFactiory.Biz.ActivityByCode(Guid.Parse(QRCode));
        if (string.IsNullOrEmpty(url))
        {
            this.Response.Write("url empty");
        }
        else
        {
            var qrcode="4d618408-d3f3-4d7b-8c0d-a42e9c31fe81";
            if (QRCode==qrcode)
            {
                this.Response.Write("活动已结束！欢迎参与活动，尽情关注下次活动，谢谢！！！");
                this.Response.End();
            }
            this.Response.Redirect(url+"?QRCode=" + QRCode);
        }
    }
     %>