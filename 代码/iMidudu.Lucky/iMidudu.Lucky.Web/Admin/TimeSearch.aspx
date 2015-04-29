<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"  Debug="true"%>
<script runat="server"> 
    private int totalCount;
    private int totalCount2;
    private int totalCount50;
    private int totalOpenId;
    private double totalMoney;
    private string ky1 = "";
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        ky1 = this.Request["key"];
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
        var key = (ky1 == null ? "" : ky1);
        var keyb = new System.Data.SqlClient.SqlParameter("@beginDate", DateTime.Parse(this.Request["key1"]));
        var keye = new System.Data.SqlClient.SqlParameter("@endDate", DateTime.Parse(this.Request["key2"]).AddDays(1));
        Console.WriteLine(DateTime.Parse(this.Request["key2"]));
        var cmd = new System.Data.SqlClient.SqlCommand();
        var cn = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.AppSettings["con"]);
        cmd.Connection = cn;
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.CommandText = "TimeSearchs_Procedure";
        cmd.Parameters.AddRange(new System.Data.SqlClient.SqlParameter[] {
           new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
           new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex),
           new System.Data.SqlClient.SqlParameter("@key", key),
           keyb,keye
           
        });
        cn.Open();
        var dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        var key4=this.Request["key2"];
        DateTime key3 = Convert.ToDateTime(key4);
        key3 = key3.AddDays(1);
        string sql1 = string.Format("select  count(*) from record_view where ActivityName='{0}'",
            this.Request["key"]);
        string sql2 = string.Format("select  isnull(count(*),0) from record_view where ActivityName='{0}'",
            this.Request["key"]);
        string sql3 = string.Format("select  isnull(count(*),0) from record_view where ActivityName='{0}'",
            this.Request["key"]);
        string sql4 = string.Format("select  isnull(count(*),0) from record_view where ActivityName='{0}'",
            this.Request["key"]);
        string sql5 = string.Format("select  isnull(count(distinct([OpenId] )),0) from record_view where ActivityName='{0}'",
            this.Request["key"]);
        string sql6 = string.Format("select  isnull(SUM(amount),0) from record_view where ActivityName='{0}'",
            this.Request["key"]);
        this.totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText(sql1);

        this.totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText(sql2);
        this.totalCount2 = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText(sql3);
        this.totalCount50 = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText(sql4);
        this.totalOpenId = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText(sql5);
        try
        {
            this.totalMoney = (double)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText(sql6);
        }
        catch
        {
            this.totalMoney = 0;
        }
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
<asp:Content ID="Content2" ContentPlaceHolderID="PageBody" runat="server">
    <script>

        function dosearch() {
            var key1 = $("#key1").val();
            var key2 = $("#key2").val();
            var key = $("#key").val();
            var k3 = $("#key3").val();
            if (key1 == "" || key1 == null) {
                // return;
            }
            if (key2 == "" || key2 == null) {
                // return;
            }
            if (key == "" || key == null) {
                // return;
            }
            window.location = "TimeSearch.aspx?key1=" + key1 + "&key2=" + key2 + "&key=" + key;
        }

        function DownLoad() {
            var key = $("#key").val();
            var key1 = $("#key1").val();
            var key2 = $("#key2").val();;
            var k3 = $("#key3").val();
            var sql = "select ActivityName as 活动名,PrizeName as 奖项名,TicketNumber as 流水号, NickName as 昵称,(case Sex when 1 then '男' else '女' end) as 性别,WXCountry as 国家,WXProvince as 省,WXCity as 市,Country as 国家扫码,Province as 省扫码,City as 市扫码,ScanDate as 抽奖时间, LastActiveTime as 最近活跃时间,RegisterDate as 最后一次活跃时间 from record_view  where ActivityName='<%=this.Request["key"]%>'  and  ScanDate>=' " + key1 + "' and ScanDate <= ' " + k3 + "' order by ScanDate desc  ";
            
            var url = "/Admin/OutExcelDown.ashx?filename=时间搜索<%=DateTime.Now.ToString("yyyy-MM-dd-HH-mm-ss")%>.xls&sql=" + sql;
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

                    var url = "/Admin/OutExcel.ashx?filename=时间搜索用户.xls&ContentFile=" + fn.d;
                    window.open(url, "_blank");
                }
            });
        }

    </script>
        <div class="quick_search ">
            <%
                var d1=DateTime.Today.AddDays(-7).ToString("yyyy-MM-dd");
                var d2 = DateTime.Today.AddDays(0).ToString("yyyy-MM-dd");
                DateTime d3 = Convert.ToDateTime(DateTime.Today.AddDays(1).ToString("yyyy-MM-dd"));
                if (Request["key1"] != null) {
                    d1 = Request["key1"];
                    
                }
                if (Request["key2"] != null)
                {
                    d2 = Request["key2"];
                    d3=Convert.ToDateTime(d2).AddDays(1);

                }
                 %>
            <input type="text"  id="key"  placeholder="请输入活动名"/>
            <input type="text" id="key1" value="<%=d1 %>" style="width:auto;" />
			<input type="text"id="key2" value="<%=d2 %>"  style="width:auto;"/>
            <%--<input type="text" id="key1" value="<%=DateTime.Today.AddDays(-7).ToString("yyyy-MM-dd") %>" style="width:auto;" />
			<input type="text"id="key2" value="<%=DateTime.Today.ToString("yyyy-MM-dd") %>"  style="width:auto;"/>--%>
            <input type="text"id="key3" value="<%=d3 %>"  style="width:auto;" hidden="hidden"/>
            <%--<input type="text"id="key3" value="<%=DateTime.Today.AddDays(1).ToString("yyyy-MM-dd")%>"  style="width:auto;" hidden="hidden"/>--%>
                <input type="submit" value="搜索" onclick="dosearch();" class="alt_btn"/>
		</div> 
    <article class="module width_full">
        <header>
            <h3 class="tabs_involved">按时间查询</h3>
        </header>
        <div class="tab_container">
            <div id="Div1" class="tab_content">
                 

