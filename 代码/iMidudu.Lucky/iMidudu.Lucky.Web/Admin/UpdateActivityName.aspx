<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="UpdateActivityName.aspx.cs" Inherits="iMidudu.Lucky.Web.Admin.UpdateActivityName" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
             <script runat="server">

            private int totalCount;
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

                totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from Activity");

                var dr = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("ActivityName",
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
            function deleteCode(code) {
                var data = {
                    ActivityName:ActivityName 
                }; 
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Admin/Webservice.asmx/DeleteActivity",
                    data: JSON.stringify(data),
                    dataType: 'json',
                    success: function (result) {
                       
                        alert("ok");
                        window.location.reload();
                       
                    },
                    error: function (err) {
                        alert(err.responseText);
                    }
                });
            }
            function AddNew() { 
                var data = {
                    Activity: $("#NewActivity").val(),
                };
                if (data.NewActivity == "") {
                    alert("input Activity"); return;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Webservice.asmx/AddNewActivity",
                    data: JSON.stringify(data),
                    dataType: 'json',
                    success: function (result) {
                       
                        // alert("ok");
                        $("#NewActivity").val(result.d);
                        window.location.reload();
                       
                    },
                    error: function (err) {
                        alert(err.responseText);
                    }
                });
            }

            function UpdateAll() {
                var data = new Array();
                $("input[tag='txt']").each(function(){
                    data.push({
                        ActivityName :$(this).attr("ActivityName")
                    });
                });
                var arg={
                    datasssss:data
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Admin/Webservice.asmx/UpdateAllActivity",
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
        </script>

    <article class="module width_full">
         
            <header> 

            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <asp:Repeater ID="Repeater1" runat="server">
                        <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th width="50">活动名</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                <tr>
                                  <%--  <td><%#Eval("ActivityName") %></td> --%>
                                <td>
                                    <input tag="txt" onclick="this.select();"
                                         code="<%#Eval("ActivityName") %>"
                                         id="newToUrl" type="text" style="width:100%;" value="<%%>" /></td>
                                    <td>
                                        <input type="submit" value="Update" class="alt_btn" onclick="Update('<%%>')" />
                                    </td>

                                </tr>
                        </ItemTemplate>
                        <FooterTemplate>

                            <tr>
                                <td>
                                    <% var count = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from Activity");
            var nextCode =  string.Format("{0:000}", count++); %>
                                    <input id="NewActivity" type="text" value="<%=nextCode %>" />

                                </td>
                                <td>
                                    <input id="newToUrl" type="text" style="width:100%;" /></td>
                                <td>
                                    <input type="submit" value="AddNew" class="alt_btn" onclick="AddNew();" />
                                </td>

                            </tr>
                            </tbody>
                    </table>
                            
                        </FooterTemplate>
                    </asp:Repeater>
                    <webdiyer:AspNetPager ID="AspNetPager1" runat="server" Width="100%" UrlPaging="true" ShowPageIndexBox="Always" PageIndexBoxType="DropDownList" ShowCustomInfoSection="Left"
                        FirstPageText="【首页】"
                        LastPageText="【尾页】" NextPageText="【后页】"
                        PrevPageText="【前页】" NumericButtonTextFormatString="【{0}】" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到第" HorizontalAlign="right" PageSize="10" OnPageChanged="AspNetPager1_PageChanged" EnableTheming="true" CustomInfoHTML="当前第  <font color='red'><b>%CurrentPageIndex%</b></font> 页,共  %PageCount%  页 ,总共:%RecordCount% 条数据">
                    </webdiyer:AspNetPager>
                    
            <div class="submit_link">
                <input type="submit" value="批量更新" class="alt_btn" onclick="UpdateAll();"/>
            </div>
                </div>
                <!-- end of #tab1 -->



            </div>
            <!-- end of .tab_container -->
        
        </article>
</asp:Content>
