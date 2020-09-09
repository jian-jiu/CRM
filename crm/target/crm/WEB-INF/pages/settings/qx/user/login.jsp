<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../../../../community/HeadPart.jsp" %>
    <title>登入账号</title>
    <script type="text/javascript">
        if (window.parent.window != window) {
            window.top.location.href = '';
        }

        //窗口加载完毕
        $(() => {
            //登入按钮
            let loginBthObj = $("#loginBth")
            //账号输入框
            let loginNameObj = $("#loginName")
            //密码框
            let loginPwdObj = $("#loginPwd")
            //提示信息
            let msgObj = $("#msg")

            //账号输入框获取焦点
            let t = loginNameObj.val();
            loginNameObj.val("").focus().val(t);

            //给界面添加按下键盘事件
            $(window).keydown(e => {
                if (e.key == "Enter") {
                    loginBthObj.click();
                }
            })

            //单击按钮事件
            loginBthObj.click(() => {
                //获取内容
                let loginNameVal = $.trim(loginNameObj.val());
                let loginPwdVal = $.trim(loginPwdObj.val());
                let autoLogin = $("#autoLogin").prop("checked");
                //进行判断
                if (!loginNameVal) {
                    msgObj.text("用户名不能为空");
                    loginNameObj.focus()
                    return;
                }
                if (!loginPwdVal) {
                    msgObj.text("密码不能为空");
                    loginPwdObj.focus()
                    return;
                }
                //设置提示信息
                msgObj.text("正在验证...");
                //发送请求
                $.ajax({
                    url: "settings/qx/user/login",
                    data: {
                        loginName: loginNameVal,
                        loginPwd: loginPwdVal,
                        autoLogin: autoLogin
                    },
                    type: 'post',
                    dataType: "json",
                    complete: false,
                    success(data) {
                        if (data.code == "1") {
                            location.href = "workbench/index";
                        } else {
                            msgObj.text(data.message);
                        }
                    }
                })
            })
        })
    </script>
</head>
<body>
<%--图片·--%>
<div style="position: absolute; top: 0px; left: 0px; width: 70%;">
    <img src="image/IMG_7114.JPG" style="width: 100%; position: relative; top: 50px;">
</div>
<%--顶部--%>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2020&nbsp;简单九二</span></div>
</div>
<%--登入div--%>
<div style="position: absolute; top: 30%; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1 title="${requestScope.ip}">登录</h1>
        </div>
        <form class="form-horizontal" action="workbench/index.html" role="form" autocomplete="off">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input id="loginName" class="form-control" value="${cookie.loginAct.value}" type="text"
                           placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input id="loginPwd" class="form-control" value="${cookie.loginPwd.value}" type="password"
                           placeholder="密码">
                </div>
                <div class="checkbox" style="position: relative;top: 30px; left: 10px;">
                    <label>
                        <c:if test="${not empty cookie.loginPwd and not empty cookie.loginPwd}">
                            <input id="autoLogin" type="checkbox" checked="true"> 十天内免登录
                        </c:if>
                        <c:if test="${empty cookie.loginPwd or empty cookie.loginPwd}">
                            <input id="autoLogin" type="checkbox"> 十天内免登录
                        </c:if>
                    </label>
                    &nbsp;&nbsp;
                    <span id="msg" style="color: #ff0000"></span>
                </div>
                <button id="loginBth" class="btn btn-primary btn-lg btn-block" type="button"
                        style="width: 350px; position: relative;top: 45px;">登录
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>