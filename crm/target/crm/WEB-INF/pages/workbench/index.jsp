<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../../community/HeadPart.jsp" %>
    <title>简九</title>
    <script type="text/javascript">
        //页面加载完毕
        $(() => {
            //导航中所有文本颜色为黑色
            $(".liClass > a").css("color", "black");

            //默认选中导航菜单中的第一个菜单项
            $(".liClass:first").addClass("active");

            //第一个菜单项的文字变成白色
            $(".liClass:first > a").css("color", "white");

            //给所有的菜单项注册鼠标单击事件
            $(".liClass").click(() => {
                //移除所有菜单项的激活状态
                $(".liClass").removeClass("active");
                //导航中所有文本颜色为黑色
                $(".liClass > a").css("color", "black");
                //当前项目被选中
                $(this).addClass("active");
                //当前项目颜色变成白色
                $(this).children("a").css("color", "white");
            });
            window.open("workbench/main/index", "workareaFrame");
        });
    </script>
</head>
<body>

<%@ include file="../../community/ModalWindow.jsp" %>

<!-- 中间 -->
<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">

    <!-- 导航 -->
    <div id="navigation" style="left: 0px; width: 18%; position: relative; height: 100%; overflow:auto;">

        <ul id="no1" class="nav nav-pills nav-stacked">
            <li class="liClass"><a href="workbench/index" target="workareaFrame"><span
                    class="glyphicon glyphicon-home"></span> 工作台</a></li>
            <%--<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span
                    class="glyphicon glyphicon-tag"></span> 动态</a></li>
            <li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span
                    class="glyphicon glyphicon-time"></span> 审批</a></li>
            <li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span
                    class="glyphicon glyphicon-user"></span> 客户公海</a></li>--%>
            <li class="liClass"><a href="workbench/activity/index" target="workareaFrame"><span
                    class="glyphicon glyphicon-play-circle"></span> 市场活动</a></li>
            <li class="liClass"><a href="workbench/clue/index" target="workareaFrame"><span
                    class="glyphicon glyphicon-search"></span> 线索（潜在客户）</a></li>
            <li class="liClass"><a href="customer/index" target="workareaFrame"><span
                    class="glyphicon glyphicon-user"></span> 客户</a></li>
            <li class="liClass"><a href="contacts/index.html" target="workareaFrame"><span
                    class="glyphicon glyphicon-earphone"></span> 联系人</a></li>
            <li class="liClass"><a href="transaction/index.html" target="workareaFrame"><span
                    class="glyphicon glyphicon-usd"></span> 交易（商机）</a></li>
            <li class="liClass"><a href="visit/index.html" target="workareaFrame"><span
                    class="glyphicon glyphicon-phone-alt"></span> 售后回访</a></li>
            <li class="liClass">
                <a href="#no2" class="collapsed" data-toggle="collapse"><span class="glyphicon glyphicon-stats"></span>
                    统计图表</a>
                <ul id="no2" class="nav nav-pills nav-stacked collapse">
                    <li class="liClass"><a href="chart/activity/index.html"
                                           target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
                            class="glyphicon glyphicon-chevron-right"></span> 市场活动统计图表</a></li>
                    <li class="liClass"><a href="chart/clue/index.html" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
                            class="glyphicon glyphicon-chevron-right"></span> 线索统计图表</a></li>
                    <li class="liClass"><a href="chart/customerAndContacts/index.html" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
                            class="glyphicon glyphicon-chevron-right"></span> 客户和联系人统计图表</a></li>
                    <li class="liClass"><a href="chart/transaction/index.html" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
                            class="glyphicon glyphicon-chevron-right"></span> 交易统计图表</a></li>
                </ul>
            </li>
            <%--<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span
                    class="glyphicon glyphicon-file"></span> 报表</a></li>
            <li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span
                    class="glyphicon glyphicon-shopping-cart"></span> 销售订单</a></li>
            <li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span
                    class="glyphicon glyphicon-send"></span> 发货单</a></li>
            <li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span
                    class="glyphicon glyphicon-earphone"></span> 跟进</a></li>
            <li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span
                    class="glyphicon glyphicon-leaf"></span> 产品</a></li>
            <li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span
                    class="glyphicon glyphicon-usd"></span> 报价</a></li>--%>
        </ul>

        <!-- 分割线 -->
        <div id="divider1"
             style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
    </div>

    <!-- 工作区 -->
    <div id="workarea" style="position: absolute; top : 0px; left: 18%; width: 82%; height: 100%;">
        <iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
    </div>

</div>

<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>

<!-- 底部 -->
<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>

</body>
</html>