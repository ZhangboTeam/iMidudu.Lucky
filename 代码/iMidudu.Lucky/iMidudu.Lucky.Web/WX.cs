using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Web;
using System.Web.Caching;
using System.Linq;
using iMidudu;

public class Param
{
    public string  b { get; set; }
    public string a { get; set; }
}
public class WX
{
	public WX()
	{
	}

    public static long    timestamp 
    {
        get
        {
            
            return  (DateTime.Now.Ticks/100000000) ;
        }
    }
    public static string nonceStr
    {
        get
        {
            return Guid.NewGuid().ToString().ToLower().Replace("-","");
        }
    }

    public static bool isIOs()
    {
        string agent = HttpContext.Current.Request.UserAgent;
        string[] keywords = {  "iPhone", "iPod", "iPad" };
        foreach (var item in keywords)
        {
            if (agent.Contains(item))
            {
                return true;
            }
        }
        return false;
    }
    public static string Token
    {
        get
        {
            var cachedToken = System.Web.HttpContext.Current.Cache.Get("token");
            //cachedToken = null;
            if (cachedToken == null)
            {
                CacheItemRemovedCallback("token", null, CacheItemRemovedReason.Expired);
                cachedToken = System.Web.HttpContext.Current.Cache.Get("token");
               
            }
            return cachedToken.ToString();
        }
    }
    private static  void CacheItemRemovedCallback(string key, object value, CacheItemRemovedReason reason)
    {
        if (key == "token")
        {
            var tokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx8cabe7121f5369a3&secret=6066d7e2e03fbb351a9a4602f07a3a94";

            var response = System.Net.WebRequest.Create(tokenUrl).GetResponse() ;
            Stream dataStream = response.GetResponseStream();
            // Open the stream using a StreamReader for easy access.
            StreamReader reader = new StreamReader(dataStream);
            // Read the content.
            string responseFromServer = reader.ReadToEnd();
          var newToken =  Newtonsoft.Json.JsonConvert.DeserializeObject<TokenResponse>(responseFromServer);
            System.Web.HttpContext.Current.Cache.Add("token", newToken.access_token, null, DateTime.Now.AddSeconds(newToken.expires_in-5), TimeSpan.Zero, System.Web.Caching.CacheItemPriority.High, CacheItemRemovedCallback);
        }
    }
     

    public static string Ticket
    {
        get
        {
            var cachedTicket = System.Web.HttpContext.Current.Cache.Get("ticket");
            if (cachedTicket == null)
            {
                TicketItemRemovedCallback("ticket", null, CacheItemRemovedReason.Expired);
                cachedTicket = System.Web.HttpContext.Current.Cache.Get("ticket");

            }
            return cachedTicket.ToString();
        }
    }
    private static  void TicketItemRemovedCallback(string key, object value, CacheItemRemovedReason reason)
    {
        if (key == "ticket")
        {
            var tokenUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+ Token + "&type=jsapi";

            var response = System.Net.WebRequest.Create(tokenUrl).GetResponse() ;
            Stream dataStream = response.GetResponseStream();
            // Open the stream using a StreamReader for easy access.
            StreamReader reader = new StreamReader(dataStream);
            // Read the content.
            string responseFromServer = reader.ReadToEnd();
          var newTicket =  Newtonsoft.Json.JsonConvert.DeserializeObject<TicketResponse>(responseFromServer);
            if (newTicket.errcode!=0)
            {
                throw new Exception(newTicket.errmsg);
            }
            System.Web.HttpContext.Current.Cache.Add("ticket", newTicket.ticket, null, DateTime.Now.AddSeconds(newTicket.expires_in-5), TimeSpan.Zero, System.Web.Caching.CacheItemPriority.High, TicketItemRemovedCallback);
        }
    }

    public static OpenIdResponse getOpenId(string    code)
    {

        var url = string.Format("https://api.weixin.qq.com/sns/oauth2/access_token?appid={0}&secret={1}&code={2}&grant_type=authorization_code",
            System.Web.Configuration.WebConfigurationManager.AppSettings["AppID"],
            System.Web.Configuration.WebConfigurationManager.AppSettings["AppSecret"],
            code );

      //  Adinnet.SEQ.interfaces.Log.Add(url);
        var response = System.Net.WebRequest.Create(url).GetResponse();
        Stream dataStream = response.GetResponseStream();
        // Open the stream using a StreamReader for easy access.
        StreamReader reader = new StreamReader(dataStream);
        // Read the content.
        string responseFromServer = reader.ReadToEnd();
        var result = Newtonsoft.Json.JsonConvert.DeserializeObject<OpenIdResponse>(responseFromServer);
      //  Adinnet.SEQ.interfaces.Log.Add(responseFromServer);
      //  Adinnet.SEQ.interfaces.Log.Add("CODE:" +System.Web.HttpContext.Current.Request["code"]);
        return result;
    }

