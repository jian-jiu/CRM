<%--
  Created by IntelliJ IDEA.
  User: 简单
  Date: 2020/8/17
  Time: 20:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css">

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <title>Test</title>

    <script type="text/javascript">
        $(function () {
            $("#birthday").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//选择器上能选择的最小日期
                initialDate: new Date(),//设置默认时间
                autoclose: true,//单击后是否关闭
                todayBtn: true,//每次打开是否显示当前时间
                clearBtn: true//是否显示清空按钮
            })
        })
    </script>
</head>
<body>
<input type="text" id="birthday">
</body>
</html>
