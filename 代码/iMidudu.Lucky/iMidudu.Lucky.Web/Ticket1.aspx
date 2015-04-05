<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/jquery.min.js"></script>
    <script src="js/json2.js"></script>
</head>
<body>  
    <%=this.Request["QRCode"]    %>
        wxcode=<%=this.Request["wxcode"] %> 

        <%
            var wechat = iMidudu.Lucky.Web.WebServieFactiory.WeChat;
            var openResponse =wechat.getOpenId(this.Request["wxcode"]);
            var r = wechat.getUserInfo(openResponse);

            //wxuser:insert or update to database
            var biz =    iMidudu.Lucky.Web.WebServieFactiory.Biz;

            biz.SaveWXUser(new iMidudu.Lucky.Web.BizWebService.WXUser()
            {
                 OpenId = openResponse.openid, Pic = r.headimgurl, NickName = r.nickname, Sex=  r.sex==0   , WXCity= r.city, WXCountry = r.country, WXProvince = r.province
            });

             %>
        openId:<%=openResponse.openid %>
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
        <%-- subscribe <%=r.subscribe %><%=r.subscribe==0?"No":"Yes" %><br />--%>
           unionid <%=r.unionid %><br />
       
    
    <hr />
            <%var c = wechat.Config(Request.Url.AbsoluteUri);%>
       appId: '<%=c.appId %>',
                timestamp: <%=c.timestamp %>, 
                nonceStr: '<%=c.nonceStr %>',
                signature: '<%=c.signature %>',
    <input type="button" id="chooseImage" value="选择小票照片" />
    <input type="button" id="uploadImage" value="上传小票照片" hidden  />
    <input type="button" id="downloadImage" value="下载小票照片"  hidden/> 
    <img id="preview" width="300" />
    <br />
    <input type="text" id="TicketNumber" />
    <br />
     <input type="button" id="ok"  value="确定" onclick="goOn();"/>
    <%= SuuSee.UserInfo.CurrentUser().data.city
         %>
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
            if (TicketNumber=="" &&ticketUrl=="") {
                alert("上传收银小票或者输入流水号");
                return false;
            } 
            var data = {OpenId:'<%=openResponse.openid%>',TicketUrl:ticketUrl,TicketNumber:TicketNumber};
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
</html>
