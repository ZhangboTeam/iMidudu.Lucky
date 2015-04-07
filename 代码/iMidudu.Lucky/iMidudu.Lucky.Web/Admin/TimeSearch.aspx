<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">--%>
<script runat="server"> 
    private string ky = "";
    private int totalCount;
    private int totalCount2;
    private int totalCount50;
    private int totalOpenId;
    private double totalMoney;

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
        var key = new System.Data.SqlClient.SqlParameter("@ky", ky == null ? "" : ky);
        var key2 = new System.Data.SqlClient.SqlParameter("@ky", ky == null ? "" : ky);
        var sptotalCount = new System.Data.SqlClient.SqlParameter("@totalCount",  System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output,Size=4  };
        var sptotalCount2 = new System.Data.SqlClient.SqlParameter("@totalCount2",  System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output,Size=4  };
        var sptotalCount50 = new System.Data.SqlClient.SqlParameter("@totalCount5",  System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output,Size=4  };
        var sptotalOpenId = new System.Data.SqlClient.SqlParameter("@totalOpenId", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output ,Size=4 };
        var sptotalMoney = new System.Data.SqlClient.SqlParameter("@totalMoney", System.Data.SqlDbType.Float) { Direction = System.Data.ParameterDirection.Output,Size=4  };

        //var dr =   iMidudu.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure(  "usp_UserSearch",
        //   new System.Data.SqlClient.SqlParameter("@ky", ky==null?"" :ky),
        //   new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
        //   new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex),
        //   sptotalCount,sptotalCount2,sptotalCount5,sptotalOpenId,sptotalMoney
        //   );

        var cmd = new System.Data.SqlClient.SqlCommand();
        var cn = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.AppSettings["con"]);
        cmd.Connection = cn;
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.CommandText = "usp_UserSearch";
        cmd.Parameters.AddRange(new System.Data.SqlClient.SqlParameter[] {key2
             ,
           new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
           new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex),
           sptotalCount,sptotalCount2,sptotalCount50,sptotalOpenId,sptotalMoney
        });
        cn.Open();
        var dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        this.totalCount = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(count(*),0) from ViewBonusHistory where username like '%' + @ky + '%'", key);
        this.totalCount2 = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(count(*),0) from ViewBonusHistory where username like '%' + @ky + '%' and Amount=2;", key);
        this.totalCount50 = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(count(*),0) from ViewBonusHistory where username like '%' + @ky + '%' and Amount=50;", key);
        this.totalOpenId = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(count(distinct([OpenId] )),0) from ViewBonusHistory where username like '%' + @ky + '%' ", key);
        try
        {
            this.totalMoney = (double)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(SUM(amount),0) from ViewBonusHistory where username like '%' + @ky + '%' ", key);
        }
        catch
        {
            this.totalMoney = 0;
        }
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
<asp:Content ID="Content2" ContentPlaceHolderID="PageBody" runat="server">
    <script>

        function dosearch() {
            var key = $("#key").val();
            if (key == "" || key == null) {
                //  alert("输入查询条件"); return;
            }
            window.location = "UserSearch.aspx?key=" + key;
        }

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

                    var url = "/Admin/OutExcel.ashx?filename=扫码用户.xls&ContentFile=" + fn.d;
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
                    <a class="current2">按用户名查询</a>
                </article>
            </div>
        </section>
    <div class="quick_search width_half_search">
        <input type="text"  id="key" placeholder="按验证用户名查找"/>
        <input type="button" onclick="dosearch();" value="搜索"/>
    </div>


    <article class="module width_full">
        <header>
            <h3 class="tabs_involved">查询条件：<%=ky ==null?"所有数据" :ky %></h3>

        </header>
        <div class="tab_container">
            <div id="tab1" class="tab_content">
                 
<div  id="content">

                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                    <thead>
                        <tr>

                          <%--  <th>红包码</th>
                            <th>用户ID</th>--%>
                            <th>验证用户名</th>
                            <th>微信昵称</th>
                            <th>性别</th>
                            <th>头像</th>
                            <th>手机</th>
                            <th>国家</th>
                            <th>省</th>
                            <th>市（区）</th>
                            <th>活动名称</th>
                            <th>领取金额</th>
                            <th>领取时间</th>

                        </tr>
                    </thead>
                    <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                           <%-- <td>       <%#Eval("BonusCode") %>   </td>
                            <td>       <%#Eval("OpenId") %>   </td>--%>
                            <td>       <%#Eval("UserName") %>   </td>
                            <td>       <%#Eval("Nickname") %>   </td>
                            <td>       <%#Eval("Sex").ToString()=="1"?"男":"女" %>  </td>
                            <td> <a href="<%#Eval("Pic") %>" target="_blank" ><img src='<%#Eval("Pic") %>' width="30" /> </a>  </td>
                            <td>       <%#Eval("Mobile") %>   </td>
                            <td>       <%#Eval("Country") %>   </td>
                            <td>       <%#Eval("Province") %>   </td>
                            <td>       <%#Eval("City") %>   </td>
                            <td>       <%#Eval("ActivityName") %>   </td>
                            <td>       <%#Eval("Amount") %>   </td>
                            <td>       <%#Eval("ReceiptDate") %>   </td>
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
                        <input type="submit" value="导出表格" class="alt_btn" onclick="DownLoad();">
                    </div>
                </footer>
            <!-- end of #tab1 -->



        </div>
        <!-- end of .tab_container -->
        <footer>
            <div class="post_message">
                <label>汇总：&nbsp&nbsp&nbsp&nbsp 有</label>
                <label><%#totalOpenId %></label>
                <label>人领取红包&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 共领取</label>
                <label><%#totalMoney %></label>
                <label>元&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 2元的</label>
                <label><%#totalCount2 %></label>
                <label>份&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 50元的 </label>
                <label><%#totalCount50 %></label>
                <label>份</label>

            </div>

        </footer>
    </article>
</asp:Content>
