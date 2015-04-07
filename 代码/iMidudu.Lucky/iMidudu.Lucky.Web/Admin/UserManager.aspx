﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
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
                totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from WXUser where NickName like '%'+ @key +'%'",new System.Data.SqlClient.SqlParameter("@key", key));
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
               if(key==null||key==""){
               }

               window.location.href = "UserManager.aspx?key=" + k;
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
    <input type="text"  id="key"  placeholder="按微信名查询"/>
    <input type="button" onclick="dosearch();"  value="按微信名查询"class="alt_btn"/>
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
                                        <th >微信id</th>
                                        <th>昵称</th>
                                        <th>性别</th>
                                        <th>城市</th>
                                        <th>省市</th>
                                        <th>国家</th>
                                        <th>注册时间</th>
                                        <th>最后一次登陆时间</th>
                                        <th>数量</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                 <tr>
                                    <td><%#Eval("OpenId") %></td>   
                                    <td><%#Eval("NickName") %></td>
                                    <td><%#Eval("Sex") %></td>
                                    <td><%#Eval("WXCity") %></td>
                                    <td><%#Eval("WXProvince") %></td>
                                    <td><%#Eval("WXCountry") %></td>
                                    <td><%#Eval("RegisterDate") %></td>
                                    <td><%#Eval("LastActiveTime") %></td>
                                    <td><% %></td>
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
                <label><%#totalCount%>人</label>
                <label>参加过活动</label>
            </div>
                </div>
                <!-- end of #tab1 -->

            </div>
            <!-- end of .tab_container -->
        
        </article>
           
</asp:Content>
