<%--
  Created by IntelliJ IDEA.
  User: 简单
  Date: 2020/8/20
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getLocalPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>分页</title>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>

    <link rel="stylesheet" type="text/css" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css">
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/localization/en.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $("#demo_pag1").bs_pagination({
                currentPage: 10,//当前页
                rowsPerPage: 10,//每有显示条数
                totalRows: 1000,//总条数
                totalPages: 100,//总页数

                visiblePageLinks: 10,//显示的翻页卡片数

                showGoToPage: true,//是否显示“跳转到第几页”
                showRowsPerPage: true,//是否显示“每页显示条数”
                showRowsInfo: true,//是否显示记录的信息

                //每次切换页号对会触发函数，函数那返回切换后的页号和每页显示条数
                onChangePage: function (e, pageObj) {
                    alert("当前页" + pageObj.currentPage + "每页条数" + pageObj.rowsPerPage)
                },
            })
        })
    </script>
</head>
<body>
分页演示
<div id="demo_pag1"></div>
</body>
</html>
