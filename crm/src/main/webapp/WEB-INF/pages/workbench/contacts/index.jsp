<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        //分页查询联系人
        function findContact(pageNo, pageSize) {
            let owner = $("#findOwner").val()
            let name = $("#findName").val()
            let customerId = $("#findCustomerId").val()
            let clueSource = $("#findClueSource").val()
            let birth = $("#findBirth").val()
            $.ajax({
                url: "workbench/contacts/findPagingContactsForDetail",
                data: {
                    pageNo: pageNo,
                    pageSize: pageSize,
                    name: name,
                    owner: owner,
                    customerId: customerId,
                    clueSource: clueSource,
                    birth: birth
                },
                type: "post",
                datatype: "json",
                success(data) {
                    if (data.code == "1") {
                        // console.log(data.data)
                        let html = []
                        $.each(data.data.contactsList, (index, Object) => {
                            html.push('<tr class="' + (index % 2 == 0 ? "active" : "") + '">\
                                            <td><input type="checkbox" value="' + Object.id + '"/></td>\
                                                <td><a style="text-decoration: none; cursor: pointer;"\
                                            href="workbench/contacts/findContactsForDetailByIdToView?id=' + Object.id + '">' + Object.fullName + '</a></td>\
                                            <td>' + (Object.customerId || "") + '</td>\
                                            <td>' + Object.owner + '</td>\
                                            <td>' + (Object.source || "") + '</td>\
                                            <td>' + (Object.birth||"") + '</td>\
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
                                findContact(pageObj.currentPage, pageObj.rowsPerPage)
                            }
                        })
                    }
                }
            })
        }

        $(() => {
            findContact(1, 10)

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

            //分页div
            let demo = $("#demo_pag")

            //定制字段
            $("#definedColumns > li").click(function (e) {
                //防止下拉菜单消失
                e.stopPropagation();
            });

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

            //设置查询日期样式
            $(".findDate").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//选择器上能选择的最小日期
                initialDate: new Date(),//设置默认时间
                autoclose: true,//单击后是否关闭
                todayBtn: true,//每次打开是否显示当前时间
                clearBtn: true,//是否显示清空按钮
                container: "#findDiv"
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
            //设置编辑日期样式
            $(".editDate").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//选择器上能选择的最小日期
                initialDate: new Date(),//设置默认时间
                autoclose: true,//单击后是否关闭
                todayBtn: true,//每次打开是否显示当前时间
                clearBtn: true,//是否显示清空按钮
                container: '#editContactsModal'
            })

            //创建联系人的模态窗口
            let createContactsModal = $("#createContactsModal")
            //修改联系人的模态窗口
            let editContactsModal = $("#editContactsModal")

            //创建按钮点击视图
            let createContactsViewBtn = $("#createContactsViewBtn")
            //修改按钮点击视图
            let editContactViewBtn = $("#editContactViewBtn")

            //确定创建联系人按钮
            let createContactsBtn = $("#createContactsBtn")
            //确定修改联系人按钮
            let editContactsBtn = $("#editContactsBtn")

            //创建界面所有者
            let createContactsOwner = $("#create-contactsOwner")
            //客户
            let createCustomerName = $("#create-customerName")
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
                let customerId = createCustomerName.val()
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
                            findContact(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                            createContactsModal.modal("hide")
                        }
                    }
                })
            })

            //修改页面数据
            let editId = $("#edit-id")
            let editContactsOwner = $("#edit-contactsOwner")
            let editClueSource = $("#edit-clueSource")
            let editSurname = $("#edit-surname")
            let editCall = $("#edit-call")
            let editJob = $("#edit-job")
            let editCellPhone = $("#edit-CellPhone")
            let editEmail = $("#edit-email")
            let editBirth = $("#edit-birth")
            let editCustomerName = $("#edit-customerName")
            let editDescribe = $("#edit-describe")
            let editContactSummary = $("#edit-contactSummary")
            let editNextContactTime = $("#edit-nextContactTime")
            let editAddress = $("#edit-address")
            //修改按钮点击事件
            editContactViewBtn.click(() => {
                let checkboxChecked = $("#dataTbody input[type='checkbox']:checked")
                if (checkboxChecked.size() < 1) {
                    alert("请选择一条需要修改的联系人")
                    return
                }
                if (checkboxChecked.size() > 1) {
                    alert("只能选择一条需要修改的联系人")
                    return
                }
                $.ajax({
                    url: "workbench/contacts/findContactsDetailedCustomerIdById",
                    data: {
                        id: checkboxChecked[0].value
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            // console.log(data.data)

                            editId.val(data.data.id)
                            editContactsOwner.val(data.data.owner)
                            editClueSource.val(data.data.source)
                            editSurname.val(data.data.fullName)
                            editCall.val(data.data.appellation)
                            editJob.val(data.data.job)
                            editCellPhone.val(data.data.cellPhone)
                            editEmail.val(data.data.email)
                            editBirth.val(data.data.birth)
                            editCustomerName.val(data.data.customerId)
                            editDescribe.val(data.data.description)
                            editContactSummary.val(data.data.contactSummary)
                            editNextContactTime.val(data.data.nextContactTime)
                            editAddress.val(data.data.address)

                            editContactsModal.modal("show")
                        }
                    }
                })
            })
            //确定修改按钮点击事件
            editContactsBtn.click(() => {
                $.ajax({
                    url: "workbench/contacts/updateByPrimaryKeySelective",
                    data: {
                        id: editId.val(),
                        owner: editContactsOwner.val(),
                        source: editClueSource.val(),
                        fullName: editSurname.val(),
                        appellation: editCall.val(),
                        job: editJob.val(),
                        cellPhone: editCellPhone.val(),
                        email: editEmail.val(),
                        birth: editBirth.val(),
                        editBy: "${sessionScope.sessionUser.id}",
                        customerId: editCustomerName.val(),
                        description: editDescribe.val(),
                        contactSummary: editContactSummary.val(),
                        nextContactTime: editNextContactTime.val(),
                        address: editAddress.val()
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            findContact(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                            editContactsModal.modal("hide")
                        }
                    }
                })
            })

            //点击页面查询事件
            $("#findContactsBtn").click(() => {
                findContact(1, demo.bs_pagination('getOption', 'rowsPerPage'))
            })

            //删除按钮点击事件
            $("#removeContactBtn").click(() => {
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
                    url: "workbench/contacts/removeByMultiplePrimaryKey",
                    data: {
                        ids: ids
                    },
                    type: "post",
                    datatype: "json",
                    traditional: true,
                    success(data) {
                        if (data.code == "1") {
                            findContact(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                        }
                    }
                })
            })

            //客户输入框内容改变事件
            createCustomerName.keyup(() => {
                createCustomerName.typeahead({
                    source: customerName
                })
            })
            editCustomerName.keyup(() => {
                editCustomerName.typeahead({
                    source: customerName
                })
            })
        });
    </script>
