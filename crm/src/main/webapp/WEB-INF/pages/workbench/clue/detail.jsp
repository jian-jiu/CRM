<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        //默认情况下取消和保存按钮是隐藏的
        let cancelAndSaveBtnDefault = true;
        //窗口加载完毕
        $(() => {

            //线索备注输入框
            let remark = $("#remark")

            remark.focus(() => {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    $("#remarkDiv").css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });
            $("#cancelBtn").click(() => {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                $("#remarkDiv").css("height", "90px");
                cancelAndSaveBtnDefault = true;
            });
            //线索备注Div
            $("#clueRemarkDiv").on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            }).on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            }).on("mouseover", ".myHref", function () {
                $(this).children("span").css("color", "red");
            }).on("mouseout", ".myHref", function () {
                $(this).children("span").css("color", "#E6E6E6");
            })

            //线索id
            let clueId = $("#clueId")

            //添加线索备注按钮
            let addClueRemarkBtn = $("#addClueRemarkBtn")
            //确认修改按钮点击事件
            let updateRemarkBtn = $("#updateRemarkBtn")
            //确认关联市场活动
            let relatedActivity = $("#relatedActivity")

            //修改线索备注模态窗口
            let editRemarkModal = $("#editRemarkModal")
            //关联市场活动模态窗口
            let relatedActivityModal = $("#relatedActivityModal")

            //关联市场活动数据
            let relatedActivityTbody = $("#relatedActivityTbody")
            //关联市场活动全选按钮
            let relatedAllCheckbox = $("#relatedAllCheckbox")

            //市场活动数据
            let ActivityTbody = $("#ActivityTbody")

            //添加线索备注点击按钮
            addClueRemarkBtn.click(() => {
                let noteContent = remark.val()
                let id = clueId.val()
                if (!noteContent) {
                    alert("备注信息不能为空")
                    return
                }
                $.ajax({
                    url: "workbench/clue/addClueRemark",
                    data: {
                        clueId: id,
                        noteContent: noteContent,
                        createBy: '${sessionScope.sessionUser.id}'
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            $("#remarkDiv").before(
                                '<div id="' + data.data.id + '" class="remarkDiv" style="height: 60px;">\
                                <img title="${sessionScope.sessionUser.name}" src="static/image/QQ.jpg" style="width: 30px; height:30px;">\
                                    <div style="position: relative; top: -40px; left: 40px;">\
                                    <h5>' + noteContent + '</h5>\
                                    <font color="gray">线索</font> <font color="gray">-</font> <b>' + data.data.createBy + '-${clue.company}</b>\
                                    <small style="color: gray;">' + data.data.createTime + ' 由 ${sessionScope.sessionUser.name} 创建</small>\
                                        <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">\
                                            <a class="myHref" onclick="modify(\'' + data.data.id + '\')">\
                                            <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                            &nbsp;&nbsp;&nbsp;&nbsp;\
                                            <a class="myHref" onclick="removeClueRemark(\'' + data.data.id + '\')">\
                                            <span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                        </div>\
                                    </div>\
                                </div>')
                            remark.val("")
                        }
                    }
                })
            })

            //修改按钮点击事件
            updateRemarkBtn.click(() => {
                let id = $("#editId").val()
                let noteContent = $("#noteContent").val()
                $.ajax({
                    url: "workbench/clue/modifyClueRemark",
                    data: {
                        id: id,
                        noteContent: noteContent
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            $("#" + id + "").empty()
                            $("#" + id + "").append(
                                '<img title="${sessionScope.sessionUser.name}" src="static/image/QQ.jpg" style="width: 30px; height:30px;">\
                                <div style="position: relative; top: -40px; left: 40px;">\
                                <h5>' + noteContent + '</h5>\
                                <font color="gray">线索</font> <font color="gray">-</font> <b>' + data.data.editBy + '-${clue.company}</b>\
                                <small style="color: gray;">' + data.data.editTime + ' 由 ${sessionScope.sessionUser.name} 修改</small>\
                                    <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">\
                                    <a class="myHref" onclick="modify(\'' + data.data.id + '\')">\
                                    <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                    &nbsp;&nbsp;&nbsp;&nbsp;\
                                    <a class="myHref" onclick="removeClueRemark(\'' + data.data.id + '\')">\
                                    <span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                    </div>\
                                </div>')
                            editRemarkModal.modal("hide")
                        }
                    }
                })
            })

            //关联市场活动全选按钮点击事件
            relatedAllCheckbox.click(() => {
                $("#relatedActivityTbody input[type='checkbox']").prop("checked", relatedAllCheckbox.prop("checked"))
            })
            //给其他复选框添加单击事件
            relatedActivityTbody.on("click", "input[type='checkbox']", function () {
                if ($("#relatedActivityTbody input[type='checkbox']").size() == $("#relatedActivityTbody input[type='checkbox']:checked").size()) {
                    relatedAllCheckbox.prop("checked", true)
                } else {
                    relatedAllCheckbox.prop("checked", false)
                }
            })

            //关联市场活动按钮单击事件
            $("#relatedActivityBtn").click(() => {
                relatedAllCheckbox.prop("checked", false)
                $.ajax({
                    url: "workbench/activity/findActivityForDetailSelectiveByName",
                    data: {
                        clueId: clueId.val()
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            // console.log(data.data)
                            relatedActivityTbody.empty()
                            $.each(data.data, function (index) {
                                relatedActivityTbody.append(
                                    '<tr class="' + (index % 2 == 0 ? "active" : "") + '">\
                                        <td><input type="checkbox" value="' + this.id + '"/></td>\
                                        <td>' + this.name + '</td>\
                                        <td>' + this.startDate + '</td>\
                                        <td>' + this.endDate + '</td>\
                                        <td>' + this.owner + '</td>\
                                    </tr>')
                            })
                            relatedActivityModal.modal("show")
                        }
                    }
                })
            })
            //确定关联市场活动按钮单击事件
            relatedActivity.click(() => {
                let checkedCheckbox = $("#relatedActivityTbody input[type='checkbox']:checked")
                if (checkedCheckbox.size() < 1) {
                    alert("请选择一条需要关联的市场活动")
                    return
                }
                let activityIds = []
                $.each(checkedCheckbox, function () {
                    activityIds.push(this.value)
                })
                // console.log(activityIds)
                $.ajax({
                    url: "workbench/activity/addClueActivityRelation",
                    data: {
                        clueId: clueId.val(),
                        activityIds: activityIds
                    },
                    type: "post",
                    datatype: "json",
                    traditional: true,
                    success(data) {
                        if (data.code == "1") {
                            alert(data.message)
                            ActivityTbody.empty()
                            console.log(data.data)
                            $.each(data.data, function () {
                                ActivityTbody.append(
                                    '<tr id="' + this.id + '">\
                                        <td>' + this.name + '</td>\
                                        <td>' + this.createTime + '</td>\
                                        <td>' + this.endDate + '</td>\
                                        <td>' + this.owner + '</td>\
                                        <td><a onclick="disconnectRelated(\'' + this.id + '\')" style="text-decoration: none;">\
                                        <span class="glyphicon glyphicon-remove"></span>解除关联</a></td>\
                                    </tr>')
                            })
                            relatedActivityModal.modal("hide")
                        }
                    }
                })
            })

            //查询市场活动
            $("#relatedInputName").keyup(() => {
                let name = this.value
                $.ajax({
                    url: "workbench/activity/findActivityForDetailSelectiveByName",
                    data: {
                        name: name,
                        clueId: clueId.val()
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            relatedActivityTbody.empty()
                            $.each(data.data, function (index) {
                                relatedActivityTbody.append(
                                    '<tr class="' + (index % 2 == 0 ? "active" : "") + '">\
                                        <td><input type="checkbox" value="' + this.id + '"/></td>\
                                        <td>' + this.name + '</td>\
                                        <td>' + this.startDate + '</td>\
                                        <td>' + this.endDate + '</td>\
                                        <td>' + this.owner + '</td>\
                                    </tr>')
                            })
                        }
                    }
                })
            })

            //回车事件
            $(window).keydown(e => {
                if (e.key == "Enter") {
                    if (!relatedActivityModal.is(":hidden")) {
                        relatedActivity.click()
                    } else if (!editRemarkModal.is(":hidden")) {
                        updateRemarkBtn.click()
                    } else if (!addClueRemarkBtn.is(":hidden")) {
                        addClueRemarkBtn.click()
                    }
                }
            })
        });

        //修改线索备注函数
        function modify(id) {
            $.ajax({
                url: "workbench/clue/findClueRemarkById",
                data: {
                    id: id
                },
                type: "post",
                datatype: "json",
                success(data) {
                    if (data.code == "1") {
                        $("#editId").val(data.data.id)
                        $("#noteContent").val(data.data.noteContent)
                        $("#editRemarkModal").modal("show")
                    }
                }
            })
        }

        //删除线索备注函数
        function removeClueRemark(id) {
            $.ajax({
                url: "workbench/clue/removeClueRemarkById",
                data: {
                    id: id
                },
                type: "post",
                datatype: "json",
                success(data) {
                    if (data.code == "1") {
                        $("#" + id + "").remove()
                    }
                }
            })
        }

        //解除关联
        function disconnectRelated(id) {
            $.ajax({
                url: "workbench/activity/removeByPrimaryKey",
                data: {
                    id: id
                },
                type: "post",
                datatype: "json",
                success(data) {
                    if (data.code == "1") {
                        $("#" + id + "").remove()
                    }
                }
            })
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
<!-- 关联市场活动的模态窗口 -->
<div class="modal fade" id="relatedActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">关联市场活动</h4>
            </div>
            <div class="modal-body">
                <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                    <form class="form-inline" role="form">
                        <div class="form-group has-feedback">
                            <input id="relatedInputName" type="text" autocomplete="off" class="form-control"
                                   style="width: 300px;"
                                   placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td><input id="relatedAllCheckbox" type="checkbox"/></td>
                        <td>名称</td>
                        <td>开始日期</td>
                        <td>结束日期</td>
                        <td>所有者</td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody id="relatedActivityTbody">
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="relatedActivity" type="button" class="btn btn-primary">关联</button>
            </div>
        </div>
    </div>
</div>
<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>${clue.fullName} <small>${clue.company}</small></h3>
        <input id="clueId" type="hidden" value="${clue.id}">
    </div>
    <div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
        <button type="button" class="btn btn-default" onclick="window.location.href='convert.html';"><span
                class="glyphicon glyphicon-retweet"></span> 转换
        </button>

    </div>
</div>

<br/>
<br/>
<br/>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.fullName}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.owner}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">公司</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.company}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">职位</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.job}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">邮箱</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.email}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.phone}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 50px; top: 30px;">
        <div style="width: 300px; color: gray;">公司网站</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;">
            <a href="http://${clue.website}" target="_blank">${clue.website}</a></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.cellPhone}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">线索状态</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.source}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">线索来源</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.state}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${clue.createBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${clue.createTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${clue.editBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${clue.editTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 70px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${clue.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 80px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${clue.contactSummary}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 90px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.nextContactTime}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 100px;">
        <div style="width: 300px; color: gray;">详细地址</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${clue.address}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div id="clueRemarkDiv" style="position: relative; top: 40px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>

    <c:forEach items="${clueRemarkList}" var="clueRemark">
        <div id="${clueRemark.id}" class="remarkDiv" style="height: 60px;">
            <img title="${clueRemark.createBy}" src="static/image/QQ.jpg" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5>${clueRemark.noteContent}</h5>
                <font color="gray">线索</font> <font color="gray">-</font> <b>${clueRemark.createBy}-${clue.company}</b>
                <small style="color: gray;">${clueRemark.editFlag?clueRemark.editTime:clueRemark.createTime} 由
                        ${clueRemark.editFlag?clueRemark.editBy:clueRemark.createBy}
                        ${clueRemark.editFlag?"修改":"创建"}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" onclick="modify('${clueRemark.id}')">
                        <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" onclick="removeClueRemark('${clueRemark.id}')">
                        <span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
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
                <button id="addClueRemarkBtn" type="button" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>

<!-- 市场活动 -->
<div>
    <div style="position: relative; top: 60px; left: 40px;">
        <div class="page-header">
            <h4>市场活动</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>名称</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                    <td>所有者</td>
                    <td></td>
                </tr>
                </thead>
                <tbody id="ActivityTbody">
                <c:forEach items="${activityList}" var="activity">
                    <tr id="${activity.id}">
                        <td>${activity.name}</td>
                        <td>${activity.createTime}</td>
                        <td>${activity.endDate}</td>
                        <td>${activity.owner}</td>
                        <td><a onclick="disconnectRelated('${activity.id}')" style="text-decoration: none;"><span
                                class="glyphicon glyphicon-remove"></span>解除关联</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div>
            <a id="relatedActivityBtn" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
        </div>
    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>