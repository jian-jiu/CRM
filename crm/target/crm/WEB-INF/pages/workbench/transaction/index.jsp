<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        function findTransaction(pageNo, pageSize) {
            let owner = $("#find-owner").val()
            let name = $("#find-name").val()
            let customerId = $("#find-customerName").val()
            let stage = $("#find-stage").val()
            let type = $("#find-transactionType").val()
            let source = $("#find-clueSource").val()
            let contactsId = $("#find-contactsName").val()

            $.ajax({
                url: 'workbench/transaction/findPagingForDetail',
                data: {
                    pageNo: pageNo,
                    pageSize: pageSize,
                    owner: owner,
                    name: name,
                    customerId: customerId,
                    stage: stage,
                    type: type,
                    source: source,
                    contactsId: contactsId
                },
                type: 'post',
                datatype: 'json',
                success(data) {
                    // console.log(data.data.transactionList)
                    let html = []
                    $(data.data.transactionList).each(function () {
                        html.push('<tr>\
                                        <td><input value="' + this.id + '" type="checkbox"/></td>\
                                            <td><a style="text-decoration: none; cursor: pointer;"onclick="">' + this.name + '</a></td>\
                                        <td>' + this.customerId + '</td>\
                                        <td>' + this.stage + '</td>\
                                        <td>' + (this.type || "") + '</td>\
                                            <td>' + this.owner + '</td>\
                                        <td>' + (this.source || "") + '</td>\
                                        <td>' + (this.contactsId || "") + '</td>\
                                    </tr>')
                    })
                    $("#transactionTbody").html(html)

                    //设置全选择按钮不选中
                    $("#allCheckbox").prop("checked", false)

                    //分页插件
                    let totalPages = 0;
                    if (data.data.totalRows % pageSize == 0) {
                        totalPages = data.data.totalRows / pageSize
                    } else {
                        totalPages = parseInt(data.data.totalRows / pageSize) + 1
                    }
                    $("#demo_pag").bs_pagination({
                        currentPage: pageNo,//当前页
                        rowsPerPage: pageSize,//每有显示条数
                        totalRows: data.data.totalRows,//总条数
                        totalPages: totalPages,//总页数

                        visiblePageLinks: 5,//显示的翻页卡片数

                        showGoToPage: true,//是否显示“跳转到第几页”
                        showRowsPerPage: true,//是否显示“每页显示条数”
                        showRowsInfo: true,//是否显示记录的信息

                        //每次切换页号对会触发函数，函数那返回切换后的页号和每页显示条数
                        onChangePage: (e, pageObj) => {
                            findTransaction(pageObj.currentPage, pageObj.rowsPerPage)
                        }
                    })
                }
            })
        }

        $(() => {
            findTransaction(1, 10)

            //分页容器
            let demo = $("#demo_pag")

            //页面创建点击事件
            $("#addTransactionBtn").click(() => {
                location.href = "workbench/transaction/saveIndex"
            })

            //全选按钮
            let allCheckbox = $("#allCheckbox")
            //全选事件
            allCheckbox.click(() => {
                $("#transactionTbody input[type='checkbox']").prop("checked", allCheckbox.prop("checked"))
            })
            //绑定其他复选框事件
            $("#transactionTbody").on("click", "input[type='checkbox']", () => {
                if ($("#transactionTbody input[type='checkbox']").size() == $("#transactionTbody input[type='checkbox']:checked").size()) {
                    allCheckbox.prop("checked", true)
                } else {
                    allCheckbox.prop("checked", false)
                }
            })

            $("#findBtn").click(() => {
                findTransaction(1, demo.bs_pagination('getOption', 'rowsPerPage'))
            })

            //点击删除按钮
            $("#removeBtn").click(() => {
                let allChecked = $("#transactionTbody input[type='checkbox']:checked");
                if (allChecked.size() < 1) {
                    alert("请选择一条要删除的线索")
                    return
                }
                let ids = ""
                $.each(allChecked, (index, object) => {
                    ids += "ids=" + object.value + "&"
                })
                ids = ids.substr(0, ids.length - 1)
                if (!confirm("确认删除吗")) return;
                $.ajax({
                    url: "workbench/transaction/removeTransactionByPrimaryKeys?" + ids,
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == 1) {
                            findTransaction(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                        }
                    }

                })
            })
        });
    </script>
</head>
<body>
<%-- 标题--%>
<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>交易列表</h3>
        </div>
    </div>
</div>
<%-- 内容--%>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">
        <%-- 搜索列表--%>
        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <%--                        <input class="form-control" type="text">--%>
                        <select class="form-control" id="find-owner" style="width: 196px">
                            <option></option>
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" id="find-name" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">客户名称</div>
                        <%--                        <input class="form-control" type="text">--%>
                        <select class="form-control" id="find-customerName" style="width: 196px">
                            <option></option>
                            <c:forEach items="${customerList}" var="customer">
                                <option value="${customer.id}">${customer.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <br>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon" style="width: 67px;">阶段</div>
                        <select class="form-control" id="find-stage" style="width: 196px">
                            <option></option>
                            <c:forEach items="${stageList}" var="stage">
                                <option value="${stage.id}">${stage.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">类型</div>
                        <select class="form-control" id="find-transactionType" style="width: 196px">
                            <option></option>
                            <<c:forEach items="${transactionTypeList}" var="transactionType">
                            <option value="${transactionType.id}">${transactionType.value}</option>
                        </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon" style="width: 81px">来源</div>
                        <select class="form-control" id="find-clueSource" style="width: 196px">
                            <option></option>
                            <<c:forEach items="${sourceList}" var="source">
                            <option value="${source.id}">${source.value}</option>
                        </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">联系人名称</div>
                        <%--                        <input class="form-control" type="text">--%>
                        <select class="form-control" id="find-contactsName" style="width: 196px">
                            <option></option>
                            <c:forEach items="${contactsList}" var="contacts">
                                <option value="${contacts.id}">${contacts.fullName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <button id="findBtn" type="button" class="btn btn-default" style="background-color: #74a4ce;"><span
                        style="color: #ffffff">查询</span></button>

            </form>
        </div>
        <%-- 操作列表--%>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="addTransactionBtn" type="button" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default">
                    <span class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button id="removeBtn" type="button" class="btn btn-danger">
                    <span class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>
        </div>
        <%-- 数据区--%>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="allCheckbox" type="checkbox"/></td>
                    <td>名称</td>
                    <td>客户名称</td>
                    <td>阶段</td>
                    <td>类型</td>
                    <td>所有者</td>
                    <td>来源</td>
                    <td>联系人名称</td>
                </tr>
                </thead>
                <tbody id="transactionTbody">
                </tbody>
            </table>
            <div id="demo_pag"></div>
        </div>
    </div>
</div>
</body>
</html>