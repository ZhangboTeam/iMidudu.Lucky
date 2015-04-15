<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="BigPrize.aspx.cs" Inherits="iMidudu.Lucky.Web.Admin.BigPrize" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
        <script runat="server">
        </script>
       <script>
           function UpdateAll() {
               var data = new Array();
               //var data1 = new Array();
               //var PrizeId = $(this).attr("code");
               //var PrizeName= $("#NewPrizeIdName").val();
               //var Quantity = parseInt($("#NewQuantity").val());
               $("input[tag='txt']").each(function () {
                   data.push({
                       PrizeId: $(this).attr("code"),
                       Status: $(this).val()
                       //,
                       //Quantity: $("#NewQuantity").val()
                   });
               })

               //$("input[tag='txt1']").each(function () {
               //    data1.push({
               //        PrizeId: $(this).attr("code1"),
               //        Quantity: $(this).NewQuantity.val()
               //    });
               //});
               var arg = {
                   datasssss: data
               }
               $.ajax({
                   type: "POST",
                   contentType: "application/json",
                   url: "/Webservice.asmx/UpdateBigPrize",
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
                <h3 class="tabs_involved">大奖统计</h3>
            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <div id="content">
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                        
                        <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>活动获奖</th>
                                        <th>获奖姓名</th>
                                        <th>获奖手机号</th>
                                        <th>获奖人地址</th>
                                        <th>获奖时间</th>
                                        <th>是否发货</th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                 <tr>  
                                    <td><%#Eval("ActivityName") %>+<%#Eval("PrizeName") %></td>
                                    <td><%#Eval("UserName") %></td>
                                    <td><%#Eval("Mobile") %></td>
                                     <td><%#Eval("Address") %></td>
                                     <td><%#Eval("ScanDate") %></td>
                                     <td>
                                    <input tag="txt" onclick="this.select();"
                                         code="<%#Eval("PrizeId") %>"
                                         id=" NewPrizeName" <%=this.Request["NewPrizeName"] %>type="text" style="width:100%;" value="<%#Eval("Status") %>" /></td>
                                    

                                </tr>
                        </ItemTemplate>
                        <FooterTemplate>

                            </tbody>
                    </table>
                            
                        </FooterTemplate>
                    </asp:Repeater>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LuckyConnectionString %>" SelectCommand="SELECT * FROM [View_BigSearch] ORDER BY [QRCode], [PrizeId]"></asp:SqlDataSource>
                      </div>
                     <div class="submit_link">
                <input type="submit" value="批量更新" class="alt_btn" onclick="UpdateAll();"/>
            </div>
                     <footer>
                        </footer>
                </div>
                <!-- end of #tab1 -->

            </div>
            <!-- end of .tab_container -->
        
        </article>
</asp:Content>
