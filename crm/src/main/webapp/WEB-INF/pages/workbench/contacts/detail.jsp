<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        //默认情况下取消和保存按钮是隐藏的
        let cancelAndSaveBtnDefault = true;

        $(() => {
            findTransaction()
            //联系人id
            let contactsId = $("#contactsId")
            //联系人备注输入框
            let remark = $("#remark")

            //输入框事件
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
            //联系人备注div
            $("#contactsRemarkDiv").on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            }).on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            }).on("mouseover", ".myHref", function () {
                $(this).children("span").css("color", "red");
            }).on("mouseout", ".myHref", function () {
                $(this).children("span").css("color", "#E6E6E6");
            })

            //关联市场活动数据区
            let relatedActivityTbody = $("#relatedActivityTbody")
            //关联市场活动全选按钮
            let relatedAllCheckbox = $("#relatedAllCheckbox")
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

            //添加联系人备注点击按钮
            $("#addContactsRemarkBtn").click(() => {
                let noteContent = remark.val()
                let id = contactsId.val()
                if (!noteContent) {
                    alert("备注信息不能为空")
                    return
                }
                $.ajax({
                    url: "workbench/contacts/saveContactsRemark",
                    data: {
                        contactsId: id,
                        noteContent: noteContent,
                        createBy: '${sessionScope.sessionUser.id}'
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            $("#remarkDiv").before(
                                '<div id="' + data.data.id + '" class="remarkDiv" style="height: 60px;">\
                                    <img title="' + data.data.createBy + '" src="static/image/QQ.jpg" style="width: 30px; height:30px;">\
                                    <div style="position: relative; top: -40px; left: 40px;">\
                                        <h5>' + noteContent + '</h5>\
                                    <font color="gray">联系人</font> <font color="gray">-</font> <b>${contacts.fullName}-${contacts.customerId}</b> \
                                    <small style="color: gray;">' + data.data.createTime + ' 由 ' + data.data.createBy + ' 创建</small>\
                                        <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">\
                                            <a class="myHref" onclick="modifyContactsRemark(\'' + data.data.id + '\')">\
                                            <span class="glyphicon glyphicon-edit"style="font-size: 20px; color: #E6E6E6;">\
                                            </span></a>&nbsp;&nbsp;&nbsp;&nbsp;\
                                            <a class="myHref" onclick="removeContactsRemark(\'' + data.data.id + '\')">\
                                            <span class="glyphicon glyphicon-remove"style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                        </div>\
                                    </div>\
                                </div>')
                            remark.val("")
                        }
                    }
                })
            })
            //确定更新按钮单击事件
            $("#updateRemarkBtn").click(() => {
                let id = $("#editId").val()
                let noteContent = $("#noteContent").val()
                $.ajax({
                    url: "workbench/contacts/modifyContactsRemark",
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
                                '<img title="' + data.data.createBy + '" src="static/image/QQ.jpg" style="width: 30px; height:30px;">\
                                    <div style="position: relative; top: -40px; left: 40px;">\
                                        <h5>' + noteContent + '</h5>\
                                    <font color="gray">联系人</font> <font color="gray">-</font> <b>${contacts.fullName}-${contacts.customerId}</b> \
                                    <small style="color: gray;">' + data.data.editTime + ' 由 ' + data.data.editBy + ' 修改</small>\
                                        <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">\
                                            <a class="myHref" onclick="modifyContactsRemark(\'' + data.data.id + '\')">\
                                            <span class="glyphicon glyphicon-edit"style="font-size: 20px; color: #E6E6E6;">\
                                            </span></a>&nbsp;&nbsp;&nbsp;&nbsp;\
                                            <a class="myHref" onclick="removeContactsRemark(\'' + data.data.id + '\')">\
                                            <span class="glyphicon glyphicon-remove"style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                        </div>\
                                    </div>')
                            $("#editRemarkModal").modal("hide")
                        }
                    }
                })
            })

            //确认关联市场活动
            let relatedActivity = $("#relatedActivity")
            //关联市场活动模态窗口
            let relatedActivityModal = $("#relatedActivityModal")
            //市场活动数据区
            let ActivityTbody = $("#ActivityTbody")
            //查询市场活动输入框
            let relatedInputName = $("#relatedInputName")

            //关联市场活动按钮单击事件
            $("#relatedActivityBtn").click(() => {
                relatedInputName.val("")
                relatedAllCheckbox.prop("checked", false)
                $.ajax({
                    url: "workbench/activity/findActivityForDetailSelectiveByNameAndContactsId",
                    data: {
                        contactsId: contactsId.val()
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
            //查询市场活动
            relatedInputName.keyup(() => {
                let name = relatedInputName.val()
                $.ajax({
                    url: "workbench/activity/findActivityForDetailSelectiveByNameAndContactsId",
                    data: {
                        name: name,
                        contactsId: contactsId.val()
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
                console.log(activityIds)
                $.ajax({
                    url: "workbench/contacts/addContactsActivityRelation",
                    data: {
                        contactsId: contactsId.val(),
                        activityIds: activityIds
                    },
                    type: "post",
                    datatype: "json",
                    traditional: true,
                    success(data) {
                        if (data.code == "1") {
                            alert(data.message)
                            ActivityTbody.empty()
                            // console.log(data.data)
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

            //删除联系人单击事件
            $("#removeCustomerBtn").click(() => {
                let ids = $("#removeCustomerId").val()
                $.ajax({
                    url: "workbench/contacts/removeByMultiplePrimaryKey",
                    data: {
                        ids: ids
                    },
                    type: 'post',
                    datatype: 'json',
                    success(data) {
                        if (data.code == "1") {
                            $("#tr_" + ids + "").remove()
                            $("#removeContactsModal").modal("hide")
                        }
                    }
                })
            })

            //创建交易按钮单击事件
            $("#addTransactionBtn").click(() => {
                location.href = "workbench/transaction/saveIndex"
            })

            //确定删除交易单击事件
            $("#deleteTransactionBtn").click(() => {
                $.ajax({
                    url: 'workbench/transaction/removeTransactionByPrimaryKeys',
                    data: {
                        ids: $("#transactionId").val()
                    },
                    type: 'post',
                    datatype: 'json',
                    success(data) {
                        if (data.code == "1") {
                            findTransaction()
                            $("#removeTransactionModal").modal("hide")
                        }
                    }
                })
            })
        });

        //修改线索备注函数
        function modifyContactsRemark(id) {
            $.ajax({
                url: "workbench/contacts/findContactsRemark",
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
        function removeContactsRemark(id) {
            $.ajax({
                url: "workbench/contacts/removeContactsRemark",
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
                url: "workbench/contacts/removeByPrimaryKey",
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

        //查询交易信息
        function findTransaction() {
            $.ajax({
                url: 'workbench/contacts/findTransactionForDetailById',
                data: {
                    id: $("#contactsId").val()
                },
                type: 'post',
                datatype: 'json',
                complete: false,
                success(data) {
                    // console.log(data)
                    let html = []
                    $(data).each(function () {
                        html.push('<tr>\
                                        <td><a href="workbench/transaction/findTransactionForDetailByPrimaryKeyToDetail?id=' + this.id + '" style="text-decoration: none;">' + this.name + '</a></td>\
                                        <td>' + this.money + '</td>\
                                        <td>' + this.stage + '</td>\
                                        <td>' + getPossibilityByStageValue(this.stage) + '</td>\
                                        <td>' + this.expectedDate + '</td>\
                                        <td>' + (this.type || "") + '</td>\
                                        <td><a onclick="deleteTransaction(\'' + this.id + '\')" style="text-decoration: none;">\
                                                <span class="glyphicon glyphicon-remove"></span>删除\
                                            </a>\
                                        </td>\
                                    </tr>')
                    })
                    $("#transactionTbody").html(html)
                }
            })
        }

        //删除交易弹出窗口
        function deleteTransaction(id) {
            $("#transactionId").val(id)
            $("#removeTransactionModal").modal("show")
        }

        //查询交易阶段可能性
        function getPossibilityByStageValue(stageValue) {
            let value = 0
            $.ajax({
                url: 'workbench/transaction/getPossibilityByStageValue',
                data: {
                    stageValue: stageValue
                },
                type: 'post',
                datatype: 'json',
                complete: false,
                async: false,
                success(data) {
                    // console.log(data)
                    value = data;
                }
            })
            return value
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
                <h4 class="modal-title" id="ModalLabel">修改备注</h4>
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
<!-- 解除联系人和市场活动关联的模态窗口 -->
<div class="modal fade" id="unbundActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">解除关联</h4>
            </div>
            <div class="modal-body">
                <p>您确定要解除该关联关系吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">解除</button>
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
<!-- 删除交易的模态窗口 -->
<div class="modal fade" id="removeTransactionModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">删除交易</h4>
            </div>
            <div class="modal-body">
                <p>您确定要删除该交易吗？</p>
                <input type="hidden" id="transactionId">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="deleteTransactionBtn" type="button" class="btn btn-danger">删除</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改联系人的模态窗口 -->
<div class="modal fade" id="editContactsModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改联系人</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-contactsOwner">
                                <option selected>zhangsan</option>
                                <option>lisi</option>
                                <option>wangwu</option>
                            </select>
                        </div>
                        <label for="edit-clueSource" class="col-sm-2 control-label">来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-clueSource">
                                <option></option>
                                <option selected>广告</option>
                                <option>推销电话</option>
                                <option>员工介绍</option>
                                <option>外部介绍</option>
                                <option>在线商场</option>
                                <option>合作伙伴</option>
                                <option>公开媒介</option>
                                <option>销售邮件</option>
                                <option>合作伙伴研讨会</option>
                                <option>内部研讨会</option>
                                <option>交易会</option>
                                <option>web下载</option>
                                <option>web调研</option>
                                <option>聊天</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-surname" value="李四">
                        </div>
                        <label for="edit-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-call">
                                <option></option>
                                <option selected>先生</option>
                                <option>夫人</option>
                                <option>女士</option>
                                <option>博士</option>
                                <option>教授</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-job" value="CTO">
                        </div>
                        <label for="edit-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-mphone" value="12345678901">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
                        </div>
                        <label for="edit-birth" class="col-sm-2 control-label">生日</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-birth">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-customerName"
                                   placeholder="支持自动补全，输入客户不存在则新建" value="动力节点">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe">这是一条线索的描述信息</textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-nextContactTime">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="edit-address1">北京大兴区大族企业湾</textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();">
        <span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span>
    </a>
</div>
<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>${contacts.fullName} <small> - ${contacts.customerId}</small></h3>
        <input type="hidden" id="contactsId" value="${contacts.id}">
    </div>
    <%--    <div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editContactsModal"><span
                    class="glyphicon glyphicon-edit"></span> 编辑
            </button>
            <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
        </div>--%>
</div>
<br/>
<br/>
<br/>
<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${contacts.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">来源</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${contacts.source}&nbsp;</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">客户名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${contacts.fullName}&nbsp;</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">姓名</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${contacts.customerId}&nbsp;</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">邮箱</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${contacts.email}&nbsp;</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${contacts.cellPhone}&nbsp;</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">职位</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${contacts.job}&nbsp;</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">生日</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${contacts.birth}&nbsp;</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${contacts.createBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${contacts.createTime}&nbsp;</small>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${contacts.editBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${contacts.editTime}&nbsp;</small>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${contacts.description}&nbsp;
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 70px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${contacts.contactSummary}&nbsp;
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 80px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;">
            <b>${contacts.nextContactTime}&nbsp;</b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 90px;">
        <div style="width: 300px; color: gray;">详细地址</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${contacts.address}&nbsp;
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>
<!-- 备注 -->
<div id="contactsRemarkDiv" style="position: relative; top: 20px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>
    <c:forEach items="${contactsRemarkList}" var="contactsRemark">
        <div id="${contactsRemark.id}" class="remarkDiv" style="height: 60px;">
            <img title="${contactsRemark.createBy}" src="static/image/QQ.jpg" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5>${contactsRemark.noteContent}</h5>
                <font color="gray">联系人</font> <font color="gray">-</font>
                <b>${contacts.fullName}-${contacts.customerId}</b> <small style="color: gray;">
                    ${contactsRemark.editFlag?contactsRemark.editTime:contactsRemark.createTime} 由
                    ${contactsRemark.editFlag?contactsRemark.editBy:contactsRemark.createBy}
                    ${contactsRemark.editFlag?"修改":"创建"}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" onclick="modifyContactsRemark('${contactsRemark.id}')">
                        <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" onclick="removeContactsRemark('${contactsRemark.id}')">
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
                <button id="addContactsRemarkBtn" type="button" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>
<!-- 交易 -->
<div>
    <div style="position: relative; top: 20px; left: 40px;">
        <div class="page-header">
            <h4>交易</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table id="activityTable2" class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>名称</td>
                    <td>金额</td>
                    <td>阶段</td>
                    <td>可能性</td>
                    <td>预计成交日期</td>
                    <td>类型</td>
                    <td></td>
                </tr>
                </thead>
                <tbody id="transactionTbody">
                </tbody>
            </table>
        </div>

        <div>
            <a id="addTransactionBtn" style="text-decoration: none;">
                <span class="glyphicon glyphicon-plus"></span>新建交易
            </a>
        </div>
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
                        <td>${activity.startDate}</td>
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