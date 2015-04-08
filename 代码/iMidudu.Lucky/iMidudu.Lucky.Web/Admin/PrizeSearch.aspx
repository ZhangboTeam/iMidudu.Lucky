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
                }
                
            }

            private System.Data.SqlClient.SqlDataReader LoadData()
            {


                var key = (ky == null ? "" : ky);
                totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from Prize where                             PrizeName like '%'+ @key +'%'", new System.Data.SqlClient.SqlParameter("@key", key));
                var dr = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("PrizeSearch_Procedure",
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

               window.location.href = "PrizeSearch.aspx?key=" + k;
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
   <input name="key" type="text"  id="key"  placeholder="请输入奖项"/>
    <input type="submit" onclick="dosearch();"  value="按奖项查询"class="alt_btn"/>
        <br />
        <label>活动名称</label><asp:DropDownList ID="DropDownList1" runat="server" Height="16px" Width="136px">
            <asp:ListItem Value="活动一"></asp:ListItem>
            <asp:ListItem Value="活动二"></asp:ListItem>
            <asp:ListItem Value="活动三"></asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList><br>
        <label>奖项类别</label><asp:DropDownList ID="DropDownList2" runat="server" Height="16px" Width="136px">
            <asp:ListItem Value="大奖"></asp:ListItem>
            <asp:ListItem Value="小奖"></asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
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
                                        <th>流水号</th>
                                        <th>收银票图片</th>
                                        <th>微信昵称</th>
                                        <th width="50">奖项ID</th>
                                        <th>QRcode</th>
                                        <th>奖项名</th>
                                        <th>数量</th>
                                        <th>URL</th>
                                        <th>每日限制</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                 <tr>
                                    <td><%#Eval("TicketNumber") %></td>
                                     <td> <a href="http://lucky.meduo.com.cn/<%#Eval("TicketUrl") %>" target="_blank" ><img src='<%#Eval("TicketUrl") %>' width="30" /> </a>  </td>
                                      
                                    <td><%#Eval("NickName")%></td>
                                    <td><%#Eval("PrizeId") %></td>   
                                    <td><%#Eval("QRCode") %></td> 
                                    <td><%#Eval("PrizeName") %></td>
                                    <td><%#Eval("Quantity") %></td>
                                    <td><%#Eval("URL") %></td>
                                    <td><%#Eval("DayLimit") %></td>
                                    
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
                <label>汇总：&nbsp&nbsp&nbsp&nbsp 有</label>
                <label><%#totalCount%></label>
                    
            </div>
                </div>
                <!-- end of #tab1 -->

            </div>
            <!-- end of .tab_container -->
        
        </article>
</asp:Content>
