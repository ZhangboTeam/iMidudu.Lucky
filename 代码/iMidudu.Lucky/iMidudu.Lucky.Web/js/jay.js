/*
微信上传图片JSsdk 方法：
文档地址:http://mp.weixin.qq.com/wiki/7/aaa137b55fb2e0456bf8dd9148dd613f.html#.E4.B8.8A.E4.BC.A0.E5.9B.BE.E7.89.87.E6.8E.A5.E5.8F.A3
wx.uploadImage({
    localId: '', // 需要上传的图片的本地ID，由chooseImage接口获得
    isShowProgressTips: 1, // 默认为1，显示进度提示
    success: function (res) {
        var serverId = res.serverId; // 返回图片的服务器端ID
    }
});

*/