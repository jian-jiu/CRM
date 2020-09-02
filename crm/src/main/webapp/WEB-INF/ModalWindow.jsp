<%--
  Created by IntelliJ IDEA.
  User: 简单
  Date: 2020/8/8
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 我的资料 -->
<div class="modal fade" id="myInformation" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">我的资料</h4>
            </div>
            <div class="modal-body">
                <div style="position: relative; left: 40px;">
                    姓名：<b>${sessionScope.sessionUser.name}</b><br><br>
                    登录帐号：<b>${sessionScope.sessionUser.name}</b><br><br>
                    组织机构：<b>${sessionScope.sessionUser.deptNo}</b><br><br>
                    邮箱：<b>${sessionScope.sessionUser.email}</b><br><br>
                    失效时间：<b>${sessionScope.sessionUser.expireTime}</b><br><br>
                    允许访问IP：<b>${(sessionScope.sessionUser.allowIps).replace(',',' ')}</b>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改密码的模态窗口 -->
<div class="modal fade" id="editPwdModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 70%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">修改密码</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="oldPwd" class="col-sm-2 control-label">原密码</label>
                        <div class="col-sm-10" style="width: 700px;">
                            <input type="password" class="form-control" id="oldPwd"
                                   style="width: 540px;display: initial">
                            <span id="aOldPwd" style="color: #ff0000"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="newPwd" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-10" style="width: 700px;">
                            <input type="password" class="form-control" id="newPwd"
                                   style="width: 540px;display: initial">
                            <span id="aNewPwd" style="color: #ff0000"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10" style="width: 700px;">
                            <input type="password" class="form-control" id="confirmPwd"
                                   style="width: 540px;display: initial">
                            <span id="aConfirmPwd" style="color: #ff0000"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="updateUserPassword" type="button" class="btn btn-primary">更新
                </button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(() => {

        $("#updateUserPassword").click(() => {
            //收集参数
            let oldPwd = $.trim($("#oldPwd").val())
            let newPwd = $.trim($("#newPwd").val())
            let confirmPwd = $.trim($("#confirmPwd").val())
            //判断参数
            $("#aConfirmPwd").html("")
            if (!oldPwd) {
                $("#aOldPwd").html("原密码不能为空")
                return;
            }
            $("#aOldPwd").html("")
            if (!newPwd) {
                $("#aNewPwd").html("新密码不能为空")
                return;
            }
            $("#aNewPwd").html("")
            if (!confirmPwd) {
                $("#aConfirmPwd").html("确认密码不能为空")
                return;
            }
            $("#aConfirmPwd").html("")
            if (newPwd != confirmPwd) {
                $("#aConfirmPwd").html("两次密码不一致")
                return
            }
            let id = "${sessionScope.sessionUser.id}"
            $.post("settings/qx/user/editUserPassword", {id: id, oldPwd: oldPwd, newPwd: newPwd}, (data) => {
                if (data.code == "1") {
                    $("#editPwdModal").modal("hide")
                    alert("修改成功,请重新登入")
                    location = ""
                } else {
                    alert(data.msg)
                }
            }, "json")
        })
    })
</script>

<!-- 退出系统的模态窗口 -->
<div class="modal fade" id="exitModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">离开</h4>
            </div>
            <div class="modal-body">
                <p>您确定要退出系统吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="logoutBtn">确定</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(() => {
        $("#logoutBtn").click(function () {
            window.location.href = "settings/qx/user/logout";
        })
        //回车事件
        $(window).keydown(e => {
            if (e.key == "enter") {
                if (!$("#exitModal").is(":hidden")) {
                    $("#logoutBtn").click()
                }
            }
        })
    })
</script>
<!-- 顶部 -->
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2020&nbsp;简单九儿</span></div>
    <div style="position: absolute; top: 15px; right: 15px;">
        <ul>
            <li class="dropdown user-dropdown">
                <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle"
                   data-toggle="dropdown">
                    <span class="glyphicon glyphicon-user"></span>${sessionScope.sessionUser.name}<span
                        class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <c:if test="${(pageContext.request.requestURL).toString().contains('settings/dictionary/index.jsp') or
                                (pageContext.request.requestURL).toString().contains('settings/index.jsp')}">
                        <li><a href="workbench/index"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
                    </c:if>
                    <c:if test="${(pageContext.request.requestURL).toString().endsWith('workbench/index.jsp')}">
                        <li><a href="settings/index"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
                    </c:if>
                    <c:if test="${(pageContext.request.requestURL).toString().endsWith('settings/dictionary/index.jsp')}">
                        <li><a href="settings/index"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
                    </c:if>
                    <li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span
                            class="glyphicon glyphicon-file"></span> 我的资料</a></li>
                    <li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span
                            class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
                    <li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span
                            class="glyphicon glyphicon-off"></span> 退出</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>