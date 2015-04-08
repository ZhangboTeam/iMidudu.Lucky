<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
<script>
    function DownLoad() {
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
    <section id="secondary_bar">

        <div class="breadcrumbs_container">
            <article class="breadcrumbs">
                <a class="current">红包历史查看</a>
                <div class="breadcrumb_divider"></div>
                <a class="current2">领取金额TOP10</a>
            </article>
        </div>
    </section>
    <article class="module width_full">
        <header>
            <h3 class="tabs_involved">奖项记录TOP10 </h3>
        </header>
        <div class="tab_container">
            <div id="tab1" class="tab_content">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LuckyConnectionString %>" SelectCommand="SELECT TOP (10) ActivityName, PrizeName, NickName, Sex, WXCountry, WXProvince, WXCity, Country, Province, City, Quantity FROM record_view ORDER BY PrizeName DESC"></asp:SqlDataSource>

                <div  id="content">
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <HeaderTemplate>
                        <table class="tablesorter" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>活动名</th>
                                    <th>奖项名</th>
                                    <th>昵称</th>
                                    <th>性别</th>
                                    <th>国家(微信)</th>
                                    <th>省(微信)</th>
                                    <th>市(区)（微信）</th>
                                    <th>国家(扫码)</th>
                                    <th>省(扫码)</th>
                                    <th>市(区)（扫码）</th>
                                    <th>领取总次数</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%#Eval("ActivityName")%></td>
                            <td><%#Eval("PrizeName")%></td>
                            <td><%#Eval("NickName") %> </td>
                            <td><%#Convert.ToBoolean(Eval("Sex")) ==true?"男":"女"%></td>
                            <td><%#Eval("WXCountry")%></td> 
                            <td><%#Eval("WXProvince") %></td>
                            <td><%#Eval("WXCity")%></td> 
                            <td><%#Eval("Country") %> </td>
                            <td><%#Eval("Province") %> </td>
                            <td><%#Eval("City") %> </td>
                            <td><%#Eval("Quantity") %></td>
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
