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

<%-- css样式--%>
<link type="text/css" rel="stylesheet" href="static/jquery/bootstrap_3.3.0/css/bootstrap.min.css"/>
<link type="text/css" rel="stylesheet" href="static/jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">
<link type="text/css" rel="stylesheet" href="static/jquery/bs-datetimepicker-master/css/bootstrap-datetimepicker.min.css"/>

<%-- jqery插件--%>
<script type="text/javascript" charset="utf-8" src="static/jquery/jquery-1.11.1-min.js"></script>

<%-- bootstrap_3.3.0插件--%>
<script type="text/javascript" charset="utf-8" src="static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<%-- 分页插件--%>
<script type="text/javascript" charset="utf-8" src="static/jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" charset="utf-8" src="static/jquery/bs_pagination-master/localization/en.min.js"></script>

<%-- 日历插件--%>
<script type="text/javascript" charset="utf-8" src="static/jquery/bs-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" charset="utf-8" src="static/jquery/bs-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<%-- 自动补全插件--%>
<script type="text/javascript" charset="utf-8" src="static/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>

<%-- 统计插件--%>
<script type="text/javascript" charset="utf-8" src="static/jquery/echars/echarts.min.js"></script>

<%-- 自定义--%>
<script type="text/javascript" charset="UTF-8" src="static/js/ajax.js"></script>
