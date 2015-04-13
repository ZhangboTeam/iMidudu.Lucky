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
   public class OutExcelDown : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            var sql = context.Request["sql"];
            var filename= context.Request["filename"];

            StringBuilder sb = new StringBuilder();
            sb.Append("<meta http-equiv=\"content-type\" content=\"application/ms-excel; charset=UTF-8\"/>");


            var ds = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteDataSet(System.Data.CommandType.Text, sql);

            sb.AppendFormat("<table>");
            foreach (System.Data.DataColumn col in ds.Tables[0].Columns)
            {
                sb.AppendFormat("<th>{0}</th>",col.ColumnName);
            }

            foreach (System.Data.DataRow row in ds.Tables[0].Rows)
            {
                sb.AppendFormat("<tr>");

                foreach (System.Data.DataColumn col in ds.Tables[0].Columns)
                {
                    sb.AppendFormat("<td>{0}</td>",row[col.ColumnName]);
                }
                sb.AppendFormat("</tr>");
            }
            sb.AppendFormat("</table>");

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