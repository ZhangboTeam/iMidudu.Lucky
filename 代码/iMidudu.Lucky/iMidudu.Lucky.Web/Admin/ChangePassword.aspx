<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"    %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script src="js/json2.js"></script>
    <script>
        function changepwd() {
            var data = {
                oldpwd: $("#oldpwd").val(),
                newpwd: $("#newpwd").val(),
                newpwd2: $("#newpwd2").val()
            };
            if (data.oldpwd=="") {
                alert("input old pwd"); return;
            }
            if (data.newpwd!=data.newpwd2) {
                alert("new pwd does not match"); return;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/ChangePassword",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    if (result.d) {
                        alert("ok");
                        window.location.href = "/Admin/Default.aspx"
                    }
                    else {
                        alert("no");
                        window.location.href = "/Admin/ChangePassword.aspx"
                    }
                }
            });
        }
    </script>
    <article class="module width_full">
        <header>
            <h3 class="tabs_involved">修改密码</h3>

        </header>
        <div class="tab_container"> 
            
			<div id="tab2" class="tab_content">
			<table class="tablesorter2" cellspacing="0"> 
			    
                <fieldset>
                                <label>原密码</label>
                                <input type="password" id="oldpwd"style="width:30%"/> <br /><br />
                                 <p></p>
                                <p></p>
                              
                                <label>新密码</label>
                                <input type="password" id="newpwd" style="width:30%"/> <br /><br />
                                 <p></p>
                                <p></p>
                                <label>确认新密码</label>
                                <input type="password" id="newpwd2" style="width:30%"/> 
                            </fieldset>


                            <footer>
                                <div class="submit_link">
                                    <input type="button" value="确定"   class="alt_btn" onclick="changepwd();"/>
                                </div>
                            </footer>
			</table>

			</div><!-- end of #tab2 -->
            </div>
    </article>

</asp:Content>