    public static UserInfo getUserInfo(OpenIdResponse openid )
    {
       // var openid = getOpenId();
        //https://api.weixin.qq.com/sns/userinfo?access_token=OezXcEiiBSKSxW0eoylIeKnhyo09fwXSJHCEJ1LNgisTLHUblD2OzRxOO0bdFyWf0cHcGYAEHp6SgtjStmnUQ4IYzA6Ht2IQzJBg9bGYKReodSh682YH6tSSy-0sj0AgiyCrLtHwXhR2XRmdt9IDcQ&openid=oo-nWs3meUO4Bu_zEWKoZYvpcr2g&lang=zh_CN
        //var url = string.Format("https://api.weixin.qq.com/cgi-bin/user/info?access_token={0}&openid={1}&lang=zh_CN", openid.access_token, openid.openid);
        var url = string.Format("https://api.weixin.qq.com/sns/userinfo?access_token={0}&openid={1}&lang=zh_CN", openid.access_token, openid.openid);
      //  Adinnet.SEQ.interfaces.Log.Add(url);

        var response = System.Net.WebRequest.Create(url).GetResponse();
        Stream dataStream = response.GetResponseStream();
        // Open the stream using a StreamReader for easy access.
        StreamReader reader = new StreamReader(dataStream);
        // Read the content.
        string responseFromServer = reader.ReadToEnd();
        var result = Newtonsoft.Json.JsonConvert.DeserializeObject<UserInfo>(responseFromServer);

       // Adinnet.SEQ.interfaces.Log.Add(responseFromServer);
        return result;
        //return getResponse<UserInfo>(url);
    }
    public static string newBillNo()
    {
        var rnd = new Random();
        return string.Format("{0}{1}{2}{3}", System.Web.Configuration.WebConfigurationManager.AppSettings["mch_id"], DateTime.Now.ToString("yyyyMMdd"),rnd.Next(10000, 99999), rnd.Next(10000, 99999));
    }
    public static T getResponse<T>(string url)
    {

        var response = System.Net.WebRequest.Create(url).GetResponse();
        Stream dataStream = response.GetResponseStream();
        // Open the stream using a StreamReader for easy access.
        StreamReader reader = new StreamReader(dataStream);
        // Read the content.
        string responseFromServer = reader.ReadToEnd();
      //  Adinnet.SEQ.interfaces.Log.Add(responseFromServer);
        T result = Newtonsoft.Json.JsonConvert.DeserializeObject<T>(responseFromServer);
        return result;
    }
    public static string GetMd5(string inputStr)
    {
        byte[] md5Bytes = Encoding.UTF8.GetBytes(inputStr);

        // compute MD5 hash.
        MD5 md5 = new MD5CryptoServiceProvider();
        byte[] cryptString = md5.ComputeHash(md5Bytes);

        int len;
        string temp = String.Empty;

        len = cryptString.Length;

        for (int i = 0; i < len; i++)
        {
            temp += cryptString[i].ToString("X2");
        }
        return temp;
    }
    /// <summary>
    /// 创建签名
    /// </summary>
    /// <returns></returns>
    /// <remarks>必须保证所有传入的参数都有值，没有值的要过滤掉</remarks>
    static  string CreateSignString(Dictionary<string, string> parameters, string paySecret)
    {
        foreach (var key in parameters.Keys.Where(key => string.IsNullOrEmpty(parameters[key])))
        {
            parameters.Remove(key);
        }

        //第一步，设所有収送戒者接收到的数据为集合 M，将集合 M 内非空参数值的参数按照参数名ASCII码从小到大排序（字典序），
        //使用URL键值对的格式（即key1=value1&key2=value2…）拼接成字符串 stringA。
        //特别注意以下重要规则：
        //1.参数名 ASCII 码从小到大排序（字典序） ；
        //2.如果参数的值为空不参与签名；
        //3.参数名区分大小写；
        //4.验证调用返回戒微信主劢通知签名时，传送的 sign 参数不参与签名，将生成的签名与该 sign 值作校验。
        var keyArray = parameters.Keys.ToArray();
        Array.Sort(keyArray);
        var keyString = keyArray.Aggregate("", (current, t) => current + (t + "=" + parameters[t] + "&"));

        //第二步，在 stringA 最后拼接上 key=商户支付密钥得到 stringSignTemp 字符串，
        //并对 stringSignTemp 进行 MD5 运算，再将得到的字符串所有字符转换为大写，得到 sign的值 signValue
        keyString += "key=" + paySecret;

        return GetMd5(keyString).ToUpper();
    }
    public class PayResult
    {
        public string return_code { get; set; }
        public string return_msg { get; set; }
    }
    public static bool isUserFocused(string openid)
    {
        FocusedUserResponse users = null;
        WX.FocusedUser(ref users);
        return users.data.openid.Contains(openid); 

    }

