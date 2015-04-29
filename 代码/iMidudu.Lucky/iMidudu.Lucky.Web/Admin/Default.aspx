<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="iMidudu.Lucky.Web.Admin.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script runat="server">
            //private int totalCount;
            //private string ky = "";
            //protected override void OnLoad(EventArgs e)
            //{
            //    base.OnLoad(e);
            //    ky = this.Request["key"];
            //    if (!IsPostBack)
            //    {
            //        this.LoadData();
            //        AspNetPager1.RecordCount = totalCount;
            //        //bindData(); //使用url分页，只需在分页事件处理程序中绑定数据即可，无需在Page_Load中绑定，否则会导致数据被绑定两次
            //    }
            //}
            //private System.Data.SqlClient.SqlDataReader LoadData()
            //{

            //    var key = (ky == null ? "" : ky);
            //    totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from WXUser");
            //    var dr = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("",
            //       new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
            //       new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex)
            //       );
            //    return dr;
            //}
            //public override void DataBind()
            //{
            //    this.Repeater1.DataSource = this.LoadData();
            //    base.DataBind();

            //}


            //protected void AspNetPager1_PageChanged(object src, EventArgs e)
            //{
            //    this.DataBind();
            //}
        </script>
       <script>

           //function dosearch() {
           //    var k = $("#key").val();
           //    if (key == null || key == "") {
           //    }

           //    window.location.href = "UserManager.aspx?key=" + k;
           //}
           function DownLoad() {
               var k = $("#key").val();
               var sql = "select ActivityName as 活动,PrizeName as奖项,Quantity as 奖项总数,getcount as 已领数量,rad as 剩余数量, Today as 今日领取次数,Yesterday as 昨日领取次数,WEeek as 近一周领取次数,Monse as 近一月领取次数 from View_Count";
               var url = "/Admin/OutExcelDown.ashx?filename=扫码用户.xls&sql=" + sql;
               //alert(sql);
               window.open(url);
               return;
               var content = $("#content").html();
               var data = { body: content };
               $.ajax({
                   type: "POST",
                   contentType: "application/json",
                   url: "Webservice.asmx/ExcelContentSaveToTemp",
                   data: JSON.stringify(data),
                   dataType: 'json',
                   success: function (fn) {
                       var url = "/Admin/OutExcel.ashx?filename=扫码用户.xls&ContentFile=" + fn.d;
                       window.open(url, "_blank");
                   }
               });

           }

    </script>
    <article class="module width_full">
         
            <header> 
                <h3 class="tabs_involved">奖项统计</h3>
            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <div id="content">
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                        
                        <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>活动+奖项</th>
                                        <th>奖项总数</th>
                                        <th>已领数量</th>
                                        <th>剩余数量</th>
                                        <th>今日领取数量</th>
                                        <%--<th>昨日领取数量</th>--%>
                                        <th>近一周领取数量</th>
                                        <th>近一月领取数量</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                 <tr>  
                                    <td><%#Eval("ActivityName") %>+<%#Eval("PrizeName") %></td>
                                    <td><%#Eval("Quantity") %></td>
                                    <td><%#Eval("getcount") %></td>
                                     <td><%#Eval("rad") %></td>
                                    <td><%#Eval("Today") %></td>
                                    <%--<td><%#Eval("Yesterday") %></td>--%>
                                     <td><%#Eval("WEeek") %></td>
                                    <td><%#Eval("Monse") %></td>
                                </tr>
                        </ItemTemplate>
                        <FooterTemplate>

                            </tbody>
                    </table>
                            
                        </FooterTemplate>
                    </asp:Repeater>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LuckyConnectionString %>" SelectCommand="SELECT * FROM [View_Count] ORDER BY [QRCode], [PrizeId]"></asp:SqlDataSource>
                      </div>
                    
                     <footer>
            <div class="submit_link">
                <input type="submit" value="导出Excel" class="alt_btn" onclick="DownLoad();"  />
            </div>
                        </footer>
                     <%--<div class="post_message">
                <label>汇总：&nbsp&nbsp&nbsp&nbsp 有</label>
                <label><%#totalCount%>人</label>
                <label>参加过活动</label>
            </div>--%>
                </div>
                <!-- end of #tab1 -->

            </div>
            <!-- end of .tab_container -->
        
        </article>
</asp:Content>
