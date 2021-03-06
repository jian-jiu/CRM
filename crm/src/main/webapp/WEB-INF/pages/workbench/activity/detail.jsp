<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        //活动id
        let activityId = $("#id")
        //默认情况下取消和保存按钮是隐藏的
        let cancelAndSaveBtnDefault = true;
        //页面加载完毕
        $(() => {
            //备注输入框
            let remark = $("#remark")
            //备注输入框div
            let remarkDiv = $("#remarkDiv")

            remark.focus(() => {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    remarkDiv.css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });
            $("#cancelBtn").click(() => {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                remarkDiv.css("height", "90px");
                cancelAndSaveBtnDefault = true;
            });
            $("#ActivityRemarkTopDiv").on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            }).on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            }).on("mouseover", ".myHref", function () {
                $(this).children("span").css("color", "red");
            }).on("mouseout", ".myHref", function () {
                $(this).children("span").css("color", "#E6E6E6");
            })

            //确定更新按钮
            let updateRemarkBtn = $("#updateRemarkBtn")
            //修改窗口
            let editRemarkModal = $("#editRemarkModal")
            //添加备注按钮
            let addActivityRemarkBtn = $("#addActivityRemarkBtn")

            //添加市场活动备注按钮单击事件
            addActivityRemarkBtn.click(() => {
                let noteContent = remark.val()
                let id = activityId.val()
                if (!noteContent) {
                    alert("备注消息不能为空!!!")
                    return
                }
                $.post("workbench/activity/addActivityRemark", {activityId: id, noteContent: noteContent}, (data) => {
                    if (data.code == "1") {
                        remarkDiv.before(
                            '<div id="div_' + data.data.id + '" class="remarkDiv" style="height: 60px;">\
                            <img title="${sessionScope.sessionUser.name}" src="static/image/QQ.jpg" style="width: 30px; height:30px;">\
                                <div style="position: relative; top: -40px; left: 40px;">\
                                <h5>' + noteContent + '</h5>\
                                <font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> \
                                <small style="color: gray;">\
                                ' + data.data.createTime + ' 由 ${sessionScope.sessionUser.name} 创建</small>\
                                    <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">\
                                    <a class="myHref" onclick="editActivityRemark(\'' + data.data.id + '\')">\
                                        <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                    &nbsp;&nbsp;&nbsp;&nbsp;\
                                    <a class="myHref" onclick="removeActivityRemark(\'' + data.data.id + '\')">\
                                        <span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                    </div>\
                                </div>\
                            </div>')
                        //设置备注输入框的值
                        remark.val("")
                    }
                }, "json")
            })

            //单击确定修改按钮
            updateRemarkBtn.click(() => {
                let editId = $("#editId").val()
                let noteContent = $.trim($("#noteContent").val())
                $.post("workbench/activity/updateActivityRemarkById", {
                    id: editId,
                    noteContent: noteContent
                }, (data) => {
                    if (data.code == "1") {
                        console.log(data.data)
                        let editIdDiv = $("#div_" + editId + "")
                        editIdDiv.empty()
                        editIdDiv.append(
                            '<img title="div_' + data.data.editBy + '" src="static/image/QQ.jpg" style="width: 30px; height:30px;">\
                            <div style="position: relative; top: -40px; left: 40px;">\
                            <h5>' + data.data.noteContent + '</h5>\
                            <font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> \
                            <small style="color: gray;">' + data.data.editTime + ' 由 ' + data.data.editBy + ' 修改</small>\
                                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">\
                                <a class="myHref" onclick="editActivityRemark(\'' + data.data.id + '\')">\
                                    <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                &nbsp;&nbsp;&nbsp;&nbsp;\
                                <a class="myHref" onclick="removeActivityRemark(\'' + data.data.id + '\')">\
                                    <span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                </div>\
                            </div>')
                        //关闭修改窗口
                        editRemarkModal.modal("hide")
                    }
                }, "json")
            })

            //回车事件
            $(window).keydown(e => {
                if (e.key == "Enter") {
                    if (!editRemarkModal.is(":hidden")) {
                        if ((!$("#noteContent")[0] == document.activeElement)) {
                            //确定修改市场活动备注
                            updateRemarkBtn.click()
                        }
                    } else if (!$("#cancelAndSaveBtn").is(":hidden")) {
                        if (!(remark[0] == document.activeElement)) {
                            //确定添加市场活动备注
                            addActivityRemarkBtn.click()
                        }
                    }
                }
            })
        })

        //编辑函数
        function editActivityRemark(id) {
            let noteContent = $("#div_" + id + " h5").html()
            $("#editId").val(id)
            $("#noteContent").val(noteContent)
            $("#editRemarkModal").modal("show")
        }

        //删除函数
        function removeActivityRemark(id) {
            $.post("workbench/activity/removeActivityRemark", {id: id}, (data) => {
                if (data.code == "1") {
                    $("#div_" + id + "").remove()
                }
            }, "json")
        }
    </script>
</head>
<body>
<!-- 修改市场活动备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
    <%-- 备注的id --%>
    <input type="hidden" id="editId">
    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="noteContent"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();">
        <span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
</div>
<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>市场活动-${activity.name} <small>${activity.startDate} ~ ${activity.endDate}</small></h3>
        <input type="hidden" id="id" name="id" value="${activity.id}">
    </div>
</div>
<br/>
<br/>
<br/>
<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.name}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">开始日期</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;">
            <b>${not empty activity.startDate && !(activity.startDate eq null)?activity.startDate:"&nbsp;"}</b>
        </div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;">
            <b>${not empty activity.endDate && !(activity.endDate eq null)?activity.startDate:"&nbsp;"}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">成本</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.cost}</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${activity.createBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${activity.createTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${activity.editBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${activity.editTime}&nbsp;</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${activity.description}&nbsp;
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div id="ActivityRemarkTopDiv" style="position: relative; top: 10px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>
    <div id="ActivityRemarkDiv"></div>
    <c:forEach items="${activityRemarkList}" var="activityRemark">
        <div id="div_${activityRemark.id}" class="remarkDiv" style="height: 60px;">
            <img title="${activityRemark.createBy}" src="static/image/QQ.jpg" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5>${activityRemark.noteContent}</h5>
                <font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> <small
                    style="color: gray;">
                    <%--<c:if test="${activityRemark.editFlag=='0'}">
                        ${activityRemark.createTime} 由${activityRemark.createBy}创建</small>
                    </c:if>
                    <c:if test="${activityRemark.editFlag=='1'}">
                        ${activityRemark.editTime} 由${activityRemark.editBy}修改</small>
                    </c:if>--%>
                    ${activityRemark.editFlag=='0'?activityRemark.createTime:activityRemark.editTime} 由
                    ${activityRemark.editFlag=='0'?activityRemark.createBy:activityRemark.editBy}
                    ${activityRemark.editFlag=='0'?"创建":"修改"} </small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" onclick="editActivityRemark('${activityRemark.id}')"><span
                            class="glyphicon glyphicon-edit"
                            style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" onclick="removeActivityRemark('${activityRemark.id}')"><span
                            class="glyphicon glyphicon-remove"
                            style="font-size: 20px; color: #E6E6E6;"></span></a>
                </div>
            </div>
        </div>
    </c:forEach>

    <div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button id="addActivityRemarkBtn" type="button" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>