<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script runat="server">
            private int totalCount;
            private string ky1 = "";
            private string ky2 = "";
            protected override void OnLoad(EventArgs e)
            {
                base.OnLoad(e);
                ky1 = this.Request["key1"];
                ky2 = this.Request["key2"];
                if (!IsPostBack)
                {
                    this.LoadData();
                    AspNetPager1.RecordCount = totalCount;
                }
                
            }
            private System.Data.SqlClient.SqlDataReader LoadData()
            {
                var key1 = (ky1 == null ? "" : ky1);
                var key2 = (ky2 == null ? "" : ky2);
                totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from record_view where PrizeName like '%'+ @key1 +'%'and  ActivityName like '%'+ @key2 +'%'",
                   new System.Data.SqlClient.SqlParameter("@key1", key1),
                   new System.Data.SqlClient.SqlParameter("@key2", key2)
                   );
                var dr = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("PrizeSearch_Procedure",
                   new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
                   new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex),
                   new System.Data.SqlClient.SqlParameter("@key1", key1),
                   new System.Data.SqlClient.SqlParameter("@key2", key2)
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
               var key1 = $("#key1").val();
               var key2 = $("#key2").val();
               if (key1 == "" || key1 == null) {
                   // return;
               }
               if (key2 == "" || key2 == null) {
                   // return;
               }
               window.location.href = "PrizeSearch.aspx?key1=" + key1 + "&key2=" + key2;
           }
           function DownLoad() {
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
   <input name="key2" type="text"  id="key2"  placeholder="请输入活动数字1，2，3"/><br />
   <input name="key1" type="text"  id="key1"  placeholder="请输入奖项1,2,3,4,5,6,7"/><br />
      <input type="submit" onclick="dosearch();"  value="按奖项查询"class="alt_btn"/>
        <br />
        <%--<label>活动名称</label><asp:DropDownList ID="DropDownList1" runat="server" Height="16px" Width="136px">
            <asp:ListItem Value="活动一"></asp:ListItem>
            <asp:ListItem Value="活动二"></asp:ListItem>
            <asp:ListItem Value="活动三"></asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList><br>
        <label>奖项类别</label><asp:DropDownList ID="DropDownList2" runat="server" Height="16px" Width="136px">
            <asp:ListItem Value="大奖"></asp:ListItem>
            <asp:ListItem Value="小奖"></asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>--%>
    </div>
    <article class="module width_full">
         
            <header> 

            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <div id="content">
                    <asp:Repeater ID="Repeater1" runat="server">
                        
                        <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>活动名</th>
                                        <th>奖项名</th>
                                        <th>流水号</th>
                                        <th>收银票图片</th>
                                        <th>微信昵称</th>
                                        <th>性别</th>
                                        <th>国家</th>
                                        <th>省</th>
                                        <th>市（区）</th>
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
                    <webdiyer:aspnetpager ID="AspNetPager1" runat="server" Width="100%" UrlPaging="true" ShowPageIndexBox="Always" PageIndexBoxType="DropDownList" ShowCustomInfoSection="Left"
                        FirstPageText="【首页】"
                        LastPageText="【尾页】" NextPageText="【后页】"
                        PrevPageText="【前页】" NumericButtonTextFormatString="【{0}】" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到第" HorizontalAlign="right" PageSize="10" OnPageChanged="AspNetPager1_PageChanged" EnableTheming="true" CustomInfoHTML="当前第  <font color='red'><b>%CurrentPageIndex%</b></font> 页,共  %PageCount%  页 ,总共:%RecordCount% 条数据">
                    </webdiyer:aspnetpager>
                     <footer>
            <div class="submit_link">
                <input type="submit" value="导出Excel" class="alt_btn" onclick="DownLoad();"  />
            </div>
                        </footer>
                     <div class="post_message">
                <h2><label>汇总：活动&nbsp&nbsp&nbsp&nbsp<label><%#ky2%></label>奖项&nbsp&nbsp&nbsp&nbsp<label><%#ky1%></label> 有</label>
                <label><%#totalCount%></label>人</h2>
                    
            </div>
                </div>
                <!-- end of #tab1 -->

            </div>
            <!-- end of .tab_container -->
        
        </article>
</asp:Content>