<div  id="Div2">
                <asp:Repeater ID="Repeater1" runat="server">
  <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>活动名</th>
                                        <th>奖项名</th>
                                        <th>流水号</th>
                                        <th>收银票图片</th>
                                        <th>昵称</th>
                                        <th>性别</th>
                                        <th>国家(微信)</th>
                                        <th>省(微信)</th>
                                        <th>市(区)（微信）</th>
                                        <th>国家(扫码)</th>
                                        <th>省(扫码)</th>
                                        <th>市(区)（扫码）</th>
                                        <th>领奖时间（扫码）</th>
                                        <th>最近活跃时间</th>
                                        <th>第一次活跃时间</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                 <tr>
                                    <td><%#Eval("ActivityName")%></td>
                                    <td><%#Eval("PrizeName")%></td>
                                    <td><%#Eval("TicketNumber") %></td>
                                    <td> <a href="http://lucky.meduo.com.cn/<%#Eval("TicketUrl") %>" target="_blank" ><img src='<%#Eval("TicketUrl") %>' width="30" /> </a>  </td>
                                    <td><%#Eval("NickName")%></td> 
                                    <td><%#Convert.ToBoolean(Eval("Sex")) ==true?"男":"女"%></td>
                                    <td><%#Eval("WXCountry")%></td> 
                                    <td><%#Eval("WXProvince") %></td>
                                    <td><%#Eval("WXCity")%></td> 
                                    <td><%#Eval("Country")%></td> 
                                    <td><%#Eval("Province") %></td>
                                    <td><%#Eval("City")%></td>
                                    <td><%#Eval("ScanDate")%></td>
                                    <td><%#Eval("LastActiveTime") %></td>
                                    <td><%#Eval("RegisterDate")%></td> 
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
            <!-- end of #tab1 -->



        </div>
        <!-- end of .tab_container -->
        <footer>
            
            <div class="submit_link">
                <input type="submit" value="导出表格" class="alt_btn" onclick="DownLoad();"/>
            </div>
        </footer>
    </article>
</asp:Content>
