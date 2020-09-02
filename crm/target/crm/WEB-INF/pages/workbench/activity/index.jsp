<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html style="height: 87%;width: 99%">
<head>
    <%@include file="../../../HeadPart.jsp" %>
    <link rel="stylesheet" type="text/css"
          href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css"/>
    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css">

    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/localization/en.min.js"></script>
    <script type="text/javascript">
        //分页查询
        function queryActivityForPageByCondition(pageNo, pageSize) {
            //窗口加载完毕，收集数据
            let name = $("#query-name").val();
            let owner = $("#query-owner").val();
            let startDate = $("#query-startDate").val();
            let endDate = $("#query-endDate").val();
            //发送请求
            $.ajax({
                url: 'workbench/activity/queryActivityForPageByCondition.do',
                data: {
                    pageNo: pageNo,
                    pageSize: pageSize,
                    name: name,
                    owner: owner,
                    startDate: startDate,
                    endDate: endDate
                },
                type: 'post',
                dataType: 'json',
                success(data) {
                    //显示总条数，功能被取代
                    // $("#totalRowsB").text(data.totalRows)
                    //遍历activitiesList显示数据
                    var htmlStr = ""
                    $.each(data.activitiesList, (index, object) => {
                        htmlStr += "<tr class=\"active\">"
                        htmlStr += "<td><input type=\"checkbox\" value=\"" + object.id + "\"/></td>"
                        htmlStr += "<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='detail.html';\">" + object.name + "</a></td>"
                        htmlStr += "<td>" + object.owner + "</td>"
                        htmlStr += "<td>" + object.startDate + "</td>"
                        htmlStr += "<td>" + object.endDate + "</td>"
                        htmlStr += "</tr>"
                    })
                    //把htmlStr追加在tbody
                    $("#tBody").html(htmlStr)

                    //给所有的复选框添加单击事件
                    $("#tBody input[type='checkbox']").click(() => {
                        //获取总的复选框和选中的复选框进行对比
                        if ($("#tBody input[type='checkbox']").size() == $("#tBody input[type='checkbox']:checked").size()) {
                            $("#checkAll").prop("checked", true)
                        } else {
                            $("#checkAll").prop("checked", false)
                        }
                    })

                    $("#checkAll").prop("checked", false)

                    var totalPages = 0

                    if (data.totalRows % pageSize == 0) {
                        totalPages = data.totalRows / pageSize
                    } else {
                        totalPages = parseInt(data.totalRows / pageSize) + 1
                    }

                    $("#demo_pag1").bs_pagination({
                        currentPage: pageNo,//当前页
                        rowsPerPage: pageSize,//每有显示条数
                        totalRows: data.totalRows,//总条数
                        totalPages: totalPages,//总页数

                        visiblePageLinks: 5,//显示的翻页卡片数

                        showGoToPage: true,//是否显示“跳转到第几页”
                        showRowsPerPage: true,//是否显示“每页显示条数”
                        showRowsInfo: true,//是否显示记录的信息

                        //每次切换页号对会触发函数，函数那返回切换后的页号和每页显示条数
                        onChangePage: (e, pageObj) => {
                            queryActivityForPageByCondition(pageObj.currentPage, pageObj.rowsPerPage)
                        },
                    })
                }
            })
        }

        //窗口加载完毕
        $(function () {
            //窗口加载完毕获取数据
            queryActivityForPageByCondition(1, 10)

            //回车事件
            $(window).keydown(e => {
                if (e.key == "Enter") {
                    if (!$("#createActivityModal").is(":hidden")) {
                        $("#saveCreateActivityBtn").click()
                    }
                }
            })

            //给创建按钮添加单击事件
            $("#createActivityBtn").click(() => {
                //重置表单
                $("#activityForm")[0].reset()
                //显示创建市场活动的模态窗口
                $("#createActivityModal").modal("show")
            })

            //给保存按钮添加单击事件
            $("#saveCreateActivityBtn").click(() => {
                //收集参数
                let owner = $("#create-marketActivityOwner").val();
                let name = $.trim($("#create-marketActivityName").val());
                let startDate = $("#create-startDate").val();
                let endDate = $("#create-endDate").val();
                let cost = $.trim($("#create-cost").val());
                let description = $.trim($("#create-description").val());
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
                $.ajax({
                    url: 'workbench/activity/saveCreateActivity.do',
                    data: {
                        owner: owner,
                        name: name,
                        startDate: startDate,
                        endDate: endDate,
                        cost: cost,
                        description: description
                    },
                    type: 'post',
                    dataType: 'json',
                    success(data) {
                        $("#createActivityModal").modal("hide")
                        if (data.code == "1") {
                            queryActivityForPageByCondition(1, $("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'))
                        } else {
                            alert(data.success)
                        }
                    }
                })
            });

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

            //给查询按钮添加单击事件
            $("#queryActivityBtn").click(() => {
                queryActivityForPageByCondition(1, $("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'))
            })

            //给全选按钮添加事件
            $("#checkAll").click(() => {
                $("#tBody input[type='checkbox']").prop("checked", $("#checkAll").prop("checked"))
            })

            //给修改按钮添加单击事件
            $("#editActivityBtn").click(() => {
                var chkedIds = $("#tBody input[type='checkbox']:checked")
                //判断数据
                if (chkedIds.size() < 1) {
                    alert("请选择一个需要修改的数据")
                    return
                }
                if (chkedIds.size() > 1) {
                    alert("只能选择一个数据进行修改")
                    return
                }
                var id = chkedIds[0].value
                $.ajax({
                    url: "workbench/activity/editActivity.do",
                    data: {
                        id: id
                    },
                    type: 'post',
                    dataType: 'json',
                    success(data) {
                        $("#edit-id").val(data.id)
                        //给下拉框设置选择的
                        $("#edit-marketActivityOwner").val(data.owner)
                        $("#edit-marketActivityName").val(data.name)
                        $("#edit-startTime").val(data.startDate)
                        $("#edit-endTime").val(data.endDate)
                        $("#edit-cost").val(data.cost)
                        $("#edit-describe").val(data.name)

                        //显示创建市场活动的模态窗口
                        $("#editActivityModal").modal("show")
                    }
                })
            })

            //确定按钮
            $("#updateActivityBtn").click(() => {
                //收集参数
                let id = $("#edit-id").val()
                let owner = $("#edit-marketActivityOwner").val()
                let name = $.trim($("#edit-marketActivityName").val())
                let startDate = $("#edit-startTime").val()
                let endDate = $("#edit-endTime").val()
                let cost = $.trim($("#edit-cost").val())
                let description = $.trim($("#edit-describe").val())
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
                $.post("updateActivityById", {
                        id: id, owner: owner, name: name, startDate: startDate,
                        endDate: endDate, cost: cost, description: description
                    }, (data) => {
                        if (data.code == "1") {
                            queryActivityForPageByCondition($("#demo_pag1").bs_pagination('getOption', 'currentPage'), $("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'))
                            $("#editActivityModal").modal('hide')
                        } else {
                            alert(data.msg)
                        }
                    },
                    'json'
                )
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
                $.post("removeActivityByIds", ids, (data) => {
                    if (data.code == "1") {
                        queryActivityForPageByCondition(1, $("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'))
                    } else {
                        alert(data.msg)
                    }
                }, 'json')
            })

            //批量导出市场活动
            $("#exportActivityAllBtn").click(() => {
                location = "workbench/activity/downloadsActivity"
            })

            //选择导出市场活动
            $("#exportActivityXzBtn").click(() => {
                let checkId = $("#tBody input[type='checkbox']:checked")
                if (checkId.size() < 1) {
                    alert("每次至少登出一条数据")
                    return;
                }
                let ids = ""
                $.each(checkId, (index, object) => {
                    ids += "ids=" + object.value + "&"
                })
                ids = ids.substr(0, ids.length - 1)
                location = "workbench/activity/downloadsActivityByIds?" + ids
            })

            //导入市场活动
            $("#importActivityBtn").click(() => {
                alert(1)
                $.ajax({
                    url: "workbench/activity/fileupload",
                    data: $("#activityFile").val(),
                    type: 'post',
                    dataType: 'json',
                    contentType: 'multipart/form-data',
                    traditional: false,
                    processData: false,
                    success(data) {

                    }
                })
            })
        })
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
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner">
                                <c:forEach items="${usersList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startDate" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control upDate" id="create-startDate" readonly>
                        </div>
                        <label for="create-endDate" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control upDate" id="create-endDate" readonly>
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
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
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                                <c:forEach items="${usersList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control editDate" id="edit-startTime" readonly>
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control editDate" id="edit-endTime" readonly>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost">
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
                    <input type="file" id="activityFile" name="myFile">
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
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="importActivityBtn" type="button" class="btn btn-primary">导入</button>
            </div>
        </div>
    </div>
</div>

<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">
        <%--查询列表--%>
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
                        <input id="query-owner" class="form-control" type="text">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control queryDate" type="text" id="query-startDate" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control queryDate" type="text" id="query-endDate" readonly>
                    </div>
                </div>
                <button id="queryActivityBtn" type="button" class="btn btn-default">查询</button>
            </form>
        </div>
        <%--编辑列表--%>
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
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal">
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
        <%--数据列表--%>
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