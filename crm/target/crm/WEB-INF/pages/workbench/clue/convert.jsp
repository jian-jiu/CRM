<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        $(() => {
            //线索id
            let clueId = $("#clueId")
            $("#isCreateTransaction").click(function () {
                if (this.checked) {
                    $("#create-transaction2").show(200);
                } else {
                    $("#create-transaction2").hide(200);
                }
            });
            //设置创建日期样式
            $(".addDate").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//选择器上能选择的最小日期
                initialDate: new Date(),//设置默认时间
                autoclose: true,//单击后是否关闭
                todayBtn: true,//每次打开是否显示当前时间
                clearBtn: true,//是否显示清空按钮
                container: "#addForm"
            })
            //搜索市场活动的模态窗口
            let searchActivityModal = $("#searchActivityModal")

            //市场活动
            let activity = $("#activity")

            //查询市场活动输入框
            let activityInputName = $("#activityInputName")
            //市场活动数据区
            let ActivityTbody = $("#ActivityTbody")
            //关联市场活动按钮单击事件
            $("#ActivityBtn").click(() => {
                activityInputName.val("")
                $.ajax({
                    url: "workbench/activity/findActivityForDetailSelectiveByNameAndContactsId",
                    data: {
                        contactsId: clueId.val()
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            // console.log(data.data)
                            ActivityTbody.empty()
                            $.each(data.data, function (index) {
                                ActivityTbody.append(
                                    '<tr class="' + (index % 2 == 0 ? "active" : "") + '">\
                                        <td><input type="radio" name="activity" id="' + this.id + '" value="' + this.name + '"/></td>\
                                        <td>' + this.name + '</td>\
                                        <td>' + this.startDate + '</td>\
                                        <td>' + this.endDate + '</td>\
                                        <td>' + this.owner + '</td>\
                                    </tr>')
                            })
                            searchActivityModal.modal("show")
                        }
                    }
                })
            })
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
                            ActivityTbody.empty()
                            $.each(data.data, function (index) {
                                ActivityTbody.append(
                                    '<tr class="' + (index % 2 == 0 ? "active" : "") + '">\
                                        <td><input type="radio" name="activity" id="' + this.id + '" value="' + this.name + '" /></td>\
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
            //选择了一条联系人
            ActivityTbody.on("click", "input[name='activity']", function () {
                activity.val(this.value)
                activity.attr('activityId', this.id)
                searchActivityModal.modal("hide")
            })
        });
    </script>
</head>
<body>
<!-- 搜索市场活动的模态窗口 -->
<div class="modal fade" id="searchActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">搜索市场活动</h4>
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
                <table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td></td>
                        <td>名称</td>
                        <td>开始日期</td>
                        <td>结束日期</td>
                        <td>所有者</td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody id="ActivityTbody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="title" class="page-header" style="position: relative; left: 20px;">
    <h4>转换线索 <small>${clue.fullName}-${clue.company}</small></h4>
    <input type="hidden" id="clueId" value="${clue.id}">
</div>
<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
    新建客户：${clue.company}
</div>
<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
    新建联系人：${clue.fullName}
</div>
<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
    <input type="checkbox" id="isCreateTransaction"/>
    为客户创建交易
</div>
<div id="create-transaction2"
     style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;">

    <form id="addForm">
        <div class="form-group" style="width: 400px; position: relative; left: 20px;">
            <label for="amountOfMoney">金额</label>
            <input type="text" class="form-control" id="amountOfMoney">
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="tradeName">交易名称</label>
            <input type="text" class="form-control" id="tradeName" value="简九-">
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="expectedClosingDate">预计成交日期</label>
            <input type="text" class="form-control addDate" id="expectedClosingDate"
                   readonly style="background-color: #ffffff">
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="stage">阶段</label>
            <select id="stage" class="form-control">
                <option></option>
                <c:forEach items="${stageList}" var="stage">
                    <option value="${stage.id}">${stage.value}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="activity">市场活动源&nbsp;&nbsp;
                <a id="ActivityBtn" style="text-decoration: none;">
                    <span class="glyphicon glyphicon-search"></span></a>
            </label>
            <input type="text" class="form-control" activityid="" id="activity" placeholder="点击上面搜索" readonly>
        </div>
    </form>

</div>

<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
    记录的所有者：<br>
    <b>${clue.owner}</b>
</div>
<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
    <input class="btn btn-primary" type="button" value="转换">
    &nbsp;&nbsp;&nbsp;&nbsp;
    <input onclick="window.history.back();" class="btn btn-default" type="button" value="取消">
</div>
</body>
</html>