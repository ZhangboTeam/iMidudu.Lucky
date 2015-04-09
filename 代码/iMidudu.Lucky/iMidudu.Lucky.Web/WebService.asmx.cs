using System;
using System.Collections.Generic;
using System.Net;
using System.Web;
using System.Web.Services;
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
                // var ok=  SystemUserBiz.Login(UserName, Password);
                var ok = true;
                return ok ? "ok" : "no";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        //[WebMethod]
        //public string AddNewActivity(string NewActivityName)
        //{
        //    iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("ActivityName",
        //         new System.Data.SqlClient.SqlParameter("@ActivityName", NewActivityName));
        //    var count = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from Activity");
        //    return string.Format("{0:000}", count++);
        //}
        //[WebMethod]
        //public void DeleteActivity(string ActivityName )
        //{
        //    iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("Activity_DeleteProcedure",
        //         new System.Data.SqlClient.SqlParameter("@ActivityName", ActivityName) );
        //}
        [WebMethod]
        public void UpdateAllActivity(List<UpdateModelActivity> datasssss)
        {
            foreach (var d in datasssss)
            {
                iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("ActivityNameUpdate_Procedure",
                     new System.Data.SqlClient.SqlParameter("@ActivityName", d.ActivityName),
                     new System.Data.SqlClient.SqlParameter("@QRCode", d.QRCode));
            }
        }
        public class UpdateModelActivity
        {
            public string ActivityName { get; set; }
            public Guid QRCode { get; set; }
        }
  
        /// <summary>
        /// 下载保存多媒体文件,返回多媒体保存路径
        /// </summary>
        /// <param name="ACCESS_TOKEN"></param>
        /// <param name="MEDIA_ID"></param>
        /// <returns></returns>
        [WebMethod]
        public string GetMultimedia(string ACCESS_TOKEN, string MEDIA_ID)
        {
            string file = string.Empty;
            string content = string.Empty;
            string strpath = string.Empty;
            string savepath = string.Empty;
            string stUrl = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=" + ACCESS_TOKEN + "&media_id=" + MEDIA_ID;

            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(stUrl);

            req.Method = "GET";
            using (WebResponse wr = req.GetResponse())
            {
                HttpWebResponse myResponse = (HttpWebResponse)req.GetResponse();

                strpath = myResponse.ResponseUri.ToString();
               
                WebClient mywebclient = new WebClient();
                var url = "/uploadedImages/" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + (new Random()).Next().ToString().Substring(0, 4) + ".jpg";
                savepath = Server.MapPath(url);
               
                try
                {
                    mywebclient.DownloadFile(strpath, savepath);
                    file = savepath;
                    file = url;
                }
                catch (Exception ex)
                {
                    file = ex.ToString();
                    savepath = ex.ToString();
                }

            }
         //   file = ACCESS_TOKEN;
            return file;
        }
        [WebMethod]
        public Guid AddScanHistory(string OpenId, string TicketUrl, string TicketNumber)
        {
            //var User = iMidudu.Lucky.Web.WebServieFactiory.Biz.CurrentUser();
            var User = SuuSee.UserInfo.CurrentUser();
            var data = new iMidudu.Lucky.Web.BizWebService.ScanHistory()
            {
                ScanHistoryId = Guid.NewGuid(),
                OpenId = OpenId,
                TicketUrl = TicketUrl,
                TicketNumber = TicketNumber,
                Agent = User.UserAgent,
                Area = User.data.area,
                City = User.data.city,
                Country = User.data.country,
                District = User.data.district,
                IP = User.data.ip,
                LineType = User.data.linetype,
                Os = User.OS,
                Province = User.data.province,
                ScanDate = DateTime.Now,
                PrizeId = null

            };
            iMidudu.Lucky.Web.WebServieFactiory.Biz.InsertScanHistory(data);
            return data.ScanHistoryId;
        }
        [WebMethod]
        public BizWebService.Prize PrizeLottery(Guid QRCode)
        {
            return WebServieFactiory.Biz.PrizeLottery(QRCode);
        }

        /// <summary>
        /// 记录中奖
        /// </summary>
        [WebMethod]
        public void SavePrize(Guid ScanHistoryId, Guid PrizeId)
        {
            WebServieFactiory.Biz.UpdateScanHistory(ScanHistoryId, PrizeId);
        }

        [WebMethod(EnableSession =true)]
        public string SendValidCodeToMobile(string mobile)
        {
            var apiKey = System.Web.Configuration.WebConfigurationManager.AppSettings["smsAppKey"];
            var code= WebServieFactiory.SMS.SendValidCode(apiKey, "【不凡帝】您的验证码是{0}", mobile);
            this.Session["smsCode"] = code;
            return code;
        }
        [WebMethod(EnableSession = true)]
        public bool Login1(string userName, string password)
        {
            var ok = iMidudu.Lucky.Web.SystemDAO.SqlHelper.Exists("select count(1) from SystemUser where UserName=@UserName and PassWord= @PassWord", new System.Data.SqlClient.SqlParameter("@UserName", userName), new System.Data.SqlClient.SqlParameter("@PassWord", password));
            if (ok)
            {
                System.Web.HttpContext.Current.Session["UserName"] = userName;
            }
            return ok;
        }
        [WebMethod(EnableSession = true)]
        public bool ChangePassword(string oldpwd, string newpwd, string newpwd2)
        {
            var username = HttpContext.Current.Session["UserName"].ToString();
            if (SystemDAO.SqlHelper.Exists("select count(1) from SystemUser where UserName =@UserName and PassWord = @PassWord", new System.Data.SqlClient.SqlParameter("@UserName", username), new System.Data.SqlClient.SqlParameter("@PassWord", oldpwd)))
            {
                SystemDAO.SqlHelper.ExecteNonQueryText("update SystemUser set PassWord=@PassWord where UserName=@UserName",
                 new System.Data.SqlClient.SqlParameter("@UserName", username),
                 new System.Data.SqlClient.SqlParameter("@PassWord", newpwd));
                return true;
            }
            return false;
        }
        [WebMethod(EnableSession = true)]
        public bool Logout()
        {
            System.Web.HttpContext.Current.Session["UserName"] = null;
            return true;
        }
    }
}