</head>
<body>
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
                        <label for="create-surname" class="col-sm-2 control-label">姓名
                            <span style="font-size: 15px; color: red;">*</span></label>
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
                                   placeholder="支持自动补全，输入客户不存在则新建" autocomplete="off">
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
<!-- 修改联系人的模态窗口 -->
<div class="modal fade" id="editContactsModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
                <input type="hidden" id="edit-id">
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-contactsOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-clueSource" class="col-sm-2 control-label">来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-clueSource">
                                <option></option>
                                <c:forEach items="${sourceList}" var="source">
                                    <option value="${source.id}">${source.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-surname">
                        </div>
                        <label for="edit-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-call">
                                <option></option>
                                <c:forEach items="${appellationList}" var="appellation">
                                    <option value="${appellation.id}">${appellation.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-job">
                        </div>
                        <label for="edit-cellPhone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-CellPhone">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-email">
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
                                   placeholder="支持自动补全，输入客户不存在则新建" autocomplete="off">
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
                                <input type="text" class="form-control" id="edit-nextContactTime">
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
                <button id="editContactsBtn" type="button" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>
<%-- 标题--%>
<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>联系人列表</h3>
        </div>
    </div>
</div>
<%-- 内容--%>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">
        <%-- 查询列表--%>
        <div id="findDiv" class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <%--                        <input class="form-control" type="text">--%>
                        <select class="form-control" id="findOwner" style="width: 196px;">
                            <option></option>
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">姓名</div>
                        <input id="findName" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">客户名称</div>
<%--                        <input id="findCustomerId" class="form-control" type="text">--%>
                        <select class="form-control" id="findCustomerId" style="width: 196px">
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
                        <div class="input-group-addon" style="width: 67px">来源</div>
                        <select class="form-control" id="findClueSource" style="width: 196px;">
                            <option></option>
                            <c:forEach items="${sourceList}" var="source">
                                <option value="${source.id}">${source.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">生日</div>
                        <input id="findBirth" class="form-control findDate" type="text" readonly
                               style="background-color: #ffffff">
                    </div>
                </div>

                <button id="findContactsBtn" type="button" class="btn btn-default"
                        style="width: 277px; background-color: #74a4ce;"><span
                        style="color: #ffffff">查询</span></button>

            </form>
        </div>
        <%-- 操作列表--%>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="createContactsViewBtn" type="button" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button id="editContactViewBtn" type="button" class="btn btn-default">
                    <span class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button id="removeContactBtn" type="button" class="btn btn-danger">
                    <span class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>
        </div>
        <%-- 数据区--%>
        <div style="position: relative;top: 20px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="allCheckbox" type="checkbox"/></td>
                    <td>姓名</td>
                    <td>客户名称</td>
                    <td>所有者</td>
                    <td>来源</td>
                    <td>生日</td>
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