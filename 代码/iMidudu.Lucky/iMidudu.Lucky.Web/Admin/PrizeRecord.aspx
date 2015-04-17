<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script>
        function DownLoad() {
            var k = $("#key").val();
            var sql = "select NickName as 昵称,Sex as 性别,WXCountry as 国家,WXProvince as 省,WXCity as 市, TotalCount1 as 活动一领取次数,TotalCount2 as 活动二领取次数,TotalCount3 as 活动三领取次数,TotalCount as 领取总次数 from View_top10 ";
            var url = "/Admin/OutExcelDown.ashx?filename=扫码用户.xls&sql=" + sql;
            //alert(sql);
            window.open(url);
            return;
        var content = $("#content").html();
        var data = { body: content };
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/Webservice.asmx/ExcelContentSaveToTemp",
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (fn) {
                var url = "/Admin/OutExcel.ashx?filename=领取金额TOP10.xls&ContentFile=" + fn.d;
                window.open(url, "_blank");
            }
        });
    }
    </script>
    <article class="module width_full">
        <header>
            <h3 class="tabs_involved">奖项记录TOP10 </h3>
        </header>
<%--        SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory
                     WHERE   (OpenId = dbo.WXUser.OpenId))--%>
        <div class="tab_container">
            <div id="tab1" class="tab_content">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LuckyConnectionString %>" SelectCommand="
                    SELECT   TOP 10  OpenId, NickName, Pic, Sex, WXCity, WXProvince, WXCountry, RegisterDate, LastActiveTime,
                      ((SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory AS ScanHistory_3 INNER JOIN
                                     dbo.Prize ON ScanHistory_3.PrizeId = dbo.Prize.PrizeId
                     WHERE   (ScanHistory_3.OpenId = dbo.WXUser.OpenId) AND 
                                     (dbo.Prize.QRCode = '4d618408-d3f3-4d7b-8c0d-a42e9c31fe81'))+   (SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory AS ScanHistory_3 INNER JOIN
                                     dbo.Prize ON ScanHistory_3.PrizeId = dbo.Prize.PrizeId
                     WHERE   (ScanHistory_3.OpenId = dbo.WXUser.OpenId) AND 
                                     (dbo.Prize.QRCode = '4d618408-d3f3-4d7b-8c0d-a42e9c31fe82'))+  (SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory AS ScanHistory_3 INNER JOIN
                                     dbo.Prize ON ScanHistory_3.PrizeId = dbo.Prize.PrizeId
                     WHERE   (ScanHistory_3.OpenId = dbo.WXUser.OpenId) AND 
                                     (dbo.Prize.QRCode = '4d618408-d3f3-4d7b-8c0d-a42e9c31fe83')))AS TotalCount,
                    (SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory AS ScanHistory_3 INNER JOIN
                                     dbo.Prize ON ScanHistory_3.PrizeId = dbo.Prize.PrizeId
                     WHERE   (ScanHistory_3.OpenId = dbo.WXUser.OpenId) AND 
                                     (dbo.Prize.QRCode = '4d618408-d3f3-4d7b-8c0d-a42e9c31fe81')) AS TotalCount1,
                    (SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory AS ScanHistory_2 INNER JOIN
                                     dbo.Prize AS Prize_2 ON ScanHistory_2.PrizeId = Prize_2.PrizeId
                     WHERE   (ScanHistory_2.OpenId = dbo.WXUser.OpenId) AND 
                                     (Prize_2.QRCode = '4d618408-d3f3-4d7b-8c0d-a42e9c31fe82')) AS TotalCount2,
                    (SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory AS ScanHistory_1 INNER JOIN
                                     dbo.Prize AS Prize_1 ON ScanHistory_1.PrizeId = Prize_1.PrizeId
                     WHERE   (ScanHistory_1.OpenId = dbo.WXUser.OpenId) AND 
                                     (Prize_1.QRCode = '4d618408-d3f3-4d7b-8c0d-a42e9c31fe83')) AS TotalCount3
FROM      dbo.WXUser WHERE ((SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory AS ScanHistory_3 INNER JOIN
                                     dbo.Prize ON ScanHistory_3.PrizeId = dbo.Prize.PrizeId
                     WHERE   (ScanHistory_3.OpenId = dbo.WXUser.OpenId) AND 
                                     (dbo.Prize.QRCode = '4d618408-d3f3-4d7b-8c0d-a42e9c31fe81'))+   (SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory AS ScanHistory_3 INNER JOIN
                                     dbo.Prize ON ScanHistory_3.PrizeId = dbo.Prize.PrizeId
                     WHERE   (ScanHistory_3.OpenId = dbo.WXUser.OpenId) AND 
                                     (dbo.Prize.QRCode = '4d618408-d3f3-4d7b-8c0d-a42e9c31fe82'))+  (SELECT   COUNT(*) AS Expr1
                     FROM      dbo.ScanHistory AS ScanHistory_3 INNER JOIN
                                     dbo.Prize ON ScanHistory_3.PrizeId = dbo.Prize.PrizeId
                     WHERE   (ScanHistory_3.OpenId = dbo.WXUser.OpenId) AND 
                                     (dbo.Prize.QRCode = '4d618408-d3f3-4d7b-8c0d-a42e9c31fe83')))>0
ORDER BY TotalCount DESC"></asp:SqlDataSource>

                <div  id="content">
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <HeaderTemplate>
                        <table class="tablesorter" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>排名</th>
                                    <th>昵称</th>
                                    <th>性别</th>
                                    <th>国家(微信)</th>
                                    <th>省(微信)</th>
                                    <th>市(区)（微信）</th>
                                    <th>活动一领取次数</th>
                                    <th>活动二领取次数</th>
                                    <th>活动三领取次数</th>
                                    <th>领取总次数</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.ItemIndex+1 %></td> 
                            <td><%#Eval("NickName") %> </td>
                            <td><%#Convert.ToBoolean(Eval("Sex")) ==true?"男":"女"%></td>
                            <td><%#Eval("WXCountry")%></td> 
                            <td><%#Eval("WXProvince") %></td>
                            <td><%#Eval("WXCity")%></td> 
                            <td><%#Eval("TotalCount1") %> </td>
                            <td><%#Eval("TotalCount2") %> </td>
                            <td><%#Eval("TotalCount3") %> </td>
                            <td><%#Eval("TotalCount") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                    </table>
                    </FooterTemplate>
                </asp:Repeater>
</div>

                <footer>
                    <div class="submit_link">
                        <input type="submit" value="导出表格" class="alt_btn" onclick="DownLoad();">
                    </div>
                </footer>
            </div>
            <!-- end of #tab1 -->



        </div>
        <!-- end of .tab_container -->

    </article>
</asp:Content>
