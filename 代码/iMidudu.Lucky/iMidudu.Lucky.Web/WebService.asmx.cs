using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using iMidudu.Lucky.Biz;
namespace iMidudu.Lucky.Web
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
      [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {

        [WebMethod(EnableSession =true)]
        public string Login(string UserName, string Password)
        {
            try
            {
              var ok=  SystemUserBiz.Login(UserName, Password);
                return ok ? "ok" : "no";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}
