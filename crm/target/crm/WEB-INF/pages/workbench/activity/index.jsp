<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html style="height: 87%;width: 99%">
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        //分页查询
        function queryActivityForPageByCondition(pageNo, pageSize) {
            //窗口加载完毕，收集数据
            let name = $("#query-name").val();
            let owner = $("#query-owner").val();
            let startDate = $("#query-startDate").val();
            let endDate = $("#query-endDate").val();
            //发送请求
            $.post("workbench/activity/queryActivityForPageByCondition", {
                pageNo: pageNo,
                pageSize: pageSize,
                name: name,
                owner: owner,
                startDate: startDate,
                endDate: endDate
            }, (data) => {
                if (data.code == "1") {
                    //显示总条数，功能被取代
                    // $("#totalRowsB").text(data.totalRows)
                    //遍历activitiesList显示数据
                    let htmlStr = [];
                    $.each(data.data.activitiesList, (index, object) => {
                        htmlStr += "<tr class=" + (index % 2 == 0 ? "active" : "") + " > "
                        htmlStr += "<td><input type=\"checkbox\" value=\"" + object.id + "\"/></td>"
                        htmlStr += "<td><a style='text-decoration: none; cursor: pointer;' onclick=\"window.location.href='workbench/activity/queryActivityToDataId?id=" + object.id + "'\">" + object.name + "</a></td>"
                        htmlStr += "<td>" + object.owner + "</td>"
                        htmlStr += "<td>" + object.startDate + "</td>"
                        htmlStr += "<td>" + object.endDate + "</td>"
                        htmlStr += "</tr>"
                    })
                    //把htmlStr追加在tbody
                    $("#tBody").html(htmlStr)

                    $("#checkAll").prop("checked", false)

                    let totalPages = 0;
                    if (data.data.totalRows % pageSize == 0) {
                        totalPages = data.data.totalRows / pageSize
                    } else {
                        totalPages = parseInt(data.data.totalRows / pageSize) + 1
                    }
                    $("#demo_pag1").bs_pagination({
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
                            queryActivityForPageByCondition(pageObj.currentPage, pageObj.rowsPerPage)
                        }
                    })
                }
            }, "json")
        }

        //窗口加载完毕
        $(() => {
            //窗口加载完毕获取数据
            queryActivityForPageByCondition(1, 10)
            //设置创建日期样式
            $(".upDate").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//选择器上能选择的最小日期
                initialDate: new Date(),//设置默认时间
                autoclose: true,//单击后是否关闭
                todayBtn: true,//每次打开是否显示当前时间
                clearBtn: true,//是否显示清空按钮
                container: '#createActivityModal'
            })
            //设置查询日期样式
            $(".queryDate").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//选择器上能选择的最小日期
                initialDate: new Date(),//设置默认时间
                autoclose: true,//单击后是否关闭
                todayBtn: true,//每次打开是否显示当前时间
                clearBtn: true,//是否显示清空按钮
                container: '#queryView'
            })
            //设置编辑日期样式
            $(".editDate").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//选择器上能选择的最小日期
                initialDate: new Date(),//设置默认时间
                autoclose: true,//单击后是否关闭
                todayBtn: true,//每次打开是否显示当前时间
                clearBtn: true,//是否显示清空按钮
                container: '#editActivityModal'
            })

            //全选按钮
            let checkAll = $("#checkAll")
            //给全选按钮添加事件
            checkAll.click(() => {
                $("#tBody input[type='checkbox']").prop("checked", checkAll.prop("checked"))
            })
            //给其他复选框添加事件
            $("#tBody").on("click", "input[type='checkbox']", () => {
                //获取总的复选框和选中的复选框进行对比
                if ($("#tBody input[type='checkbox']").size() == $("#tBody input[type='checkbox']:checked").size()) {
                    checkAll.prop("checked", true)
                } else {
                    checkAll.prop("checked", false)
                }
            })

            //分页容器
            let demo = $("#demo_pag1")

            //模态窗口对象
            let createActivityModal = $("#createActivityModal")
            let editActivityModal = $("#editActivityModal")
            let importActivityModal = $("#importActivityModal")

            //确定保存按钮
            let saveCreateActivityBtn = $("#saveCreateActivityBtn")
            //确定修改按钮
            let updateActivityBtn = $("#updateActivityBtn")
            //查询按钮
            let queryActivityBtn = $("#queryActivityBtn")

            //给查询按钮添加单击事件
            queryActivityBtn.click(() => {
                queryActivityForPageByCondition(1, demo.bs_pagination('getOption', 'rowsPerPage'))
            })

            //创建_所有者
            let marketActivityOwner = $("#create-marketActivityOwner")
            //创建_描述
            let marketDescription = $("#create-description")
            //给创建按钮添加单击事件
            $("#createActivityBtn").click(() => {
                //重置表单
                $("#activityForm")[0].reset()
                marketActivityOwner.val("${sessionScope.sessionUser.id}")
                //显示创建市场活动的模态窗口
                $("#createActivityModal").modal("show")
            })
            //给保存按钮添加单击事件
            saveCreateActivityBtn.click(() => {
                //收集参数
                let owner = marketActivityOwner.val();
                let name = $.trim($("#create-marketActivityName").val());
                let startDate = $("#create-startDate").val();
                let endDate = $("#create-endDate").val();
                let cost = $.trim($("#create-cost").val());
                let description = $.trim(marketDescription.val());
                //判断参数
                if (!owner) {
                    alert("所有者不能为空")
                    return
                }
                if (!name) {
                    alert("名称不能为空")
                    return
                }
                if (!cost) {
                    alert("成本不能为空")
                    return;
                }
                if (startDate != "" && endDate != "") {
                    //比较日期大小
                    if (startDate > endDate) {
                        alert("开始日期不能比结束日期大")
                        return;
                    }
                }
                //发送请求
                $.post("workbench/activity/saveCreateActivity", {
                    owner: owner,
                    name: name,
                    startDate: startDate,
                    endDate: endDate,
                    cost: cost,
                    description: description
                }, (data) => {
                    if (data.code == "1") {
                        createActivityModal.modal("hide")
                        queryActivityForPageByCondition(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                    }
                }, "json")
            });

            //编辑窗口组件对象
            let editId = $("#edit-id")
            let editMarketActivityOwner = $("#edit-marketActivityOwner")
            let editMarketActivityName = $("#edit-marketActivityName")
            let editStartTime = $("#edit-startTime")
            let editEndTime = $("#edit-endTime")
            let editCost = $("#edit-cost")
            let editDescribe = $("#edit-describe")

            //给修改按钮添加单击事件
            $("#editActivityBtn").click(() => {
                let chkedIds = $("#tBody input[type='checkbox']:checked")
                //判断数据
                if (chkedIds.size() < 1) {
                    alert("请选择一个需要修改的数据")
                    return
                }
                if (chkedIds.size() > 1) {
                    alert("只能选择一个数据进行修改")
                    return
                }
                let id = chkedIds[0].value;
                //发送请求
                $.post("workbench/activity/editActivity", {id: id}, (data) => {
                    if (data.code == "1") {
                        editId.val(data.data.id)
                        //给下拉框设置选择的
                        editMarketActivityOwner.val(data.data.owner)
                        editMarketActivityName.val(data.data.name)
                        editStartTime.val(data.data.startDate)
                        editEndTime.val(data.data.endDate)
                        editCost.val(data.data.cost)
                        editDescribe.val(data.data.name)
                        //显示修改市场活动的模态窗口
                        editActivityModal.modal("show")
                    }
                }, "json")
            })
            //确定修改按钮
            updateActivityBtn.click(() => {
                //收集参数
                let id = editId.val()
                let owner = editMarketActivityOwner.val()
                let name = $.trim(editMarketActivityName.val())
                let startDate = editStartTime.val()
                let endDate = editEndTime.val()
                let cost = $.trim(editCost.val())
                let description = $.trim(editDescribe.val())
                //判断参数
                if (!owner) {
                    alert("所有者不能为空")
                    return
                }
                if (!name) {
                    alert("名称不能为空")
                    return;
                }
                if (!cost) {
                    alert("成本不能为空")
                    return;
                }
                if (startDate != "" && endDate != "") {
                    //比较日期大小
                    if (startDate > endDate) {
                        alert("开始日期不能比结束日期大")
                        return;
                    }
                }
                $.post("workbench/activity/updateActivityById", {
                        id: id, owner: owner, name: name, startDate: startDate,
                        endDate: endDate, cost: cost, description: description
                    }, (data) => {
                        if (data.code == "1") {
                            queryActivityForPageByCondition($("#demo_pag1").bs_pagination('getOption', 'currentPage'), $("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'))
                            editActivityModal.modal('hide')
                        }
                    },
                    'json'
                )
            })

            //回车事件
            $(window).keydown(e => {
                if (e.key == "Enter") {
                    //判断是否在创建市场活动界面
                    if (!createActivityModal.is(":hidden")) {
                        if (!(marketDescription[0] == document.activeElement)) {
                            //确定添加市场活动
                            saveCreateActivityBtn.click()
                        }
                    } else if (!editActivityModal.is(":hidden")) {
                        if (!(editDescribe[0] == document.activeElement)) {
                            //确定修改市场活动
                            updateActivityBtn.click()
                        }
                    } else {
                        //确定查询市场活动
                        queryActivityBtn.click()
                    }
                }
            })

            //给删除按钮添加事件
            $("#deleteActivityBtn").click(() => {
                let checkId = $("#tBody input[type='checkbox']:checked")
                if (checkId.size() < 1) {
                    alert("每次至少删除一条数据")
                    return;
                }
                let ids = ""
                $.each(checkId, (index, object) => {
                    ids += "ids=" + object.value + "&"
                })
                ids = ids.substr(0, ids.length - 1)
                if (!confirm("确认删除吗？")) return
                $.post("workbench/activity/removeActivityByIds", ids, (data) => {
                    if (data.code == "1") {
                        queryActivityForPageByCondition(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                    }
                }, 'json')
            })

            //批量导出市场活动
            $("#exportActivityAllBtn").click(() => {
                location.href = "workbench/activity/downloadsActivity"
            })
            //选择导出市场活动
            $("#exportActivityXzBtn").click(() => {
                let checkId = $("#tBody input[type='checkbox']:checked")
                if (checkId.size() < 1) {
                    alert("每次至少导出一条数据")
                    return;
                }
                let ids = ""
                $.each(checkId, (index, object) => {
                    ids += "ids=" + object.value + "&"
                })
                ids = ids.substr(0, ids.length - 1)
                location.href = "workbench/activity/downloadsActivityByIds?" + ids
            })
            //点击导出市场活动
            $("#importActivityBtnView").click(() => {
                //清空选中文件
                $("#activityFile")[0].value = ""
                importActivityModal.modal("show")
            })
            //导入市场活动
            $("#importActivityBtn").click(() => {
                // alert($("#activityFile")[0])
                let activityFile = $("#activityFile")[0].files[0]
                if (activityFile.size > 1024 * 1024 * 5) {
                    alert("文件大小不能超过5MB")
                    return
                }
                let formData = new FormData()
                formData.append("activityFile", activityFile)
                $.ajax({
                    url: "workbench/activity/fileupload",
                    data: formData,
                    type: 'post',
                    dataType: 'json',
                    contentType: false,
                    processData: false,
                    success(data) {
                        if (data.code == "1") {
                            importActivityModal.modal("hide")
                            queryActivityForPageByCondition(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                            alert("成功导入" + data.data + "条记录")
                        }
                    }
                })
            })
        })

        //判断文件后缀
        function filterFile(fileObj) {
            //允许上传文件的后缀名document.getElementById("hfAllowPicSuffix").value;
            let allowExtention = ".xls,.xlsx";

            let extention = fileObj.value.substring(fileObj.value.lastIndexOf(".") + 1).toLowerCase();

            let browserVersion = window.navigator.userAgent.toUpperCase();

            if (!(allowExtention.indexOf(extention) > -1)) {
                alert("仅支持" + allowExtention + "为后缀名的文件!");
                fileObj.value = ""; //清空选中文件
                if (browserVersion.indexOf("MSIE") > -1) {
                    fileObj.select();
                    document.selection.clear();
                }
                fileObj.outerHTML = fileObj.outerHTML;
            }
        }
    </script>
</head>
<body>
<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="activityForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者
                            <span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称
                            <span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startDate" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control upDate" id="create-startDate" readonly
                                   style="background-color: #ffffff">
                        </div>
                        <label for="create-endDate" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control upDate" id="create-endDate" readonly
                                   style="background-color: #ffffff">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本
                            <span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input id="create-cost" type="number" min="0" class="form-control"
                                   oninput="value=value.replace(/[^\d]/g,'')">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-description" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="saveCreateActivityBtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">
                    <input type="hidden" id="edit-id">
                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者
                            <span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称
                            <span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control editDate" id="edit-startTime" readonly
                                   style="background-color: #ffffff">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control editDate" id="edit-endTime" readonly
                                   style="background-color: #ffffff">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本
                            <span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="number" class="form-control" id="edit-cost">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateActivityBtn" type="button" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 导入市场活动的模态窗口 -->
<div class="modal fade" id="importActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：<small style="color: gray;">[仅支持.xls或.xlsx格式]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input id="activityFile" type="file" name="myFile" onchange="filterFile(this)">
                </div>
                <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;">
                    <h3>重要提示</h3>
                    <ul>
                        <li>操作仅针对Excel，仅支持后缀名为XLS/XLSX的文件。</li>
                        <li>给定文件的第一行将视为字段名。</li>
                        <li>请确认您的文件大小不超过5MB。</li>
                        <li>日期值以文本形式保存，必须符合yyyy-MM-dd格式。</li>
                        <li>日期时间以文本形式保存，必须符合yyyy-MM-dd HH:mm:ss的格式。</li>
                        <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                        <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button id="closeActivityBtn" type="button" class="btn btn-default">关闭</button>
                <button id="importActivityBtn" type="button" class="btn btn-primary">导入</button>
            </div>
        </div>
    </div>
</div>
<%--标题--%>
<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<%-- 数据区--%>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">
        <%-- 查询列表--%>
        <div id="queryView" class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input id="query-name" class="form-control" type="text">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <%--                        <input id="query-owner" class="form-control" type="text">--%>
                        <select class="form-control" id="query-owner" style="width: 196px   ;">
                            <option></option>
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.name}">${user.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control queryDate" type="text" id="query-startDate" readonly
                               style="background-color: #ffffff">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control queryDate" type="text" id="query-endDate" readonly
                               style="background-color: #ffffff">
                    </div>
                </div>
                <button id="queryActivityBtn" type="button" class="btn btn-default" style="background-color: #74a4ce;">
                    <span style="color: #ffffff">查询</span></button>
            </form>
        </div>
        <%-- 编辑列表--%>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="createActivityBtn" type="button" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button id="editActivityBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button id="deleteActivityBtn" type="button" class="btn btn-danger"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="importActivityBtnView" type="button" class="btn btn-default">
                    <span class="glyphicon glyphicon-import"></span> 上传列表数据（导入）
                </button>
                <button id="exportActivityAllBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（批量导出）
                </button>
                <button id="exportActivityXzBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（选择导出）
                </button>
            </div>
        </div>
        <%-- 数据列表--%>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="checkAll" type="checkbox"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="tBody">
                </tbody>
            </table>
            <div id="demo_pag1"></div>
        </div>
    </div>
</div>
</div>
</body>
</html>