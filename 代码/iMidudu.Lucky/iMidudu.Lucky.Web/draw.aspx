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
            this.Response.Redirect(url+"?QRCode=" + QRCode);
        }
    }
     %>