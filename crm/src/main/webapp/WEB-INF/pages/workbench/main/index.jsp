<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
</head>
<body>
<img src="image/home.png" height="100%" width="100%" style="position: relative;top: -10px; left: -10px;"/>
</body>
</html>