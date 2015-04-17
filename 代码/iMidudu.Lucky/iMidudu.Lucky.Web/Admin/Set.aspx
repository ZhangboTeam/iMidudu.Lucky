﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script runat="server">

            private int totalCount;
            private string ky="" ;
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
                totalCount = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(distinct PrizeName) from UpdatePrize_View ",
                   new System.Data.SqlClient.SqlParameter("@key", key));
                var dr = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("SetPrizes_Procedure",
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
            function change() {
                var k = $("#Name").val();
                if (k == null || k == "") {
                }

                window.location.href = "Set.aspx?key=" + k;
            }
            function UpdateAll() {
                var data = new Array();
                var da = new Array();
                var daa = new Array();
                $("input[tag='txt']").each(function () {
                    data.push({
                        PrizeId: $(this).attr("code"),
                        PrizeName: $(this).val(),
                        Quantity : $(this).attr("oth")
                        //,
                        //Quantity: $('#NewQuantity').val()
                        //Quantity: $(this).attr("code1").val()
                    });
                })
                $("input[tag='int']").each(function () {
                    da.push({
                        PrizeId: $(this).attr("oth"),
                        Quantity: $(this).val()
                        //,
                        //Quantity: $('#NewQuantity').val()
                        //Quantity: $(this).attr("code1").val()
                    });
                })
                $("input[tag='day']").each(function () {
                    daa.push({
                        PrizeId: $(this).attr("code3"),
                        DayLimit: $(this).val()
                        //,
                        //Quantity: $('#NewQuantity').val()
                        //Quantity: $(this).attr("code1").val()
                    });
                })
                var arg = {
                    datasssss: data,
                    datass: da,
                    datas: daa
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Webservice.asmx/UpdateAllSet",
                    data: JSON.stringify(arg),
                    dataType: 'json',
                    success: function (result) {

                        window.location.reload();

                    },
                    error: function (err) {
                        alert(err.responseText);
                    }
                });
            }
        </script>
    <div align="center">

             <td>
                        <select name="" onchange="change();" id="Name"  class="form_select">
                            <option value="" selected="">请选择活动</option>
                            <%
                                var data1 = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select ActivityName from Activity").ToString();
                                var data2 = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select ActivityName from Activity where QRCode='4d618408-d3f3-4d7b-8c0d-a42e9c31fe82'").ToString();
                                var data3 = iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select ActivityName from Activity where QRCode='4d618408-d3f3-4d7b-8c0d-a42e9c31fe83'").ToString();
                                //foreach (var item in data)
                              {%>
                            <option value="<%=data1%>"><%=data1%></option>
                            <option value="<%=data2%>"><%=data2%></option>
                            <option value="<%=data3%>"><%=data3%></option>
                           <%--<option value="<%=item%>"><%=item%></option>--%>
                            <%} %>
                        </select>
          </td>
           <%--<td>
                        	<div class="smgSelectWrap" id="issueSmg">
                        		<div class="smgSelectText f-toe f-usn"></div>
                                <input type="hidden" />
                                <div class="smgSelectListWrap">
                                </div>
                        	</div>
          </td>--%>
    </div>
    &nbsp;<article class="module width_full">
         
            <header> 
                <h3 class="tabs_involved">修改奖项名 </h3>
            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <asp:Repeater ID="Repeater1" runat="server">
                        <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th width="200">PrizeId</th>
                                        <th width="200">奖项名</th>
                                        <th width="200">数量</th>
                                        <th width="200">每小时限额</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                <tr>
                                    <td><%#Eval("PrizeId") %></td>
                                    <td>
                                    <input tag="txt" onclick="this.select();"
                                         code="<%#Eval("PrizeId") %>"
                                         id="NewPrizeName" <%=this.Request["NewPrizeName"] %>type="text" style="width:100%;" value="<%#Eval("PrizeName")%>" /></td>                               
                                    <td>
                                    <input tag="int" onclick="this.select();"
                                        oth="<%#Eval("PrizeId")%>"
                                         id="NewQuantity" <%=this.Request["NewQuantity"] %>type="text" style="width:100%;" value="<%#Eval("Quantity") %>" /></td>
                                    <td>
                                    <input tag="day" onclick="this.select();"
                                         code3="<%#Eval("PrizeId") %>"
                                         id="Text2" <%=this.Request["NewDayLimit"] %>type="text" style="width:100%;" value="<%#Eval("DayLimit") %>" />
                                    </td>

                                    <%-- <td>
                                      <input tag="txt" onclick="this.select();"
                                        <%-- code="<%#Eval("PrizeId") %>"--%>
                                         <%--id="NewQuantity" <%=this.Request["NewQuantity"] %>  type="text" style="width:100%;" value="<%#Eval("Quantity") %>" /></td>
                                  <td>--%>
                                  <%--  <td><%#Eval("ActivityName") %></td> --%>
                                <%--<td>
                                    <input tag="txt" onclick="this.select();"
                                         value="<%#Eval("ActivityName") %>"
                                         id="NewActivity" type="text" style="width:100%;" /></td>
                                    <td>
                                    <input tag="txt" onclick="this.select();"
                                         value="<%#Eval("QRCode") %>"
                                         id="QRCode" type="text" style="width:100%;" /></td>--%>
                                    <%--<td><%#Eval("QRCode") %></td> --%>
<%--                                    <td>
                                        <input type="submit" value="Update" class="alt_btn" onclick="UpdateAll()" />
                                    </td>--%>
                                </tr>
                        </ItemTemplate>
                        <FooterTemplate>

                            <tr>
                                <%--<td>
                                    <% var count = (int)iMidudu.Lucky.Web.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from Activity");
            var nextCode =  string.Format("{0:000}", count++); %>
                                    <input id="NewActivity" type="text" placeholder="请输入奖项code" />

                                </td>
                                <td>
                                    <input id="newToUrl" type="text" style="width:100%;" /></td>
                                <td>
                                    <input type="submit" value="AddNew" class="alt_btn" onclick="AddNew();" />
                                </td>--%>
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
