using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace iMidudu.Lucky.Web
{
   public static class WebServieFactiory
    {
        private static readonly BizWebService.BizWebServiceSoapClient bizws = new BizWebService.BizWebServiceSoapClient();
        private static readonly WeChatWebService.WeChatWebServiceSoapClient wechatws = new WeChatWebService.WeChatWebServiceSoapClient();
        private static readonly SMSWebService.SMSWebServiceSoapClient smsws = new SMSWebService.SMSWebServiceSoapClient();

        public static BizWebService.BizWebServiceSoapClient Biz
        {
            get { return bizws; }
        }
        public static WeChatWebService.WeChatWebServiceSoapClient WeChat
        {
            get { return wechatws; }
        }
        public static SMSWebService.SMSWebServiceSoapClient SMS
        {
            get { return smsws; }
        }
    }
}
