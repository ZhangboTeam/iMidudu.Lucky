<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="mtx-app">
<head runat="server">
    <!-- 
* 开发人员书写规范:
* 1.所有缩进都用 TAB， 而不是空格。
* 2.非必要，禁止用行内样式例如 <div style="display:block"> 
 -->
	<!-- Basic Page Needs
	================================================== -->
	<meta charset="utf-8">
	<title>登记资料</title>
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
	<link href="css/reset.css" rel="stylesheet" type="text/css">
	<link href="css/style.css" rel="stylesheet" type="text/css">
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
	<meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">
	<!-- win 8 磁贴颜色 -->
	<meta name="msapplication-TileColor" content="#3372DF">
	<meta http-equiv="Cache-Control" content="no-siteapp">
    <script src="js/jquery.min.js"></script>
    <script src="js/json2.js"></script>
</head>
<body>  
    <%//=this.Request["QRCode"]    %>
    <%//=this.Request["wxcode"] %> 

        <%
            var wechat = iMidudu.Lucky.Web.WebServieFactiory.WeChat;
            var openResponse =wechat.getOpenId(this.Request["wxcode"]);
            var r = wechat.getUserInfo(openResponse);

            if (r.openid == null)
            {

                var returnUrl = string.Format("http://lucky.meduo.com.cn/Ticket1.aspx?QRCode={0}", this.Request["QRCode"]);
                returnUrl = System.Web.HttpContext.Current.Server.UrlEncode(returnUrl);
                var authUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=" + System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] + "/AuthCallback.aspx&response_type=code&scope=snsapi_userinfo&state=" + returnUrl + "#wechat_redirect";

                Response.Redirect(authUrl);


            }
            
            int count = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from ScanHistory where OpenId=@OpenId", new System.Data.SqlClient.SqlParameter("@OpenId", r.openid));
            int count1 = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from ScanHistory where OpenId=@OpenId and PrizeId is null", new System.Data.SqlClient.SqlParameter("@OpenId", r.openid));
            int count2 = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from ScanHistory where OpenId=@OpenId and PrizeId ='2eda98cd-326d-4da8-8a26-23aca4482717'", new System.Data.SqlClient.SqlParameter("@OpenId", r.openid));
            count = count - count1 - count2;
            if (count >= 5)
            {
                Response.Redirect("/Over5.aspx");

            }
            //wxuser:insert or update to database
            var biz =    iMidudu.Lucky.Web.WebServieFactiory.Biz;

            biz.SaveWXUser(new iMidudu.Lucky.Web.BizWebService.WXUser()
            {
                OpenId = openResponse.openid, Pic = r.headimgurl, NickName = r.nickname, Sex=  r.sex==1?true : false   , WXCity= r.city, WXCountry = r.country, WXProvince = r.province
            });

             %>
<%--        openId:<%=openResponse.openid %>
        <br />
        userInfo:
        openid <%=r.openid %><br />
        country <%=r.country %><br />
        province <%=r.province %><br />
        city <%=r.city %><br />
        headimgurl <%=r.headimgurl %>
        <img src="<%=r.headimgurl %>" width="100" />
        <br />
        language <%=r.language %><br />
        nickname <%=r.nickname %><br />
        sex <%=r.sex==1?"男" :"女" %><br />
        <%-- subscribe <%=r.subscribe %><%=r.subscribe==0?"No":"Yes" %><br />
           unionid <%=r.unionid %><br />--%>
       
            <%var c = wechat.Config(Request.Url.AbsoluteUri);%>
       <%--appId: '<%=c.appId %>',
                timestamp: <%=c.timestamp %>, 
                nonceStr: '<%=c.nonceStr %>',
                signature: '<%=c.signature %>',--%>
    <div class="container"><!-- Everything started here -->
	<img src="images/page_bg-01.png" alt="" class="bg-img-1">
	<div class="upload_invoice_modal">
		<div class="upload_inv_inner">
			<h2 class="title">发票号码<span class="sub-title">（信息供抽奖需求）</span></h2>
			<input type="text" class="inputsty mgb-sty1 background-color：fff" id="TicketNumber"  placeholder="请输入发票号码" >
            <%--<img id="Img1" width="300" />--%>
			<input type="button" class="buttonsty mgb-sty1" id="chooseImage" value="上传发票照片">
            <input type="button" id="uploadImage" value="上传小票照片" hidden  />
            <input type="button" id="downloadImage" value="下载小票照片"  hidden/> 
			<input type="button" class="buttonsty2 mgb-sty1" value="确定" onclick="goOn();">
            <%--<%= SuuSee.UserInfo.CurrentUser().data.city%>--%>
		</div>
	</div>
</div>

<%--    <input type="button" id="chooseImage" value="选择小票照片" />--%>
  <%-- <img id="preview" width="300" />--%>
