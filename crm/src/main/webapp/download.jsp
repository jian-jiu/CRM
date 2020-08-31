<%--
  Created by IntelliJ IDEA.
  User: 简单
  Date: 2020/8/29
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>下载文件</title>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript">
        $(() => {
            $("#downloadFile").click(() => {
                //发送下载请求,必须同步请求，异步太复杂
                location = "workbench/activity/downloadsActivity"
            })
        })
    </script>
</head>
<body>
<input id="downloadFile" type="button" value="下载">
</body>
</html>
