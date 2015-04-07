<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<script runat="server"> 

    private int totalCount;
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        if (!IsPostBack)
        {
            if (string.IsNullOrEmpty(this.Request["key1"]) ||string.IsNullOrEmpty(this.Request["key2"]))
            {
                return;
            }
            this.LoadData();
            AspNetPager1.RecordCount = totalCount;
            //bindData(); //使用url分页，只需在分页事件处理程序中绑定数据即可，无需在Page_Load中绑定，否则会导致数据被绑定两次
        }
    }

    private System.Data.SqlClient.SqlDataReader LoadData()
    {
        totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from ScanHistory ");
        var keyb = new System.Data.SqlClient.SqlParameter("@beginDate", DateTime.Parse(this.Request["key1"]));
        var keye = new System.Data.SqlClient.SqlParameter("@endDate", DateTime.Parse(this.Request["key2"]).AddDays(1));
        //cmd./ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        var cmd = new System.Data.SqlClient.SqlCommand();
        //Response.Write(keye);
        //Response.End();
        var cn = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.AppSettings["con"]);
        cmd.Connection = cn;
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.CommandText = "TimeSearch_Procedure";
        cmd.Parameters.AddRange(new System.Data.SqlClient.SqlParameter[] {
           new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
           new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex),
           keyb,keye
        });
        cn.Open();
        var dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        var key4 = this.Request["key2"];
        DateTime key3 = Convert.ToDateTime(key4);
        key3 = key3.AddDays(1);
        return dr;
        
    }
    public override void DataBind()
    {
        if (string.IsNullOrEmpty(this.Request["key1"]) ||string.IsNullOrEmpty(this.Request["key1"]))
        {
            return;
        }
        if (string.IsNullOrEmpty(this.Request["key2"]) ||string.IsNullOrEmpty(this.Request["key2"]))
        {
            return;
        }
        this.Repeater1.DataSource = this.LoadData();
        base.DataBind();

    }
    protected void AspNetPager1_PageChanged(object src, EventArgs e)
    {
        this.DataBind();
    }
</script>
 
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script>

        function dosearch() {
            var key1 = $("#key1").val();
            var key2 = $("#key2").val();
            if (key1 == "" || key1 == null) {
                // return;
            }
            if (key2 == "" || key2 == null) {
                // return;
            }
            window.location.href = "TimeSearch.aspx?key1=" + key1 + "&key2=" + key2;
        }

        function DownLoad() {
            var key1 = $("#key1").val();
            var key2 = $("#key2").val();
            alert(key1);
            var sql = "select URLCode as Code,IP as 浏览者IP,country as 浏览者国家,city as 浏览者城市, [district] as 浏览者市区,os as 浏览者系统,viewdate as 浏览时间 from ViewHistory  where  ViewDate>='2015-04-01' and ViewDate<='2015-04-02'";
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
     
        <div class="quick_search ">
            <input type="text" id="key1" value="<%=DateTime.Today.AddDays(-7).ToString("yyyy-MM-dd") %>" style="width:auto;" />
			<input type="text"id="key2" value="<%=DateTime.Today.ToString("yyyy-MM-dd") %>"  style="width:auto;"/>
                <input type="submit" value="搜索" onclick="dosearch();" class="alt_btn"/>
		</div> 
    <article class="module width_full">
        <header>
            <h3 class="tabs_involved">按时间查询</h3>
        </header>
        <div class="tab_container">
            <div id="tab1" class="tab_content">
                 
                <div id="content">

                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                    <thead>
                        <tr>
                                        <th >扫码历史id</th>
                                        <th>微信id</th>
                                        <th>奖项id</th>
                                        <th>ip</th>
                                        <th>国家</th>
                                        <th>省市</th>
                                        <th>市</th>
                                        <th>手机系统</th>
                                        <th>扫码时间</th>
                                        <th>参加活动url</th>
                                    </tr>
                    </thead>
                    <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                                    <td><%#Eval("ScanHistoryId") %></td>   
                                    <td><%#Eval("OpenId") %></td> 
                                    <td><%#Eval("PrizeId") %></td>
                                    <td><%#Eval("IP") %></td>
                                    <td><%#Eval("Country") %></td>
                                    <td><%#Eval("Province") %></td>
                                    <td><%#Eval("City") %></td>
                                    <td><%#Eval("Os") %></td>
                                    <td><%#Eval("ScanDate") %></td>
                                    <td><%#Eval("TicketUrl") %></td>
                                </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                    </tbody>
                </table>
                    </FooterTemplate>
                </asp:Repeater>
                    </div>
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" Width="100%" UrlPaging="true" ShowPageIndexBox="Always" PageIndexBoxType="DropDownList"  
                    FirstPageText="【首页】"
    LastPageText="【尾页】" NextPageText="【后页】"
        PrevPageText="【前页】" NumericButtonTextFormatString="【{0}】"   TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到第"  HorizontalAlign="right" PageSize="10" OnPageChanged="AspNetPager1_PageChanged" EnableTheming="true" CustomInfoHTML="Page  <font color='red'><b>%CurrentPageIndex%</b></font> of  %PageCount%  Order %StartRecordIndex%-%EndRecordIndex%">
                </webdiyer:AspNetPager>
            </div>
            <footer>
            <div class="submit_link">
                <input type="submit" value="导出Excel" class="alt_btn" onclick="DownLoad();"  />
            </div>
                        </footer>
            <!-- end of #tab1 -->



        </div>
        <!-- end of .tab_container -->
    </article>

</asp:Content>
