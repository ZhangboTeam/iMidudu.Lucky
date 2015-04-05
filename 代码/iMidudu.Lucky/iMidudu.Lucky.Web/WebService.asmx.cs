using System;
using System.Collections.Generic;
using System.Net;
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
         
    }
}
