using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

namespace TisWeb.Admin
{
    /// <summary>
    /// OutExcel 的摘要说明
    /// </summary>
   public class OutExcel: IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            var contentfile = context.Request["ContentFile"];
            var filename= context.Request["filename"];

            StringBuilder sb = new StringBuilder();
            sb.Append("<meta http-equiv=\"content-type\" content=\"application/ms-excel; charset=UTF-8\"/>");

            sb.Append(System.IO.File.ReadAllText(context.Server.MapPath(contentfile)));

            var res = context.Response;
            res.Clear();
            res.Buffer = true;
            res.Charset = "UTF-8";
            res.AddHeader("Content-Disposition", "attachment; filename=" + filename);
            res.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8"); 
            res.ContentType = "application/octet-stream";
            res.Write(sb.ToString());
            res.Flush();
            res.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}