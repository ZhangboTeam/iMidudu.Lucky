﻿using System;
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

        [WebMethod]
        public List<ActivityName> GetPrize(string ActivityId)
        {
            var table = iMidudu.Lucky.Web.SystemDAO.SqlHelper.GetTableText("select * from Prize where  QRCode=@ActivityId",
                new System.Data.SqlClient.SqlParameter("@ActivityId", ActivityId))[0];
            var Reeslut = new List<ActivityName>();
            foreach ( System.Data.DataRow row in table.Rows)
            {
                Reeslut.Add(new ActivityName()
                {
                    PrizeId = row["PrizeId"].ToString(),
                    PrizeName = row["PrizeName"].ToString()
                });
            }
            return Reeslut;
            
        }
        public class ActivityName
        {
            public string PrizeName;
            public string PrizeId;
        }
        public Activity1 GetActivityName()
        {
            var table = iMidudu.Lucky.Web.SystemDAO.SqlHelper.GetTableText("select PrizeName from Activity,Prize where  Activity.QRCode = Prize.QRCode ")[0];
            Activity1 row = new Activity1();
            row.ActivityName1 = table.Rows[0]["ActivityName"].ToString();
            row.ActivityName2 = table.Rows[1]["ActivityName"].ToString();
            row.ActivityName3 = table.Rows[2]["ActivityName"].ToString();
            return row;

        }
        public class Activity1
        {
            public string ActivityName1;
            public string ActivityName2;
            public string ActivityName3;
        }

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

        [WebMethod]
        public void SetDayLimit(List<UpdateSetDayLimit> datasssss)
        {
            foreach (var d in datasssss)
            {
                iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("SetDayLimitUpdate_Procedure",
                     new System.Data.SqlClient.SqlParameter("@PrizeId", d.PrizeId),
                     new System.Data.SqlClient.SqlParameter("@DayLimit", d.DayLimit));
            }
        }
        public class UpdateSetDayLimit
        {
            public Guid PrizeId { get; set; }
            public int DayLimit { get; set; }
        }

        public void SearchActName(List<UpdateModelActivityName> ActivityName)
        {
            foreach (var d in ActivityName)
            {
               iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("ActName_Procedure",
                     new System.Data.SqlClient.SqlParameter("@ActivityName", d.ActivityName));
            }
        }
        public class UpdateModelActivityName
        {
            public string ActivityName { get; set; }
        }

        [WebMethod]
        public void UpdateAllPrize(List<UpdateModelPrize> datasssss)
        {
            foreach (var d in datasssss)
            {
                iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("PrizeUpdate_Procedure",
                     new System.Data.SqlClient.SqlParameter("@PrizeId", d.PrizeId),
                     new System.Data.SqlClient.SqlParameter("@PrizeName", d.PrizeName)
                     //,
                     //new System.Data.SqlClient.SqlParameter("@Quantity", d.Quantity)
                     );

            }
        }
        public class UpdateModelPrize
        {

            public Guid PrizeId { get; set; }
            public string PrizeName { get; set; }
            //public int Quantity { get; set; }
        }

        public class ModelPrizeSearch
        {

            public Guid ActivityName{ get; set; }
            public string PrizeName{ get; set; }
        }
        [WebMethod(EnableSession = true)]
        public string InsertAccept(string UserName, string Sex, string Mobile, string ValidCode, string Address, Guid ScanHistoryId)
        {
            bool exist = true;
            try
            {
                exist = iMidudu.Lucky.Web.SystemDAO.SqlHelper.Exists("select * from Acception where ScanHistoryId=@ScanHistoryId",
                             new System.Data.SqlClient.SqlParameter("@ScanHistoryId", ScanHistoryId));
            }
            catch (Exception ex) {
                return "a";
            
            }
            if (exist)
            {
                return "a";
            }
            else
            {
                var code = System.Web.HttpContext.Current.Session["smsCode"];
                if (code.ToString().Equals(ValidCode))
                {
                    try
                    {

                        //var apiKey = System.Web.Configuration.WebConfigurationManager.AppSettings["smsAppKey"];
                        //var code1 = WebServieFactiory.SMS.SendValidCode(apiKey, "【不凡帝】您的验证码是{0}", Mobile);
                        iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryText("insert into Acception(ScanHistoryId,Address,Mobile,UserName,ValidCode,Sex,Remark,Status) values (@ScanHistoryId,@Address,@Mobile,@UserName,@ValidCode,@Sex,@Remark,@Status)",
                             new System.Data.SqlClient.SqlParameter("@ScanHistoryId", ScanHistoryId),
                             new System.Data.SqlClient.SqlParameter("@Address", Address),
                             new System.Data.SqlClient.SqlParameter("@Mobile", Mobile),
                             new System.Data.SqlClient.SqlParameter("@ValidCode", ValidCode),
                             new System.Data.SqlClient.SqlParameter("@UserName", UserName),
                             new System.Data.SqlClient.SqlParameter("@Sex", Sex),
                             new System.Data.SqlClient.SqlParameter("@Remark", "2"),
                             new System.Data.SqlClient.SqlParameter("@Status", "1"));
                        return ValidCode;
                    }
                    catch (Exception ex)
                    {
                        return ex.Message;
                    }
                }
                else
                {
                    return "1";
                }
            }
        }
        [WebMethod(EnableSession = true)]
        public string IsExist(Guid ScanHistoryId)
        {
            var PrizeId="21345";
                try
                {
                    PrizeId = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select PrizeId from ScanHistory where ScanHistoryId=@ScanHistoryId",
                         new System.Data.SqlClient.SqlParameter("@ScanHistoryId", ScanHistoryId.ToString())).ToString();
                }
                catch (Exception ex)
                {
                    return "-1";
                }
                if (PrizeId == null || PrizeId == "")
                {
                    PrizeId = "-2";
                    return PrizeId;
                }
                else
                {

                    var url = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select URL from Prize where PrizeId=@PrizeId",
                         new System.Data.SqlClient.SqlParameter("@PrizeId", PrizeId)).ToString();
                    return url;
                }
        }
        [WebMethod]
        public void UpdateAllSetPrize(List<UpdateModelSetPrize> datasssss)
        {
            foreach (var d in datasssss)
            {
                iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("SetPrizeUpdate_Procedure",
                     new System.Data.SqlClient.SqlParameter("@PrizeName", d.PrizeName),
                     new System.Data.SqlClient.SqlParameter("@Quantity", d.Quantity)
                     );
            }
        }
        public class UpdateModelSetPrize
        {
            public string PrizeName { get; set; }
            public string Quantity { get; set; }
        }


        [WebMethod]
        public void UpdateAllSet(List<UpdateModelUpdateAllSet> datasssss, List<UpdateModelUpdateAllSet> datass, List<UpdateModelUpdateAllSet> datas)
        {
            foreach (var d in datasssss)
            {
                iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("AllSetUpdate_Procedure",
                     new System.Data.SqlClient.SqlParameter("@PrizeId", d.PrizeId),
                     new System.Data.SqlClient.SqlParameter("@PrizeName", d.PrizeName));
            }
            foreach (var d in datass)
            {
                iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("AllUpdateSet_Procedure",
                     new System.Data.SqlClient.SqlParameter("@PrizeId", d.PrizeId),
                     new System.Data.SqlClient.SqlParameter("@Quantity", d.Quantity));
            }
            foreach (var d in datas)
            {
                iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("AllUpdateSets_Procedure",
                     new System.Data.SqlClient.SqlParameter("@PrizeId", d.PrizeId),
                     new System.Data.SqlClient.SqlParameter("@DayLimit", d.DayLimit));
            }

        }
        public class UpdateModelUpdateAllSet
        {
            public int Quantity { get; set; }
            public Guid PrizeId { get; set; }
            public string PrizeName { get; set; }
            public int DayLimit { get; set; }
        }

 
        [WebMethod]
        public void UpdateBigPrize(List<UpdateModelBigPrize> datasssss)
        {
            foreach (var d in datasssss)
            {
                iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecteNonQueryProcedure("PrizeNameUpdate_Procedure",
                     new System.Data.SqlClient.SqlParameter("@PrizeId", d.PrizeId),
                     new System.Data.SqlClient.SqlParameter("@Status", d.Status)
                     );
            }
        }
        public class UpdateModelBigPrize
        {
            public Guid PrizeId { get; set; }
            public int Status { get; set; }
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
        public BizWebService.Prize PrizeLottery(Guid QRCode , string OpenId)
        {
            return WebServieFactiory.Biz.PrizeLottery(QRCode,OpenId);
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
        [WebMethod(EnableSession = true)]
        public bool DeleteActivity3()
        {
            try
            {
                SystemDAO.SqlHelper.ExecteNonQueryText("delete from ScanHistory where PrizeId='2eda98cd-326d-4da8-8a26-23aca4482737'");
            }
            catch (Exception ex)
            {
                return false;
            }
            try
            {
                SystemDAO.SqlHelper.ExecteNonQueryText("delete from Acception where ScanHistoryId in (select ScanHistory.ScanHistoryId from Acception,ScanHistory where Acception.ScanHistoryId=ScanHistory.ScanHistoryId and ScanHistory.PrizeId='2eda98cd-326d-4da8-8a26-23aca4482731')");
            }
            catch (Exception ex)
            {
                return false;
            }
            try
            {
                SystemDAO.SqlHelper.ExecteNonQueryText("delete from ScanHistory where PrizeId='2eda98cd-326d-4da8-8a26-23aca4482731'");
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }
    }
}
