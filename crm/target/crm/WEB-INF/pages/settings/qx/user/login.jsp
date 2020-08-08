<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../../../../HeadPart.jsp" %>
    <title>登入账号</title>
    <script type="text/javascript">
        $(function () {
            //给界面添加按下键盘事件
            $(window).keydown(function (e) {
                if (e.keyCode == 13) {
                    $("#loginBth").click();
                }
            })

            $("#loginBth").click(function () {
                var loginAct = $.trim($("#loginAct").val());
                var loginPwd = $.trim($("#loginPwd").val());
                var isRemPew = $("#isRemPew").prop("checked");
                if (loginAct == "") {
                    $("#msg").text("用户名不能为空");
                    return;
                }
                if (loginPwd == "") {
                    $("#msg").text("密码不能为空");
                    return;
                }
                $.ajax({
                    url: 'settings/qx/user/login.do',
                    data: {
                        loginAct: loginAct,
                        loginPwd: loginPwd,
                        isRemPew: isRemPew,
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        if (data.code == "1") {
                            window.location.href = "workbench/index.do";
                        } else {
                            $("#msg").text(data.message);
                        }
                    },
                    beforeSend: function () {//在发生ajax之前执行这个函数
                        $("#msg").text("正在验证...");
                        return true;
                    }
                })
            })
        })
    </script>
</head>
<body>
<div style="position: absolute; top: 0px; left: 0px; width: 70%;">
    <img src="image/IMG_7114.JPG" style="width: 100%; position: relative; top: 50px;">
    <%--    height: 90%;--%>
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2020&nbsp;简单九二</span></div>
</div>

<div style="position: absolute; top: 30%; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form action="workbench/index.html" class="form-horizontal" role="form">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input id="loginAct" class="form-control" value="${cookie.loginAct.value}" type="text"
                           placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input id="loginPwd" class="form-control" value="${cookie.loginPwd.value}" type="password"
                           placeholder="密码">
                </div>
                <div class="checkbox" style="position: relative;top: 30px; left: 10px;">
                    <label>
                        <c:if test="${not empty cookie.loginPwd and not empty cookie.loginPwd}">
                            <input id="isRemPew" checked="true" type="checkbox"> 十天内免登录
                        </c:if>
                        <c:if test="${empty cookie.loginPwd or empty cookie.loginPwd}">
                            <input id="isRemPew" type="checkbox"> 十天内免登录
                        </c:if>
                    </label>
                    &nbsp;&nbsp;
                    <span id="msg" style="color: #ff0000"></span>
                </div>
                <button type="button" id="loginBth" class="btn btn-primary btn-lg btn-block"
                        style="width: 350px; position: relative;top: 45px;">登录
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>