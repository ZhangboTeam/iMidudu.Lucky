<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>  
    <%=this.Request["QRCode"]    %>
        wxcode=<%=this.Request["wxcode"] %> 

        <%
            var wechat = iMidudu.Lucky.Web.WebServieFactiory.WeChat;
            var openResponse =wechat.getOpenId(this.Request["wxcode"]);
            var r = wechat.getUserInfo(openResponse);
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
    <input type="button" id="chooseImage" value="上传小票照片" />
    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <script> 

            wx.config({
                debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
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
        document.querySelector('#chooseImage').onclick = function () {
            wx.chooseImage({
                success: function (res) {
                    images.localId = res.localIds;
                    alert('已选择 ' + res.localIds.length + ' 张图片');
                }
            });
        };

        // 5.2 图片预览
        document.querySelector('#previewImage').onclick = function () {
            wx.previewImage({
                current: 'http://img5.douban.com/view/photo/photo/public/p1353993776.jpg',
                urls: [
                  'http://img3.douban.com/view/photo/photo/public/p2152117150.jpg',
                  'http://img5.douban.com/view/photo/photo/public/p1353993776.jpg',
                  'http://img3.douban.com/view/photo/photo/public/p2152134700.jpg'
                ]
            });
        };

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
                        alert('已上传：' + i + '/' + length);
                        images.serverId.push(res.serverId);
                        if (i < length) {
                            upload();
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

    </script> 
</body>
</html>
