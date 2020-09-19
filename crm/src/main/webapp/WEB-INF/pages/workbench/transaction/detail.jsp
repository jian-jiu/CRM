<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <style type="text/css">
        .mystage {
            font-size: 20px;
            vertical-align: middle;
            cursor: pointer;
        }

        .closingDate {
            font-size: 15px;
            cursor: pointer;
            vertical-align: middle;
        }
    </style>
    <script type="text/javascript">
        //默认情况下取消和保存按钮是隐藏的
        let cancelAndSaveBtnDefault = true;
        $(() => {
            console.log('${stageList}')

            findTransactionHistory()
            let transactionId = $("#transactionId")
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
            $("#transactionRemarkDiv").on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            }).on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            }).on("mouseover", ".myHref", function () {
                $(this).children("span").css("color", "red");
            }).on("mouseout", ".myHref", function () {
                $(this).children("span").css("color", "#E6E6E6");
            })

            //阶段提示框
            $(".mystage").popover({
                trigger: 'manual',
                placement: 'bottom',
                html: 'true',
                animation: false
            }).on("mouseenter", function () {
                let _this = this;
                $(this).popover("show");
                $(this).siblings(".popover").on("mouseleave", function () {
                    $(_this).popover('hide');
                });
            }).on("mouseleave", function () {
                let _this = this;
                setTimeout(function () {
                    if (!$(".popover:hover").length) {
                        $(_this).popover("hide")
                    }
                }, 100);
            });

            //添加线索备注按钮
            let addTransactionRemarkBtn = $("#addTransactionRemarkBtn")
            //确认修改按钮点击事件
            let updateRemarkBtn = $("#updateRemarkBtn")
            //修改线索备注模态窗口
            let editRemarkModal = $("#editRemarkModal")
            //添加线索备注点击按钮
            addTransactionRemarkBtn.click(() => {
                let noteContent = remark.val()
                let id = transactionId.val()
                if (!noteContent) {
                    alert("备注信息不能为空")
                    return
                }
                $.ajax({
                    url: "workbench/transaction/addTransactionRemark",
                    data: {
                        tranId: id,
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
                                    <font color="gray">交易</font> <font color="gray">-</font> <b>' + data.data.createBy + '</b>\
                                    <small style="color: gray;">' + data.data.createTime + ' 由 ${sessionScope.sessionUser.name} 创建</small>\
                                        <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">\
                                            <a class="myHref" onclick="modifyTransactionRemark(\'' + data.data.id + '\')">\
                                            <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                            &nbsp;&nbsp;&nbsp;&nbsp;\
                                            <a class="myHref" onclick="removeTransactionRemark(\'' + data.data.id + '\')">\
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
                    url: "workbench/transaction/modifyTransactionRemark",
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
                                <font color="gray">交易</font> <font color="gray">-</font> <b>' + data.data.editBy + '</b>\
                                <small style="color: gray;">' + data.data.editTime + ' 由 ${sessionScope.sessionUser.name} 修改</small>\
                                    <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">\
                                    <a class="myHref" onclick="modifyTransactionRemark(\'' + data.data.id + '\')">\
                                    <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                    &nbsp;&nbsp;&nbsp;&nbsp;\
                                    <a class="myHref" onclick="removeTransactionRemark(\'' + data.data.id + '\')">\
                                    <span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>\
                                    </div>\
                                </div>')
                            editRemarkModal.modal("hide")
                        }
                    }
                })
            })

            $("#stageDiv").on("click", "span", function () {
                let stageId = $(this).attr("stageId")
                if (stageId) {
                    $.ajax({
                        url: 'workbench/transaction/updateTransactionStage',
                        data: {
                            id: transactionId.val(),
                            stage: stageId,
                            money: '${transaction.money}',
                            expectedDate: '${transaction.expectedDate}',
                            createBy: '${sessionScope.sessionUser.id}'
                        },
                        type: 'post',
                        datatype: 'json',
                        success(data) {
                            location.href = 'workbench/transaction/findTransactionForDetailByPrimaryKeyToDetail?id=' + transactionId.val()
                        }
                    })
                }
            })
        });

        //查询交易历史记录
        function findTransactionHistory() {
            $.ajax({
                url: 'workbench/transaction/findTransactionHistoryForDetailByTranId',
                data: {
                    tranId: $("#transactionId").val()
                },
                type: 'post',
                datatype: 'json',
                success(data) {
                    // console.log(data)
                    let html = []
                    $(data).each(function () {
                        html.push('<tr>\
                                    <td>' + this.stage + '</td>\
                                    <td>' + this.money + '</td>\
                                    <td>' + getPossibilityByStageValue(this.stage) + '</td>\
                                    <td>' + this.expectedDate + '</td>\
                                    <td>' + this.createTime + '</td>\
                                    <td>' + this.createBy + '</td>\
                                </tr>')
                    })
                    $("#transactionHistoryTbody").html(html)
                }
            })
        }

        //修改线索备注函数
        function modifyTransactionRemark(id) {
            $.ajax({
                url: "workbench/transaction/findTransactionRemarkById",
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
        function removeTransactionRemark(id) {
            $.ajax({
                url: "workbench/transaction/removeTransactionRemarkById",
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
        <span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span>
    </a>
</div>
<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>${transaction.name} <small>￥${transaction.money}</small></h3>
        <input type="hidden" id="transactionId" value="${transaction.id}">
    </div>
</div>
<br/>
<br/>
<br/>
<!-- 阶段状态 -->
<div id="stageDiv" style="position: relative; left: 40px; top: -50px;">
    阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <c:forEach items="${stageList}" var="stage" varStatus="index">
        <c:if test="${index.count == fn:length(stageList) || index.count == fn:length(stageList) - 1}">
            <c:if test="${transaction.stage == stage.value}">
                <span class="glyphicon glyphicon-remove mystage" data-toggle="popover"
                      data-placement="bottom" data-content="${stage.value}" style="color: #ff0000;"></span>
                -----------
            </c:if>
            <c:if test="${transaction.stage != stage.value}">
                <span stageId="${stage.id}" class="glyphicon glyphicon-remove mystage" data-toggle="popover"
                      data-placement="bottom" data-content="${stage.value}"></span>
                -----------
            </c:if>
        </c:if>

        <c:if test="${index.count <= fn:length(stageList) - 2 }">
            <c:if test="${transaction.orderNo < stage.orderNo}">
                <span stageId="${stage.id}" class="glyphicon glyphicon-record mystage" data-toggle="popover"
                      data-placement="bottom" data-content="${stage.value}"></span>
                -------------
            </c:if>
            <c:if test="${transaction.stage == stage.value}">
                <span class="glyphicon glyphicon-map-marker mystage" data-toggle="popover"
                      data-placement="bottom" data-content="${stage.value}" style="color: #90F790;"></span>
                -------------
            </c:if>
            <c:if test="${transaction.orderNo > stage.orderNo}">
                <span stageId="${stage.id}" class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover"
                      data-placement="bottom"
                      data-content="${stage.value}" ${transaction.orderNo > fn:length(stageList) -2 ?'':'style="color: #90F790;"'}></span>
                -------------
            </c:if>
        </c:if>
    </c:forEach>
    <%--<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom"
          data-content="资质审查" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom"
          data-content="需求分析" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom"
          data-content="价值建议" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom"
          data-content="确定决策者" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-map-marker mystage" data-toggle="popover" data-placement="bottom"
          data-content="提案/报价" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom"
          data-content="谈判/复审"></span>
    -----------
    <span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom"
          data-content="成交"></span>
    -----------
    <span class="glyphicon glyphicon-thumbs-up mystage" data-toggle="popover" data-placement="bottom"
          data-content="丢失的线索"></span>
    -----------
    <span class="glyphicon glyphicon-thumbs-down mystage" data-toggle="popover" data-placement="bottom"
          data-content="因竞争丢失关闭"></span>
    -------------%>
    <span class="closingDate">${transaction.expectedDate}</span>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: 0px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${transaction.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">金额</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${transaction.money}&nbsp;</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${transaction.name}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">预计成交日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${transaction.expectedDate}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">客户名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${transaction.customerId}&nbsp;</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">阶段</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${transaction.stage}&nbsp;</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">类型</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${transaction.type}&nbsp;</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">可能性</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;">
            <b>${transaction.possibility}&nbsp;</b>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">来源</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${transaction.source}&nbsp;</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">市场活动源</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${transaction.activityId}&nbsp;</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">联系人名称</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${transaction.contactsId}&nbsp;</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${transaction.createBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${transaction.createTime}&nbsp;</small>
        </div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 70px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${transaction.editBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${transaction.editTime}</small></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 80px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${transaction.description}&nbsp;
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 90px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${transaction.contactSummary}&nbsp;
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 100px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${transaction.nextContactTime}&nbsp;</b></div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div id="transactionRemarkDiv" style="position: relative; top: 100px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>
    <c:forEach items="${transactionRemarkList}" var="transactionRemark">
        <div id="${transactionRemark.id}" class="remarkDiv" style="height: 60px;">
            <img title="${transactionRemark.createBy}" src="static/image/QQ.jpg" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5>${transactionRemark.noteContent}</h5>
                <font color="gray">交易</font> <font color="gray">-</font> <b>${transaction.name}</b>
                <small style="color: gray;">${transactionRemark.editFlag=="1"?transactionRemark.editTime:transactionRemark.createTime}
                    由 ${transactionRemark.editFlag=="1"?transactionRemark.editBy:transactionRemark.createBy}
                        ${transactionRemark.editFlag=="1"?"修改":"创建"}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" onclick="modifyTransactionRemark('${transactionRemark.id}')">
                        <span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span>
                    </a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" onclick="removeTransactionRemark('${transactionRemark.id}')">
                        <span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span>
                    </a>
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
                <button id="addTransactionRemarkBtn" type="button" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>

<!-- 阶段历史 -->
<div>
    <div style="position: relative; top: 100px; left: 40px;">
        <div class="page-header">
            <h4>阶段历史</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table id="activityTable" class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>阶段</td>
                    <td>金额</td>
                    <td>可能性</td>
                    <td>预计成交日期</td>
                    <td>创建时间</td>
                    <td>创建人</td>
                </tr>
                </thead>
                <tbody id="transactionHistoryTbody">
                <tr>
                    <td>资质审查</td>
                    <td>5,000</td>
                    <td>10</td>
                    <td>2017-02-07</td>
                    <td>2016-10-10 10:10:10</td>
                    <td>zhangsan</td>
                </tr>
                <tr>
                    <td>需求分析</td>
                    <td>5,000</td>
                    <td>20</td>
                    <td>2017-02-07</td>
                    <td>2016-10-20 10:10:10</td>
                    <td>zhangsan</td>
                </tr>
                <tr>
                    <td>谈判/复审</td>
                    <td>5,000</td>
                    <td>90</td>
                    <td>2017-02-07</td>
                    <td>2017-02-09 10:10:10</td>
                    <td>zhangsan</td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>