<%--     <br />
    <input type="text" id="TicketNumber" />
    <br />
     <input type="button" id="ok"  value="确定" onclick="goOn();"/>--%>
    
         
    <div id="mediaid">

    </div>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <script> 
        var ticketUrl="";
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: '<%=c.appId %>', // 必填，公众号的唯一标识
                timestamp: <%=c.timestamp %>, // 必填，生成签名的时间戳
                nonceStr: '<%=c.nonceStr %>', // 必填，生成签名的随机串
                signature: '<%=c.signature %>',// 必填，签名，见附录1
                jsApiList: [
        'checkJsApi',
        'onMenuShareTimeline',
        'onMenuShareAppMessage',
        'onMenuShareQQ',
        'onMenuShareWeibo',
        'hideMenuItems',
        'showMenuItems',
        'hideAllNonBaseMenuItem',
        'showAllNonBaseMenuItem',
        'translateVoice',
        'startRecord',
        'stopRecord',
        'onRecordEnd',
        'playVoice',
        'pauseVoice',
        'stopVoice',
        'uploadVoice',
        'downloadVoice',
        'chooseImage',
        'previewImage',
        'uploadImage',
        'downloadImage',
        'getNetworkType',
        'openLocation',
        'getLocation',
        'hideOptionMenu',
        'showOptionMenu',
        'closeWindow',
        'scanQRCode',
        'chooseWXPay',
        'openProductSpecificView',
        'addCard',
        'chooseCard',
        'openCard'
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
        // 5 图片接口
        // 5.1 拍照、本地选图
        var images = {
            localId: [],
            serverId: []
        };
        
        wx.ready(function () {
            document.querySelector('#chooseImage').onclick = function () {
                wx.chooseImage({
                    success: function (res) {
                        images.localId = res.localIds;
                      //  alert('已选择 ' + res.localIds.length + ' 张图片,直接上传');
                        document.querySelector('#uploadImage').click();
                    }
                });
            };

            //// 5.2 图片预览
            //document.querySelector('#previewImage').onclick = function () {
            //    wx.previewImage({
            //        current: 'http://img5.douban.com/view/photo/photo/public/p1353993776.jpg',
            //        urls: [
            //          'http://img3.douban.com/view/photo/photo/public/p2152117150.jpg',
            //          'http://img5.douban.com/view/photo/photo/public/p1353993776.jpg',
            //          'http://img3.douban.com/view/photo/photo/public/p2152134700.jpg'
            //        ]
            //    });
            //};

            // 5.3 上传图片
            document.querySelector('#uploadImage').onclick = function () {
                if (images.localId.length == 0) {
                    alert('请先使用 chooseImage 接口选择图片');
                    return;
                }
                var i = 0, length = images.localId.length;
                images.serverId = [];
                function upload() {
                    wx.uploadImage({
                        localId: images.localId[i],
                        success: function (res) {
                            i++;
                          //  alert('已上传：' + i + '/' + length);
                            images.serverId.push(res.serverId);
                            if (i < length) {
                                upload();
                            }
                            else {    
                        //        alert("上传完毕,直接下载");
                                document.querySelector('#downloadImage').click();
                            }
                        },
                        fail: function (res) {
                            alert(JSON.stringify(res));
                        }
                    });
                }
                upload();
            };

            // 5.4 下载图片
            document.querySelector('#downloadImage').onclick = function () {

                if (images.serverId.length === 0) {
                    alert('请先使用 uploadImage 上传图片');
                    return;
                }

                <%// openResponse =wechat.getOpenId(this.Request["wxcode"]);%>
                var data = {ACCESS_TOKEN:'<%=wechat.AccessToken()%>',MEDIA_ID:images.serverId[0]};
              //alert(data.ACCESS_TOKEN);
               //return;
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Webservice.asmx/GetMultimedia",
                    data:JSON.stringify(data),
                    dataType: 'json',
                    success: function (result) {
                      //  alert(result.d);
                        $("#preview").attr("src",result.d);
                        ticketUrl=result.d;
                        $("#mediaid").html(data.ACCESS_TOKEN+"<br/>"+data.MEDIA_ID);
                        alert("上传成功");
                    }
                });
                return;
                var i = 0, length = images.serverId.length;
                images.localId = [];
                function download() {
                    wx.downloadImage({
                        serverId: images.serverId[i],
                        success: function (res) {
                            i++;
                            alert('已下载：' + i + '/' + length);
                            images.localId.push(res.localId);
                            if (i < length) {
                                download();
                            }
                        }
                    });
                }
                download();
            };
        });

        function goOn() {
            var TicketNumber=$("#TicketNumber").val();
            if (TicketNumber=="" && ticketUrl=="") {
                alert("上传收银小票或者输入流水号");
            //    if (ticketUrl=="") {
            //        //alert("上传收银小票或者输入流水号");
            //        alert("上传收银小票");
                return false;
            } 
            var data = {OpenId:'<%=openResponse.openid%>',TicketUrl:ticketUrl,TicketNumber:TicketNumber};
          //  alert(JSON.stringify(data));return;
              //alert(data.ACCESS_TOKEN);
               //return;
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Webservice.asmx/AddScanHistory",
                    data:JSON.stringify(data),
                    dataType: 'json',
                    success: function (result) {
                        //alert(result.d);
                        var historyId = result.d;
                        var qrCode = '<%=this.Request["QRCode"] %>';
                        var nextUrl = 'Lottery1.aspx?ScanHistoryId=' + historyId + "&QRCode="+qrCode;
                        window.location=nextUrl;
                    },
                    error:function(e){
                        alert(e.responseText);
                    }
                });
        }
    </script> 
</body>
    <!-- Javascript with AMD  -->
    <script src="js/require.js" data-main="js/main" ></script>
</html>
