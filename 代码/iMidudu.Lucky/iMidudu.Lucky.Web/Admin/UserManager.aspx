<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script runat="server">
        private int totalCount;
        private string ky = "";
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            ky = this.Request["key"];
            if (!IsPostBack)
            {
                this.LoadData();
                AspNetPager1.RecordCount = totalCount;
                //bindData(); //使用url分页，只需在分页事件处理程序中绑定数据即可，无需在Page_Load中绑定，否则会导致数据被绑定两次
            }
        }
        private System.Data.SqlClient.SqlDataReader LoadData()
        {

            var key = (ky == null ? "" : ky);
            totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from WXUser where NickName like '%'+ @key +'%'", new System.Data.SqlClient.SqlParameter("@key", key));
            var dr = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("WXNameSearch_Procedure",
               new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
               new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex),
               new System.Data.SqlClient.SqlParameter("@key", key)
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

        function dosearch() {
            var k = $("#key").val();
            if (key == null || key == "") {
            }

            window.location.href = "UserManager.aspx?key=" + k;
        }
        function DownLoad() {
            var k = $("#key").val();
            var sql = "select NickName as 昵称,WXCountry as 国家,WXProvince as 省,WXCity as 市, TotalCount as 扫码次数,LastActiveTime as 最近活跃时间,RegisterDate as 最后一次活跃时间 from UserManager_view where NickName  like '%<%=this.Request["key"]%>%' order by LastActiveTime desc ";
            var url = "/Admin/OutExcelDown.ashx?filename=用户信息<%=DateTime.Now.ToString("yyyy-MM-dd-HH-mm-ss")%>.xls&sql=" + sql;
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
    <div align="center">
        <input type="text" id="key" value="" placeholder="按昵称查询" />
        <input type="button" onclick="dosearch();" value="按昵称查询" class="alt_btn" />
    </div>
    <article class="module width_full">

        <header>
            <h3 class="tabs_involved">微信用户信息</h3>
        </header>
        <div class="tab_container">
            <div id="tab1" class="tab_content">
                <div id="content">
                    <asp:Repeater ID="Repeater1" runat="server">

                        <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>昵称</th>
                                        <th>性别</th>
                                        <th>国家</th>
                                        <th>省</th>
                                        <th>市(区)</th>
                                        <th>扫码次数</th>
                                        <th>最近活跃时间</th>
                                        <th>第一次活跃时间</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                <tr>
                                    <td><%#Eval("NickName") %></td>
                                    <td><%#Convert.ToBoolean(Eval("Sex")) ==true?"男":"女"%></td>
                                    <td><%#Eval("WXCountry") %></td>
                                    <td><%#Eval("WXProvince") %></td>
                                    <td><%#Eval("WXCity") %></td>
                                    <td><%#Eval("TotalCount") %></td>
                                    <td><%#Eval("LastActiveTime") %></td>
                                    <td><%#Eval("RegisterDate") %></td>
                                </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                    </table>
                            
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" Width="100%" UrlPaging="true" ShowPageIndexBox="Always" PageIndexBoxType="DropDownList" ShowCustomInfoSection="Left"
                    FirstPageText="【首页】"
                    LastPageText="【尾页】" NextPageText="【后页】"
                    PrevPageText="【前页】" NumericButtonTextFormatString="【{0}】" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到第" HorizontalAlign="right" PageSize="10" OnPageChanged="AspNetPager1_PageChanged" EnableTheming="true" CustomInfoHTML="当前第  <font color='red'><b>%CurrentPageIndex%</b></font> 页,共  %PageCount%  页 ,总共:%RecordCount% 条数据">
                </webdiyer:AspNetPager>
                <footer>
                    <div class="submit_link">
                        <input type="submit" value="导出Excel" class="alt_btn" onclick="DownLoad();" />
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
