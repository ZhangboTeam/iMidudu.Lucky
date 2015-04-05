<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="/js/jquery.min.js"></script>
    <script src="/js/json2.js"></script>
    <script>
        function sendValidCode() {
            var Mobile = $("#Mobile").val();
            var data = { mobile: Mobile };
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/SendValidCodeToMobile",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                   // alert(result.d);
                    $("#msg").html("验证码已发送到手机:" + data.mobile);
                },
                error: function (result) {
                    alert(result.responseText);
                }
            });
        }
        function OK() {
            //各种验证数据完整性
        }
    </script>
</head>
<body>
  ScanHistoryId:  <%=this.Request["ScanHistoryId" ]%>,
   PrizeId: <%=this.Request["PrizeId" ]%>
    <hr />
    抽奖结果1
    <hr />
    <h1>以下是需要提供个人信息以发放大奖</h1>
    Address:<input id="Address" type="text" value="上海...." />
    <br />
    Mobile:<input id="Mobile" type="text" value="18516518578"/><input id="smsCode" type="button" value="Send Valid Code" onclick="sendValidCode();" />
    <div id="msg"></div>
    <br />
    短信验证码:<input id="Code" type="text" />
    <br />
    UserName:<input id="UserName" type="text" value="username" />
    <br />
    <input id="Button1" type="button" value="确认我的信息" onclick="OK();" />
</body>
</html>
