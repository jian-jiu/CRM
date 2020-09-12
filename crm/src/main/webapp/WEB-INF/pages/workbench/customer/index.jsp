<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        function findCustomer(pageNo, pageSize) {
            let name = $("#findName").val()
            let owner = $("#findOwner").val()
            let phone = $("#findPhone").val()
            let website = $("#findWebsite").val()

            $.ajax({
                url: "workbench/customer/findAllCustomerForDetail",
                data: {
                    pageNo: pageNo,
                    pageSize: pageSize,
                    name: name,
                    owner: owner,
                    phone: phone,
                    website: website
                },
                type: "post",
                datatype: "json",
                success(data) {
                    if (data.code == "1") {
                        // console.log(data.data)
                        let html = []
                        $.each(data.data.customerList, (index, Object) => {
                            html.push('<tr class="' + (index % 2 == 0 ? "active" : "") + '">\
                                            <td><input type="checkbox" value="' + Object.id + '"/></td>\
                                                <td><a style="text-decoration: none; cursor: pointer;" \
                                                href="workbench/customer/findCustomerForDetailById?id=' + Object.id + '">' + Object.name + '</a></td>\
                                            <td>' + Object.owner + '</td>\
                                            <td>' + Object.phone + '</td>\
                                            <td>' + Object.website + '</td>\
                                        </tr>')
                        })
                        $("#dataTbody").html(html)

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
                                findCustomer(pageObj.currentPage, pageObj.rowsPerPage)
                            }
                        })
                    }
                }
            })
        }

        $(() => {
            findCustomer(1, 10)

            //分页div
            let demo = $("#demo_pag")

            //全选按钮
            let allCheckbox = $("#allCheckbox")
            //全选事件
            allCheckbox.click(() => {
                $("#dataTbody input[type='checkbox']").prop("checked", allCheckbox.prop("checked"))
            })
            //绑定其他复选框事件
            $("#dataTbody").on("click", "input[type='checkbox']", () => {
                if ($("#dataTbody input[type='checkbox']").size() == $("#dataTbody input[type='checkbox']:checked").size()) {
                    allCheckbox.prop("checked", true)
                } else {
                    allCheckbox.prop("checked", false)
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
                container: '#createCustomerModal'
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
                container: '#editCustomerModal'
            })

            //定制字段
            $("#definedColumns > li").click(function (e) {
                //防止下拉菜单消失
                e.stopPropagation();
            });
            //创建客户的模态窗口
            let createCustomerModal = $("#createCustomerModal")
            //修改客户的模态窗口
            let editCustomerModal = $("#editCustomerModal")

            //页面查询按钮
            let findCustomerBtn = $("#findCustomerBtn")
            //页面背景按钮
            let editCustomerViewBtn = $("#editCustomerViewBtn")

            //确定添加数据按钮
            let saveCustomerBtn = $("#saveCustomerBtn")
            //确定修改数据按钮
            let editCustomerBtn = $("#editCustomerBtn")

            //页面查询点击事件
            findCustomerBtn.click(() => {
                findCustomer(1, demo.bs_pagination('getOption', 'rowsPerPage'))
            })

            //创建视图所有者下拉框
            let createCustomerOwner = $("#create-customerOwner")
            //创建按钮点击事件
            $("#createCustomerViewBtn").click(() => {
                $("#createForm")[0].reset()
                createCustomerOwner.val("${sessionScope.sessionUser.id}")
                createCustomerModal.modal("show")
            })
            //确定添加数据点击事件
            saveCustomerBtn.click(() => {
                let owner = createCustomerOwner.val()
                let name = $("#create-customerName").val()
                let website = $("#create-website").val()
                let phone = $("#create-phone").val()
                let createBy = "${sessionScope.sessionUser.id}"
                let description = $("#create-describe").val()
                let contactSummary = $("#create-contactSummary").val()
                let nextContactTime = $("#create-nextContactTime").val()
                let address = $("#create-address").val()
                if (!name) {
                    alert("名称不能为空")
                    return
                }
                $.ajax({
                    url: "workbench/customer/addCustomer",
                    data: {
                        owner: owner,
                        name: name,
                        website: website,
                        phone: phone,
                        createBy: createBy,
                        description: description,
                        contactSummary: contactSummary,
                        nextContactTime: nextContactTime,
                        address: address
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            findCustomer(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                            createCustomerModal.modal("hide")
                        }
                    }
                })
            })

            //编辑数据
            let editId = $("#edit-id")
            let editCustomerOwner = $("#edit-customerOwner")
            let editCustomerName = $("#edit-customerName")
            let editWebsite = $("#edit-website")
            let editPhone = $("#edit-phone")
            let editDescribe = $("#edit-describe")
            let editContactSummary = $("#edit-contactSummary")
            let editNextContactTime = $("#edit-nextContactTime")
            let editAddress = $("#edit-address")

            //修改数据点击事件
            editCustomerViewBtn.click(() => {
                let checkedCheckbox = $("#dataTbody input[type='checkbox']:checked")
                if (checkedCheckbox.size() < 1) {
                    alert("请选择一条需要修改的数据")
                    return
                }
                if (checkedCheckbox.size() > 1) {
                    alert("只能选择一条数据进行修改")
                    return
                }
                let id = checkedCheckbox[0].value
                $.ajax({
                    url: "workbench/customer/findCustomerById",
                    data: {
                        id: id
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            // console.log(data.data)

                            editId.val(data.data.id)
                            editCustomerOwner.val(data.data.owner)
                            editCustomerName.val(data.data.name)
                            editWebsite.val(data.data.website)
                            editPhone.val(data.data.phone)
                            editDescribe.val(data.data.description)
                            editContactSummary.val(data.data.contactSummary)
                            editNextContactTime.val(data.data.nextContactTime)
                            editAddress.val(data.data.address)

                            editCustomerModal.modal("show")
                        }
                    }

                })
            })
            //确定修改按钮点击事件
            editCustomerBtn.click(() => {
                let id = editId.val()
                let owner = editCustomerOwner.val()
                let name = editCustomerName.val()
                let website = editWebsite.val()
                let phone = editPhone.val()
                let description = editDescribe.val()
                let contactSummary = editContactSummary.val()
                let nextContactTime = editNextContactTime.val()
                let address = editAddress.val()
                if (!name) {
                    alert("名称不能为空")
                    return
                }
                $.ajax({
                    url: "workbench/customer/updateCustomer",
                    data: {
                        id: id,
                        owner: owner,
                        name: name,
                        website: website,
                        phone: phone,
                        editBy: "${sessionScope.sessionUser.id}",
                        contactSummary: contactSummary,
                        nextContactTime: nextContactTime,
                        description: description,
                        address: address
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            findCustomer(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                            editCustomerModal.modal("hide")
                        }
                    }
                })
            })

            //删除按钮点击事件
            $("#removeCustomerBtn").click(() => {
                let checkedCheckbox = $("#dataTbody input[type='checkbox']:checked")
                if (checkedCheckbox.size() < 1) {
                    alert("请选择一条需要删除的数据")
                    return
                }
                let ids = []
                $.each(checkedCheckbox, function () {
                    ids.push(this.value)
                })
                console.log(ids)
                if (!confirm("是否删除吗")) return;
                $.ajax({
                    url: "workbench/customer/removeByMultiplePrimaryKeys",
                    data: {
                        ids: ids
                    },
                    type: "post",
                    datatype: "json",
                    traditional: true,
                    success(data) {
                        if (data.code == "1") {
                            findCustomer(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                        }
                    }
                })
            })
        });
    </script>
</head>
<body>
<!-- 创建客户的模态窗口 -->
<div class="modal fade" id="createCustomerModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建客户</h4>
            </div>
            <div class="modal-body">
                <form id="createForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-customerOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-customerOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-customerName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-customerName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-website">
                        </div>
                        <label for="create-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-phone">
                        </div>
                    </div>
                    <div class="form-group">
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
                <button id="saveCustomerBtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改客户的模态窗口 -->
<div class="modal fade" id="editCustomerModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改客户</h4>
                <input type="hidden" id="edit-id">
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-customerOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-customerName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-customerName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-website">
                        </div>
                        <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control editDate" id="edit-nextContactTime" readonly
                                       style="background-color: #ffffff">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="edit-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="editCustomerBtn" type="button" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>
<%-- 标题--%>
<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>客户列表</h3>
        </div>
    </div>
</div>
<%-- 内容--%>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">
        <%-- 查询列表--%>
        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input id="findName" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <%--                        <input id="findOwner" class="form-control" type="text">--%>
                        <select class="form-control" id="findOwner" style="width: 196px">
                            <option></option>
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司座机</div>
                        <input id="findPhone" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司网站</div>
                        <input id="findWebsite" class="form-control" type="text">
                    </div>
                </div>

                <button id="findCustomerBtn" type="button" class="btn btn-default"
                        style="background-color: #74a4ce;"><span
                        style="color: #ffffff">查询</span></button>

            </form>
        </div>
        <%-- 功能操作--%>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="createCustomerViewBtn" type="button" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button id="editCustomerViewBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button id="removeCustomerBtn" type="button" class="btn btn-danger"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="allCheckbox" type="checkbox"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>公司座机</td>
                    <td>公司网站</td>
                </tr>
                </thead>
                <tbody id="dataTbody">
                </tbody>
            </table>
            <div id="demo_pag">
            </div>
        </div>
    </div>
</div>
</body>
</html>