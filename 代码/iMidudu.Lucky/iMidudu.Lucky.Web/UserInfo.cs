using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SuuSee
{
   public  class UserInfo
    {
 private static string ClientIP()
        {
            string[] IP_Ary;
            string strIP, strIP_list;
            strIP_list = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (strIP_list != null && strIP_list != "")
            {
                strIP_list = strIP_list.Replace("\"", "");
                if (strIP_list.IndexOf(",") >= 0)
                {
                    IP_Ary = strIP_list.Split(',');
                    strIP = IP_Ary[0];
                }
                else
                {
                    strIP = strIP_list;
                }
            }
            else
            {
                strIP = "";
            }
            if (strIP == "")
            {
                strIP = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                strIP = strIP.Replace("\"", "");
            }
            return strIP;
        }

        public static UserInfo CurrentUser()
        {
            string uip = ClientIP(); 
            string ipUrl = "http://api.91cha.com/ip?key=f150e3f3eb5e4c96810ead5534eff2ba&ip=" + uip;
            var web = new WebClient();
            Byte[] bytes = web.DownloadData(ipUrl);
            var responseText =  Encoding.GetEncoding("utf-8").GetString(bytes);
            return Newtonsoft.Json.JsonConvert.DeserializeObject<UserInfo>(responseText);
        }

        public int state { get; set; }
        public string msg { get; set; }
        public UserInfoData data { get; set; }
        public string UserAgent
        {
            get
            {
                return HttpContext.Current.Request.UserAgent; 
            }
            set { }
        }
        public string OS
        {
            get
            {
                return null;

                //获取用户手机的操作系统
                string os = string.Empty;
                string agent = HttpContext.Current.Request.UserAgent;
                os = agent;
                string[] keywords = { "Android", "iPhone", "iPod", "iPad", "Windows Phone", "MQQBrowser" };
                //排除 Windows 桌面系统            
                if (!agent.Contains("Windows NT") || (agent.Contains("Windows NT") && agent.Contains("compatible; MSIE 9.0;")))
                {

                    //排除 苹果桌面系统 
                    if (!agent.Contains("Windows NT") && !agent.Contains("Macintosh"))
                    {
                        foreach (string item in keywords)
                        {
                            if (agent.Contains(item))
                            { 
                                os = item;
                            }
                        }
                    }

                }
                else
                {
                    os = "Windows";
                }
                return os;

            }
            set { }
        }

    }
    public class UserInfoData
    {
        public string ip { get; set; }
        public string country { get; set; }
        public string area { get; set; }
        public string province { get; set; }
        public string city { get; set; }
        public string district { get; set; }
        public string linetype { get; set; } 

    }
       
    
}
