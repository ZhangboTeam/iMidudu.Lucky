using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iMidudu.Admin
{
    public partial class SiteAdmin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			if ( System.Web.HttpContext.Current.Session["UserName"]  == null)
			{
                this.Response.Redirect("~/Admin/login.aspx");
			}
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            System.Web.HttpContext.Current.Session["UserName"] = null;
            this.Response.Redirect("~/Admin/Login.aspx");

        }
    }
}