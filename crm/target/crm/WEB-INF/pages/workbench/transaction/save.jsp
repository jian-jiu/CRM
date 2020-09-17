<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        $(() => {
            //所有用户
            let customerName;
            //获取所有用户
            $.ajax({
                url: 'workbench/customer/findCustomerAllName',
                type: 'post',
                datatype: 'json',
                success(data) {
                    // console.log(data)
                    customerName = data
                }
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
                container: "#formAdd"
            })
            //设置所有者
            $("#create-transactionOwner").val("${sessionScope.sessionUser.id}")

            //创建参数
            let createActivitySrc = $("#create-activitySrc")
            let createContactsName = $("#create-contactsName")
            //选择下拉框
            let createTransactionStage = $("#create-transactionStage")
            //客户输入框
            let createAccountName = $("#create-accountName")

            //市场活动数据区
            let activityTbody = $("#activityTbody")
            //查找市场活动窗口
            let findMarketActivity = $("#findMarketActivity")
            //点击查询市场活动
            $("#findActivityBtn,#create-activitySrc").click(() => {
                $.ajax({
                    url: "workbench/activity/findActivityForDetailSelectiveByName",
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            // console.log(data.data)
                            let html = []
                            $.each(data.data, function (index) {
                                html.push('<tr id="' + this.id + '" activityName="' + this.name + '" class="' + (index % 2 == 0 ? "active" : "") + '">\
                                                <td><input type="radio" name="activity" value="' + this.name + '"/></td>\
                                                <td>' + this.name + '</td>\
                                                <td>' + this.startDate + '</td>\
                                                <td>' + this.endDate + '</td>\
                                                <td>' + this.owner + '</td>\
                                           </tr>')
                            })
                            activityTbody.html(html)

                            findMarketActivity.modal("show")
                        }
                    }
                })
            })
            //查询市场活动输入框
            let activityInputName = $("#activityInputName")
            //查询市场活动
            activityInputName.keyup(() => {
                let name = activityInputName.val()
                $.ajax({
                    url: "workbench/activity/findActivityForDetailSelectiveByName",
                    data: {
                        name: name,
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            activityTbody.empty()
                            $.each(data.data, function (index) {
                                activityTbody.append('<tr class="' + (index % 2 == 0 ? "active" : "") + '">\
                                                                <td><input type="radio" name="activity" value="' + this.id + '"/></td>\
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
            //选择了一条市场活动
            activityTbody.on("click", "tr", function () {
                createActivitySrc.val($(this).attr("activityName"))
                createActivitySrc.attr('activityId', this.id)
                findMarketActivity.modal("hide")
            })

            //联系人数据区
            let contactsTbody = $("#contactsTbody")
            //查找联系人窗口
            let findContacts = $("#findContacts")
            //点击查询联系人
            $("#findContactsBtn,#create-contactsName").click(() => {
                $.ajax({
                    url: "workbench/contacts/findContactsForDetailByName",
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            // console.log(data.data)
                            let html = []
                            $.each(data.data, function (index) {
                                html.push('<tr id="' + this.id + '" activityName="' + this.fullName + '" class="' + (index % 2 == 0 ? "active" : "") + '">\
                                                <td><input type="radio" name="activity" id="' + this.id + '" value="' + this.fullName + '"/></td>\
                                                    <td>' + this.fullName + '</td>\
                                                    <td>' + this.email + '</td>\
                                                <td>' + this.cellPhone + '</td>\
                                            </tr>')
                            })
                            contactsTbody.html(html)
                            findContacts.modal("show")
                        }
                    }
                })
            })
            //查询联系人输入框
            let contactsInputName = $("#contactsInputName")
            //查询联系人
            contactsInputName.keyup(() => {
                let name = contactsInputName.val()
                $.ajax({
                    url: "workbench/contacts/findContactsForDetailByName",
                    data: {
                        name: name,
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            contactsTbody.empty()
                            $.each(data.data, function (index) {
                                contactsTbody.append('<tr class="' + (index % 2 == 0 ? "active" : "") + '">\
                                                        <td><input type="radio" name="activity" id="' + this.id + '" value="' + this.fullName + '"/></td>\
                                                            <td>' + this.fullName + '</td>\
                                                            <td>' + this.email + '</td>\
                                                        <td>' + this.cellPhone + '</td>\
                                                    </tr>')
                            })
                        }
                    }
                })
            })
            //选择了一条联系人
            contactsTbody.on("click", "tr", function () {
                createContactsName.val($(this).attr("activityName"))
                createContactsName.attr('contactsId', this.id)
                findContacts.modal("hide")
            })

            //选择阶段事件
            createTransactionStage.change(() => {
                //获取下拉框 已选择的值
                $.ajax({
                    url: 'workbench/transaction/getPossibilityByStageValue',
                    data: {
                        stageValue: $("#create-transactionStage option:selected").text()
                    },
                    type: 'post',
                    datatype: 'json',
                    complete: false,
                    success(data) {
                        $("#create-possibility").val(data)
                    }
                })
            })

            //客户输入框内容改变事件
            createAccountName.keyup(() => {
                createAccountName.typeahead({
                    source: customerName
                })
            })

            //保存按钮单击事件
            $("#addContactsBtn").click(() => {
                let owner = $("#create-transactionOwner").val()
                let money = $("#create-amountOfMoney").val()
                let name = $("#create-transactionName").val()
                let expectedDate = $("#create-expectedClosingDate").val()
                let customerId = $("#create-accountName").val()
                let stage = $("#create-transactionStage").val()
                let type = $("#create-transactionType").val()
                let possibility = $("#create-possibility").val()
                let source = $("#create-clueSource").val()
                let activityId = $("#create-activitySrc").attr("activityId")
                let contactsId = $("#create-contactsName").attr("contactsId")
                let description = $("#create-describe").val()
                let contactSummary = $("#create-contactSummary").val()
                let nextContactTime = $("#create-nextContactTime").val()

                if (!name){
                    alert("名称不能为空")
                    return
                }
                if (!expectedDate){
                    alert("预计成交日期不能为空")
                    return
                }
                if (!customerId){
                    alert("客户名称不能为空")
                    return
                }
                if (!stage){
                    alert("阶段不能为空")
                    return
                }

                $.ajax({
                    url: 'workbench/transaction/insertTransaction',
                    data: {
                        owner: owner,
                        money: money,
                        name: name,
                        expectedDate: expectedDate,
                        customerId: customerId,
                        stage: stage,
                        type: type,
                        possibility: possibility,
                        source: source,
                        activityId: activityId,
                        contactsId: contactsId,
                        createBy: "${sessionScope.sessionUser.id}",
                        description: description,
                        contactSummary: contactSummary,
                        nextContactTime: nextContactTime
                    },
                    type: 'post',
                    datatype: 'json',
                    success(data) {
                        if (data.code == "1") {
                           location.href = "workbench/transaction/index"
                        }
                    }
                })
            })
        })
    </script>
</head>
<body>
<!-- 查找市场活动 -->
<div class="modal fade" id="findMarketActivity" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">查找市场活动</h4>
            </div>
            <div class="modal-body">
                <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                    <form class="form-inline" role="form">
                        <div class="form-group has-feedback">
                            <input id="activityInputName" type="text" class="form-control" style="width: 300px;"
                                   placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable3" class="table table-hover"
                       style="width: 900px; position: relative;top: 10px;">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td></td>
                        <td>名称</td>
                        <td>开始日期</td>
                        <td>结束日期</td>
                        <td>所有者</td>
                    </tr>
                    </thead>
                    <tbody id="activityTbody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- 查找联系人 -->
<div class="modal fade" id="findContacts" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">查找联系人</h4>
            </div>
            <div class="modal-body">
                <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                    <form class="form-inline" role="form">
                        <div class="form-group has-feedback">
                            <input id="contactsInputName" type="text" class="form-control" style="width: 300px;"
                                   placeholder="请输入联系人名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td></td>
                        <td>名称</td>
                        <td>邮箱</td>
                        <td>手机</td>
                    </tr>
                    </thead>
                    <tbody id="contactsTbody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%-- 标题--%>
<div style="position:  relative; left: 30px;">
    <h3>创建交易</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button id="addContactsBtn" type="button" class="btn btn-primary">保存</button>
        <button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form id="formAdd" class="form-horizontal" role="form" style="position: relative; top: -30px;">
    <div class="form-group">
        <label for="create-transactionOwner" class="col-sm-2 control-label">所有者
            <span style="font-size: 15px; color: red;">*</span>
        </label>
        <div class="col-sm-10" style="width: 300px;">
            <select class="form-control" id="create-transactionOwner">
                <c:forEach items="${userList}" var="user">
                    <option value="${user.id}">${user.name}</option>
                </c:forEach>
            </select>
        </div>
        <label for="create-amountOfMoney" class="col-sm-2 control-label">金额</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="number" class="form-control" id="create-amountOfMoney" oninput="value=value.replace(/[^\d]/g,'')">
        </div>
    </div>

    <div class="form-group">
        <label for="create-transactionName" class="col-sm-2 control-label">名称
            <span style="font-size: 15px; color: red;">*</span>
        </label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="create-transactionName">
        </div>
        <label for="create-expectedClosingDate" class="col-sm-2 control-label">预计成交日期
            <span style="font-size: 15px; color: red;">*</span>
        </label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control addDate" id="create-expectedClosingDate"
                   readonly style="background-color: #ffffff">
        </div>
    </div>

    <div class="form-group">
        <label for="create-accountName" class="col-sm-2 control-label">客户名称<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="create-accountName" placeholder="支持自动补全，输入客户不存在则新建"
                   autocomplete="off">
        </div>
        <label for="create-transactionStage" class="col-sm-2 control-label">阶段<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <select class="form-control" id="create-transactionStage">
                <option></option>
                <c:forEach items="${stageList}" var="stage">
                    <option value="${stage.id}">${stage.value}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="create-transactionType" class="col-sm-2 control-label">类型</label>
        <div class="col-sm-10" style="width: 300px;">
            <select class="form-control" id="create-transactionType">
                <option></option>
                <c:forEach items="${transactionTypeList}" var="transactionType">
                    <option value="${transactionType.id}">${transactionType.value}</option>
                </c:forEach>
            </select>
        </div>
        <label for="create-possibility" class="col-sm-2 control-label">可能性</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="create-possibility" disabled>
        </div>
    </div>

    <div class="form-group">
        <label for="create-clueSource" class="col-sm-2 control-label">来源</label>
        <div class="col-sm-10" style="width: 300px;">
            <select class="form-control" id="create-clueSource">
                <option></option>
                <c:forEach items="${sourceList}" var="source">
                    <option value="${source.id}">${source.value}</option>
                </c:forEach>
            </select>
        </div>
        <label for="create-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;
            <a id="findActivityBtn"><span class="glyphicon glyphicon-search"></span></a>
        </label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" activityId="" id="create-activitySrc" readonly
                   style="background-color: #ffffff">
        </div>
    </div>

    <div class="form-group">
        <label for="create-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;
            <a id="findContactsBtn"><span class="glyphicon glyphicon-search"></span></a>
        </label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" contactsId="" id="create-contactsName" readonly
                   style="background-color: #ffffff">
        </div>
    </div>

    <div class="form-group">
        <label for="create-describe" class="col-sm-2 control-label">描述</label>
        <div class="col-sm-10" style="width: 70%;">
            <textarea class="form-control" rows="3" id="create-describe"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
        <div class="col-sm-10" style="width: 70%;">
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
</form>
</body>
</html>