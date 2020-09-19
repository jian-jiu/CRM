<%--
  Created by IntelliJ IDEA.
  User: 简单
  Date: 2020/9/1
  Time: 19:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>网页崩溃啦！！！</title>
</head>
<body>
<div align="center">
    <a href="#" a>回到首页</a>
    <h1 style="color: #ff0000">页面出现错误</h1>
    <br/>
    <h2 a>原因如下</h2>
    <h3 style="color: #71e597">翻译信息：${requestScope.msgZh}</h3>
    <br/>
    <h3 style="color: #71e597">原信息：${requestScope.msgEn}</h3>
    <a href="#" a>回到首页</a>
</div>
</body>
</html>
