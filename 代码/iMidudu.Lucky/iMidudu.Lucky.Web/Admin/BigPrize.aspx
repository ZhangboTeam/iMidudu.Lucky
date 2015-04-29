<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="BigPrize.aspx.cs" Inherits="iMidudu.Lucky.Web.Admin.BigPrize" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
        <script runat="server">
            private int totalCount;
            private string ky = "";
            protected override void OnLoad(EventArgs e)
            {
                base.OnLoad(e);
                if (!IsPostBack)
                {
                    this.LoadData();
                    AspNetPager1.RecordCount = totalCount;
                    //bindData(); //使用url分页，只需在分页事件处理程序中绑定数据即可，无需在Page_Load中绑定，否则会导致数据被绑定两次
                }
            }
            private System.Data.SqlClient.SqlDataReader LoadData()
            {
                totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from View_BigSearch ");
                var dr = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("BigPrize_Procedures",
                   new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
                   new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex)
                   );
                return dr;
            }
            public override void DataBind()
            {
                this.Repeater1.DataSource = this.LoadData();
                base.DataBind();

            }


            protected void AspNetPager1_PageChanged(object src, EventArgs e)
            {
                this.DataBind();
            }
        </script>
       <script>
           function UpdateAll() {
               var data = new Array();
               //var data1 = new Array();
               //var PrizeId = $(this).attr("code");
               //var PrizeName= $("#NewPrizeIdName").val();
               //var Quantity = parseInt($("#NewQuantity").val());
               $("input[tag='txt']").each(function () {
                   data.push({
                       PrizeId: $(this).attr("code"),
                       Status: $(this).val()
                       //,
                       //Quantity: $("#NewQuantity").val()
                   });
               })

               //$("input[tag='txt1']").each(function () {
               //    data1.push({
               //        PrizeId: $(this).attr("code1"),
               //        Quantity: $(this).NewQuantity.val()
               //    });
               //});
               var arg = {
                   datasssss: data
               }
               $.ajax({
                   type: "POST",
                   contentType: "application/json",
                   url: "/Webservice.asmx/UpdateBigPrize",
                   data: JSON.stringify(arg),
                   dataType: 'json',
                   success: function (result) {

                       // alert("ok");

                       window.location.reload();

                   },
                   error: function (err) {
                       alert(err.responseText);
                   }
               });
           }

           function DownLoad() {
               var sql = "select ActivityName as 活动获奖,UserName as 获奖姓名,Sex as 性别,Mobile as 获奖手机号,Address as 获奖人地址, ScanDate as 获奖时间 from View_BigSearch ";
               var url = "/Admin/OutExcelDown.ashx?filename=大奖统计.xls&sql=" + sql;
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
                <h3 class="tabs_involved">大奖统计</h3>
            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <div id="content">
                        <%--DataSourceID="SqlDataSource1"--%>
                    <asp:Repeater ID="Repeater1" runat="server" >
                        
                        <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>活动获奖</th>
                                        <th>获奖姓名</th>
                                        <th>性别</th>
                                        <th>获奖手机号</th>
                                        <th>获奖人地址</th>
                                        <th>获奖时间</th>
                                        <%--<th>是否发货</th>--%>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                 <tr>  
                                     <%--+<%#Eval("PrizeName") %>--%>
                                    <td><%#Eval("ActivityName") %></td>
                                    <td><%#Eval("UserName") %></td>
                                     <td><%#Eval("Sex") %></td>
                                    <td><%#Eval("Mobile") %></td>
                                     <td><%#Eval("Address") %></td>
                                     <td><%#Eval("ScanDate") %></td>
                                     <td>
                                    <%--<input tag="txt" onclick="this.select();"
                                         code="<%#Eval("PrizeId") %>"
                                         id=" NewPrizeName" <%=this.Request["NewPrizeName"] %>type="text" style="width:100%;" value="<%#Eval("Status") %>" />--%></td>
                                    

                                </tr>
                        </ItemTemplate>
                        <FooterTemplate>

                            </tbody>
                    </table>
                        </FooterTemplate>
                    </asp:Repeater>
                        <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LuckyConnectionString %>" SelectCommand="SELECT * FROM [View_BigSearch] ORDER BY [QRCode], [PrizeId]"></asp:SqlDataSource>--%>
                        <webdiyer:AspNetPager ID="AspNetPager1" runat="server" Width="100%" UrlPaging="true" ShowPageIndexBox="Always" PageIndexBoxType="DropDownList" ShowCustomInfoSection="Left"
                    FirstPageText="【首页】"
                    LastPageText="【尾页】" NextPageText="【后页】"
                    PrevPageText="【前页】" NumericButtonTextFormatString="【{0}】" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到第" HorizontalAlign="right" PageSize="10" OnPageChanged="AspNetPager1_PageChanged" EnableTheming="true" CustomInfoHTML="当前第  <font color='red'><b>%CurrentPageIndex%</b></font> 页,共  %PageCount%  页 ,总共:%RecordCount% 条数据">
                </webdiyer:AspNetPager>
                      </div>
                     <div class="submit_link">
               <%-- <input type="submit" value="批量更新" class="alt_btn" onclick="UpdateAll();"/>--%>
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
