<%--
  Created by IntelliJ IDEA.
  User: 简单
  Date: 2020/8/8
  Time: 15:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + request.getContextPath() + "/";
%>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="static/jquery/bootstrap_3.3.0/css/bootstrap.min.css"/>
<link type="text/css" rel="stylesheet" href="static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css"/>
<link type="text/css" rel="stylesheet" href="static/jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">

<script type="text/javascript" src="static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="static/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="static/jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="static/jquery/bs_pagination-master/localization/en.min.js"></script>
<script type="text/javascript" src="static/js/ajax.js"></script>
