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
            let customerId = $("#customerId")
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
            $("#CustomerRemarkDiv").on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            }).on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            }).on("mouseover", ".myHref", function () {
                $(this).children("span").css("color", "red");
            }).on("mouseout", ".myHref", function () {
                $(this).children("span").css("color", "#E6E6E6");
            })

            //设置创建日期样式
            $(".addDate").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//选择器上能选择的最小日期
                initialDate: new Date(),//设置默认时间
                autoclose: true,//单击后是否关闭
                todayBtn: true,//每次打开是否显示当前时间
                clearBtn: true,//是否显示清空按钮
                container: '#createContactsModal'
            })

            //创建联系人的模态窗口
            let createContactsModal = $("#createContactsModal")

            //添加联系人备注点击按钮
            $("#addContactsRemarkBtn").click(() => {
                let noteContent = remark.val()
                let id = customerId.val()
                if (!noteContent) {
                    alert("备注信息不能为空")
                    return
                }
                $.ajax({
                    url: "workbench/customer/saveCustomerRemark",
                    data: {
                        customerId: id,
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
                                    <font color="gray">客户</font> <font color="gray">-</font> <b>${customer.name}-${customer.website}</b> \
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
                    url: "workbench/customer/modifyCustomerRemark",
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
                                    <font color="gray">客户</font> <font color="gray">-</font> <b>${customer.name}-${customer.website}</b> \
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

            //创建按钮点击视图
            let createContactsViewBtn = $("#createContactsViewBtn")
            //确定创建联系人按钮
            let createContactsBtn = $("#createContactsBtn")
            //联系人数据区
            let customerTbody = $("#customerTbody")

            //创建界面所有者
            let createContactsOwner = $("#create-contactsOwner")
            //创建按钮点击事件
            createContactsViewBtn.click(() => {
                $("#createForm")[0].reset()
                createContactsOwner.val("${sessionScope.sessionUser.id}")
                createContactsModal.modal("show")
            })
            //确定添加数据按钮点击事件
            createContactsBtn.click(() => {
                let owner = $("#create-contactsOwner").val()
                let source = $("#create-clueSource").val()
                let fullName = $("#create-surname").val()
                let appellation = $("#create-call").val()
                let job = $("#create-job").val()
                let cellPhone = $("#create-cellPhone").val()
                let email = $("#create-email").val()
                let birth = $("#create-birth").val()
                let customerId = $("#create-customerName").val()
                let description = $("#create-describe").val()
                let contactSummary = $("#create-contactSummary").val()
                let nextContactTime = $("#create-nextContactTime").val()
                let address = $("#create-address").val()
                if (!fullName) {
                    alert("姓名不能为空")
                    return;
                }
                $.ajax({
                    url: "workbench/contacts/addContacts",
                    data: {
                        owner: owner,
                        source: source,
                        fullName: fullName,
                        appellation: appellation,
                        job: job,
                        cellPhone: cellPhone,
                        email: email,
                        birth: birth,
                        customerId: customerId,
                        description: description,
                        contactSummary: contactSummary,
                        nextContactTime: nextContactTime,
                        address: address
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            $.ajax({
                                url: 'workbench/customer/findCustomerByCustomerId',
                                data: {
                                    customerId: $("#customerId").val()
                                },
                                type: 'post',
                                datatype: 'json',
                                success(data) {
                                    if (data.code == "1") {
                                        let html = []
                                        $.each(data.data, function () {
                                            html.push('<tr id="tr_' + this.id + '">\
                                                            <td><a href="deleteCustomer(\'' + this.id + '\')"\
                                                            style="text-decoration: none;">' + this.fullName + '</a>\
                                                                </td>\
                                                                <td>' + this.email + '</td>\
                                                                <td>' + this.cellPhone + '</td>\
                                                                <td><a onclick="deleteCustomer(\'' + this.id + '\')"style="text-decoration: none;">\
                                                                    <span class="glyphicon glyphicon-remove"></span>删除</a>\
                                                            </td>\
                                                        </tr>')
                                        })
                                        customerTbody.html(html)
                                    }
                                }
                            })
                            createContactsModal.modal("hide")
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
                url: "workbench/customer/findCustomerRemark",
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
                url: "workbench/customer/removeCustomerRemark",
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

        //删除联系人函数
        function deleteCustomer(id) {
            $("#removeCustomerId").val(id)
            $("#removeContactsModal").modal("show")
        }

        //查询交易信息
        function findTransaction() {
            $.ajax({
                url: 'workbench/customer/findTransactionForDetailById',
                data: {
                    id: $("#customerId").val()
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
<!-- 删除联系人的模态窗口 -->
<div class="modal fade" id="removeContactsModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">删除联系人</h4>
            </div>
            <div class="modal-body">
                <p>您确定要删除该联系人吗？</p>
                <input type="hidden" id="removeCustomerId">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="removeCustomerBtn" type="button" class="btn btn-danger">删除</button>
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
<!-- 创建联系人的模态窗口 -->
<div class="modal fade" id="createContactsModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
            </div>
            <div class="modal-body">
                <form id="createForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-contactsOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-clueSource" class="col-sm-2 control-label">来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-clueSource">
                                <option></option>
                                <c:forEach items="${sourceList}" var="source">
                                    <option value="${source.id}">${source.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-surname">
                        </div>
                        <label for="create-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-call">
                                <option></option>
                                <c:forEach items="${appellationList}" var="appellation">
                                    <option value="${appellation.id}">${appellation.value}</option>
                                </c:forEach>
                            </select>
                        </div>

                    </div>

                    <div class="form-group">
                        <label for="create-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-job">
                        </div>
                        <label for="create-cellPhone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cellPhone">
                        </div>
                    </div>

                    <div class="form-group" style="position: relative;">
                        <label for="create-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-email">
                        </div>
                        <label for="create-birth" class="col-sm-2 control-label">生日</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control addDate" id="create-birth" readonly
                                   style="background-color: #ffffff">
                        </div>
                    </div>

                    <div class="form-group" style="position: relative;">
                        <label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-customerName"
                                   placeholder="支持自动补全，输入客户不存在则新建" value="${customer.name}">
                        </div>
                    </div>

                    <div class="form-group" style="position: relative;">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-describe"></textarea>
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
                                <input type="text" class="form-control addDate" id="create-nextContactTime" readonly
                                       style="background-color: #ffffff">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="create-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="createContactsBtn" type="button" class="btn btn-primary">保存</button>
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
        <h3>${customer.name} <small><a href="http://${customer.website}" target="_blank">${customer.website}</a></small>
        </h3>
        <input type="hidden" id="customerId" value="${customer.id}">
    </div>
    <%--    <div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editCustomerModal"><span
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
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${customer.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${customer.name}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">公司网站</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${customer.website}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${customer.phone}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${customer.createBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${customer.createTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${customer.editBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${customer.editTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${customer.contactSummary}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${customer.nextContactTime}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${customer.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 70px;">
        <div style="width: 300px; color: gray;">详细地址</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${customer.address}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>
<!-- 备注 -->
<div id="CustomerRemarkDiv" style="position: relative; top: 10px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>
    <c:forEach items="${customerRemarkList}" var="customerRemark">
        <div id="${customerRemark.id}" class="remarkDiv" style="height: 60px;">
            <img title="${customerRemark.createBy}" src="static/image/QQ.jpg" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5>${customerRemark.noteContent}</h5>
                <font color="gray">客户</font> <font color="gray">-</font>
                <b>${customer.name}-${customer.website}</b> <small style="color: gray;">
                    ${customerRemark.editFlag?customerRemark.editTime:customerRemark.createTime} 由
                    ${customerRemark.editFlag?customerRemark.editBy:customerRemark.createBy}
                    ${customerRemark.editFlag?"修改":"创建"}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" onclick="modifyContactsRemark('${customerRemark.id}')">
                        <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" onclick="removeContactsRemark('${customerRemark.id}')">
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
<!-- 联系人 -->
<div>
    <div style="position: relative; top: 20px; left: 40px;">
        <div class="page-header">
            <h4>联系人</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table id="activityTable" class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>名称</td>
                    <td>邮箱</td>
                    <td>手机</td>
                    <td></td>
                </tr>
                </thead>
                <tbody id="customerTbody">
                <c:forEach items="${contactsList}" var="contacts">
                    <tr id="tr_${contacts.id}">
                        <td><a href="deleteCustomer('${contacts.id}')"
                               style="text-decoration: none;">${contacts.fullName}</a>
                        </td>
                        <td>${contacts.email}</td>
                        <td>${contacts.cellPhone}</td>
                        <td>
                            <a onclick="deleteCustomer('${contacts.id}')" style="text-decoration: none;">
                                <span class="glyphicon glyphicon-remove"></span>删除
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div>
            <a id="createContactsViewBtn" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建联系人</a>
        </div>
    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>