    public static void FocusedUser(ref FocusedUserResponse init)
    { 
        var url = string.Format("https://api.weixin.qq.com/cgi-bin/user/get?access_token={0}&next_openid={1}",Token, init==null?null :init.next_openid);
        var r = getResponse<FocusedUserResponse>(url);
        if (init==null)
        {
            init = r;
        }
        else
        {
            init.next_openid = r.next_openid;
            if (r.data != null)
            {
                init.data.openid.AddRange(r.data.openid);
            }
        }
        if (!string.IsNullOrEmpty(init.next_openid))
        {
            FocusedUser(ref init);
        } 
    }
    public static WXconfig Config(string Url)
    {
        //debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        //            appId: 'wx8cabe7121f5369a3', // 必填，公众号的唯一标识
        //            timestamp: <%= WX.timestamp %>, // 必填，生成签名的时间戳
        //    nonceStr: '<%=WX.nonceStr%>', // 必填，生成签名的随机串
        //    signature: '',// 必填，签名，见附录1
        //    jsApiList: [] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        var config = new WXconfig()
        {
            appId =
            System.Web.Configuration.WebConfigurationManager.AppSettings["AppID"],
            timestamp = WX.timestamp,
            debug = true,
            nonceStr = WX.nonceStr,
             ticket= Ticket
        };

        config.jsApiList.Add("");



        String nonce_str = config.nonceStr;
        String timestamp = config.timestamp.ToString();
        String string1;
       
        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + config.ticket +
                  "&noncestr=" + nonce_str +
                  "&timestamp=" + timestamp +
                  "&url=" + Url;
        //string1 = string.Format("jsapi_ticket={0}&noncestr={1}&timestamp={2}&url={3}",config.ticket,);
        ////建立SHA1对象
        //SHA1 sha = new SHA1CryptoServiceProvider();

        ////将mystr转换成byte[]
        //ASCIIEncoding enc = new ASCIIEncoding();
        //byte[] dataToHash = enc.GetBytes(string1);

        ////Hash运算
        //byte[] dataHashed = SHA1.Create().ComputeHash(dataToHash);

        ////将运算结果转换成string
        //string hash = BitConverter.ToString(dataHashed).Replace("-", "");
        config.signature = Sha1(string1);
        return config;
    }
    public static string Sha1(string orgStr, string encode = "UTF-8")
    {
        var sha1 = new SHA1Managed();
        var sha1bytes = System.Text.Encoding.GetEncoding(encode).GetBytes(orgStr);
        byte[] resultHash = sha1.ComputeHash(sha1bytes);
        string sha1String = BitConverter.ToString(resultHash).ToLower();
        sha1String = sha1String.Replace("-", "");
        return sha1String;
    }
    //public  static string Sign(string nonceStr,string Url)
    //{

    //}

    //private static string Encrypted(string targetPassword)
    //{
    //    byte[] pwBytes = Encoding.UTF8.GetBytes(targetPassword);
    //    byte[] hash = SHA1.Create().ComputeHash(pwBytes);
    //    StringBuilder hex = new StringBuilder();
    //    for (int i = 0; i < hash.Length; i++) hex.Append(hash[i].ToString("X2"));

    //    return hex.ToString();
    //}
}

public class BounsPostParams
{
    public string nonce_str { get; set; }
    public string sign { get; set; }
    public string mch_billno { get; set; }
    public string mch_id { get; set; }
    public string sub_mch_id { get; set; }
    public string wxappid { get; set; }
    public string nick_name { get; set; }
    public string send_name { get; set; }
    public string re_openid { get; set; }
    public int total_amount { get; set; }
    public int min_value { get; set; }
    public int max_value { get; set; }  
    public int total_num { get; set; }   
    public string wishing { get; set; }   
    public string client_ip { get; set; }
    public string act_name { get; set; }

    public string remark { get; set; }

    public string logo_imgurl { get; set; }

    public string share_content { get; set; }

    public string share_url { get; set; }

    public string share_imgurl { get; set; }
}

public class WXconfig
{

    public WXconfig()
    {
        this.jsApiList = new List<string>();
    }
    public string appId { get; set; }
    public long timestamp
    {
        get; set;
    }
    public string nonceStr { get; set; }

    public string signature { get; set; }
    public List<string> jsApiList { get; set; }
    public bool debug { get; set; }
    public string ticket { get; set; }

}

public class UserInfo
{
   // public int subscribe { get; set; }
    public string openid { get; set; }
    public string nickname { get; set; }
    public int sex { get; set; }
    public string language { get; set; }
    public string city { get; set; }
    public string province { get; set; }
    public string country { get; set; }
    public string headimgurl { get; set; }
   // public int subscribe_time { get; set; }
    public string unionid { get; set; }
    public List<string> privilege { get; set; }
}

public class TokenResponse
{
    public string access_token { get; set; }
    public int expires_in { get; set; }
}

public class TicketResponse
{
    public int errcode { get; set; }
    public string errmsg { get; set; }
    public string ticket { get; set; }
    public int expires_in { get; set; }
}


public class OpenIdResponse
{
    public string access_token { get; set; }
    public int expires_in { get; set; }
    public string refresh_token { get; set; }
    public string openid { get; set; }
    public string scope { get; set; }
}


public class FocusedUserResponse
{
    public int total { get; set; }
    public int count { get; set; }

    public FocuedUserData data { get; set; }
    public string next_openid { get; set; }
    public class FocuedUserData
    {
        public FocuedUserData()
        {
            this.openid = new List<string>();
        }
        public List<string> openid { get; set; }
    }
}

