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

            protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
            {

            }
</script>
    <script>
        $(".selector1").change(function(){
            $(".selector2").empty();
            var option = $("<option>").val(1).text("pxx");
            $(".selector2").append(option);
        });  
    </script>
    <div align="center">
<%--   <input name="key2" type="text"  id="key2"  placeholder="请输入活动数字1，2，3"/><br />
   <input name="key1" type="text"  id="key1"  placeholder="请输入奖项1,2,3,4,5,6,7"/><br />
      <input type="submit" onclick="dosearch();"  value="按奖项查询"class="alt_btn"/>
        <br />--%>
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
       <%-- <select id="test">
      <option value="1">option>
      </select><br />--%>
      <td>
                        <select name="" onchange="change();" id="TextCommodityId" class="form_select">
                            <option value="" selected="">Please Select</option>
                            <%foreach (var item in iMidudu.Lucky.Web.SystemDAO.SqlHelper.)
                              {%>
                            <option value="<%=item.ActivityName %>"><%=item.PrizeName %></option>
                            <%} %>
                        </select>
        </td>
        <td>
                        	<div class="smgSelectWrap" id="issueSmg">
                        		<div class="smgSelectText f-toe f-usn"></div>
                                <input type="hidden">
                                <div class="smgSelectListWrap">
                                  <ul class="smgSelectList" id="newSupplier">                                    
                                  <%--  <li val="1" class="smgIthems"><span class="IssueLabel"><label class="form_check" for="pro1-10"><input type="checkbox" id="pro1-10"  value="">ITU_BR_NB</label></span></li>
                                    <li val="2" class="smgIthems"><span class="IssueLabel"><label class="form_check" for="pro1-11"><input type="checkbox" id="pro1-11" value="">ITU_BR_DT</label></span></li>
                                    <li val="3" class="smgIthems"><span class="IssueLabel"><label class="form_check" for="pro1-12"><input type="checkbox" id="pro1-12" value="">Newsan_AR_NBV</label></span></li>--%>
                                  </ul>
                                </div>
                        	</div>
         </td>
      <%--  <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="ActivityName" DataValueField="ActivityName">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LuckyConnectionString %>" SelectCommand="SELECT * FROM [Activity] ORDER BY [ActivityName]"></asp:SqlDataSource>
        <br />
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="PrizeName" DataValueField="PrizeName">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LuckyConnectionString %>" SelectCommand="SELECT * FROM [PrizeSearch_View] WHERE ([ActivityName] = @ActivityName) ORDER BY [PrizeName]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="ActivityName" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>--%>
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
                                        <th>昵称</th>
                                        <th>性别</th>
                                        <th>国家(微信)</th>
                                        <th>省(微信)</th>
                                        <th>市(区)（微信）</th>
                                        <th>国家(扫码)</th>
                                        <th>省(扫码)</th>
                                        <th>市(区)（扫码）</th>
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
                 
                     <div class="post_message">
                <label>汇总：活动<label><%#ky2%></label>&nbsp&nbsp&nbsp&nbsp奖项<label><%#ky1%></label>&nbsp&nbsp&nbsp&nbsp 有</label>
                &nbsp&nbsp&nbsp&nbsp<label><%#totalCount%></label>人
                    
            </div>
                </div>
                <!-- end of #tab1 -->
            </div>
            <!-- end of .tab_container -->
            <footer>
            <div class="submit_link">
                <input type="submit" value="导出Excel" class="alt_btn" onclick="DownLoad();"  />
            </div>
            </footer>
        </article>
</asp:Content>
