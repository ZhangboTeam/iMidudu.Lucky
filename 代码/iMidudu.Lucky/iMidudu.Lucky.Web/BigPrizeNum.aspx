﻿<%@ Page Language="C#"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>领奖号</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    你的领奖号是：<%=this.Request["code"] %>
    </div>
    </form>
</body>
</html>
