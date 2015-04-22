<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%
        var returnUrl = string.Format("http://lucky.meduo.com.cn/Alps/Ticket2.aspx?QRCode={0}", this.Request["QRCode"]);
        returnUrl = System.Web.HttpContext.Current.Server.UrlEncode(returnUrl);

         %>
    <script>
        function auth() {
            var authUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=<%=System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] %>/AuthCallback.aspx&response_type=code&scope=snsapi_userinfo&state=<%= returnUrl %>#wechat_redirect";

            window.location = authUrl;
        }
    </script>
<!-- 
* 开发人员书写规范:
* 1.所有缩进都用 TAB， 而不是空格。
* 2.非必要，禁止用行内样式例如 <div style="display:block"> 
 -->
	<!-- Basic Page Needs
	================================================== -->
	<meta charset="utf-8">
	<title>活动细则</title>
	<meta name="description" content="">
	<meta name="author" content="J.Chen">
	<!-- 让360双核浏览器用webkit内核渲染页面 !!! 注意，这行最好放在前面，防止浏览器开始解析的时候采用其它内置的渲染方案
	================================================== -->
	<meta name="renderer" content="webkit">
	<!-- 让IE浏览器用最高级内核渲染页面 还有用 Chrome 框架的页面用webkit 内核
	================================================== -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<!-- IOS6全屏 Chrome高版本全屏
	================================================== -->
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="mobile-web-app-capable" content="yes"> 
	<!-- Mobile Specific Metas
	================================================== -->
	<!-- !!!注意 minimal-ui 是IOS7.1的新属性，最小化浏览器UI，但是在iOS8.1突然被取消 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<!-- 指定苹果设备添加到主屏的标题 -->
	<meta name="apple-mobile-web-app-title" content="title2">
	<!-- CSS
	================================================== -->
	<link href="/Alps/css/reset.css" rel="stylesheet" type="text/css">
	<link href="/Alps/css/style.css" rel="stylesheet" type="text/css">
	<!-- Favicons
	================================================== -->
	<link rel="shortcut icon" href="favicon.ico" >
	<!-- Android 主屏图标
	================================================== -->	
	<link rel="icon" sizes="196x196" href="touch-icon.png">
	<!-- IOS 主屏图标
	================================================== -->
	<link rel="apple-touch-icon" href="touch-icon-iphone.png">
	<link rel="apple-touch-icon" sizes="76x76" href="touch-icon-ipad.png">
	<link rel="apple-touch-icon" sizes="120x120" href="touch-icon-iphone-retina.png">
	<link rel="apple-touch-icon" sizes="152x152" href="touch-icon-ipad-retina.png">
	
	<!-- Tile icon for Win8 (144x144 + tile color) -->
	<!-- win 8 磁贴图标 -->
	<meta name="msapplication-TileImage" content="/Alps/images/touch/ms-touch-icon-144x144-precomposed.png">
	<!-- win 8 磁贴颜色 -->
	<meta name="msapplication-TileColor" content="#ebce74">
	<meta http-equiv="Cache-Control" content="no-siteapp">
</head>
<body> 
<div class="container"><!-- Everything started here -->
	<div class="mtx-price-detail">
		<div class="inner">
			<ul>
				<li>买任数量阿尔卑斯预包装产品(不含棒糖)，即可参加微信扫二维码抽奖活动（需向促销员提交购物小票），详询店内促销员</li>
				<li>pp Box 1S电视盒市场参考价值399元，全国限量50份，送完即止</li>
				<li>阿尔卑斯小熊市场参考价值88元，全国限量3000份，送完即止</li>
				<li>阿尔卑斯意式浓醇咖啡条形硬糖市场参考价值2.5元，全国限量100000份，送完即止</li>
				<li>各类奖项综合中奖率33%</li>
				<li>所有奖品以实物为准，奖品的价值以举办活动时的市场参考价值为准，本公司保留因兑奖时因奖品停产或其他特殊原因以相同价值物品更换已公布奖品之权利</li>
				<li>所有奖项现场开奖；有爱奖和趣乐奖奖品现场抽中即送。惊喜奖奖品将在三周内以市内快递形式寄出，快递范围仅限于本市范围内；请抽中惊喜奖的中奖者留下收件地址和联系方式，将统一快递形式给到，因中奖者提供的收件地址错误或该地址无法投递/发送奖品的，将视为中奖者自动放弃获奖资格，将不会获得任何形式的补偿</li>
				<li>每个微信帐号限中奖五次</li>
				<li>中奖者自行承担与奖品的领取或其它事宜相关的税费</li>
				<li>本次活动最终解释权归不凡帝范梅勒糖果（中国）有限公司所有</li>
			</ul>
		</div>
			<input type="button" class="button-sty2 button-next" onclick="auth();">
	</div>
</div>
</body>
<!-- Javascript with AMD  -->
<script src="js/require.js" data-main="js/main" ></script>
    <%
         var authUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=" + System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] + "/AuthCallback.aspx&response_type=code&scope=snsapi_userinfo&state=" + this.Request["QRCode"] + "#wechat_redirect";
         %>
        <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <script>
        
            <%

            var wechat = iMidudu.Lucky.Web.WebServieFactiory.WeChat;
        var c = wechat.Config(Request.Url.AbsoluteUri);%> 
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: '<%=c.appId %>', // 必填，公众号的唯一标识
                timestamp: <%=c.timestamp %>, // 必填，生成签名的时间戳
                nonceStr: '<%=c.nonceStr %>', // 必填，生成签名的随机串
                signature: '<%=c.signature %>',// 必填，签名，见附录1
                jsApiList: [ 
        'hideOptionMenu' 
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
            function onBridgeReady(){
                WeixinJSBridge.call('hideOptionMenu');
            }

        
            wx.ready(function () {
                if (typeof WeixinJSBridge == "undefined"){
                    if( document.addEventListener ){
                        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
                    }else if (document.attachEvent){
                        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
                        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
                    }
                }else{
                    onBridgeReady();
                }
            });
            //alert(WeixinJSBridge);

    </script>
</html>