<%@ Page Language="C#"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/jquery.min.js"></script>
    <script src="js/json2.js"></script>
    <script>
        function beginLottery() {
            var data = { QRCode: '<%=this.Request["QRCode" ]%>' };

            var str = JSON.stringify(data);
            alert(str);
            //window.location.href = '/LotteryResult/Activity1/Result1.aspx';
            //return;
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/PrizeLottery",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    var prize = result.d;
                    SavePrize(prize);
                },
                error: function (e) {
                    //alert("PrizeLottery");
                    alert("PrizeLottery" + e.responseText);
                    $("#msg").html(e.responseText);
                }
            });
        }
        function SavePrize(prize) {
            var data = { ScanHistoryId: '<%=this.Request["ScanHistoryId" ]%>', PrizeId: prize.PrizeId };

            var str = JSON.stringify(data);
            alert(str);
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/SavePrize",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    window.location.href = prize.URL + "?ScanHistoryId=" + data.ScanHistoryId + "&PrizeId=" + data.PrizeId;
                },
                error: function (e) {
                    alert("SavePrize wrong");
                    alert(e.responseText);
                }
            });
        }

    </script>
</head>
<body>
    <%=this.Request["ScanHistoryId" ]%>,
    <%=this.Request["QRCode" ]%>


    <div style="width:400px;height:400px;">
        抽奖大转盘
    </div>
    <div id="msg"></div>
    <input id="beginLottery" type="button" value="开始抽奖" onclick="beginLottery();" />

</body>
</html>
