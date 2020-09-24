<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        //分页查询线索
        function queryClue(pageNo, pageSize) {
            //收集参数
            let name = $("#queryName").val()
            let company = $("#queryCompany").val()
            let phone = $("#queryPhone").val()
            let source = $("#querySource").val()
            let owner = $("#queryOwner").val()
            let cellPhone = $("#queryCellPhone").val()
            let state = $("#queryState").val()
            $.ajax({
                url: "workbench/clue/findPagingClue",
                data: {
                    pageNo: pageNo,
                    pageSize: pageSize,
                    fullName: name,
                    company: company,
                    phone: phone,
                    source: source,
                    owner: owner,
                    cellPhone: cellPhone,
                    state: state
                },
                type: "post",
                dataType: "json",
                success(data) {
                    if (data.code == "1") {
                        // console.log(data.data)
                        //更新列表线索
                        let clueHtml = []
                        $.each(data.data.clueList, (index, object) => {
                            clueHtml.push('<tr class="' + (index % 2 == 0 ? "active" : "") + '">\
                            <td><input value="' + object.id + '" type="checkbox" /></td>\
                                <td><a style="text-decoration: none; cursor: pointer;" onclick="location.href=\
                                \'workbench/clue/findClueForDetailById?id=' + object.id + '\';">' + object.fullName + '</a></td>\
                            <td>' + object.company + '</td>\
                            <td>' + object.phone + '</td>\
                            <td>' + object.cellPhone + '</td>\
                            <td>' + (object.source || "") + '</td>\
                            <td>' + object.owner + '</td>\
                            <td>' + (object.state || "") + '</td>\
                            </tr>')
                        })
                        $("#clueTbody").html(clueHtml)

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
                                queryClue(pageObj.currentPage, pageObj.rowsPerPage)
                            }
                        })
                    }
                }
            })
        }

        //窗口加载完毕
        $(() => {
            //分页查询线索
            queryClue(1, 10)

            //设置创建日期样式
            $(".addDate").datetimepicker({
                language: 'zh-CN',//语言
                format: 'yyyy-mm-dd',//日期格式
                minView: 'month',//选择器上能选择的最小日期
                initialDate: new Date(),//设置默认时间
                autoclose: true,//单击后是否关闭
                todayBtn: true,//每次打开是否显示当前时间
                clearBtn: true,//是否显示清空按钮
                container: '#createClueModal'
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
                container: '#editClueModal'
            })

            //全选按钮
            let allCheckbox = $("#allCheckbox")
            //全选事件
            allCheckbox.click(() => {
                $("#clueTbody input[type='checkbox']").prop("checked", allCheckbox.prop("checked"))
            })
            //绑定其他复选框事件
            $("#clueTbody").on("click", "input[type='checkbox']", () => {
                if ($("#clueTbody input[type='checkbox']").size() == $("#clueTbody input[type='checkbox']:checked").size()) {
                    allCheckbox.prop("checked", true)
                } else {
                    allCheckbox.prop("checked", false)
                }
            })

            //分页容器
            let demo = $("#demo_pag")

            //创建模态窗口
            let createClueModal = $("#createClueModal")
            //修改模态窗口
            let editClueModal = $("#editClueModal")

            //创建窗口确定按钮
            let createClueBtn = $("#createClueBtn")
            //修改窗口确定按钮
            let modifyClueBtn = $("#modifyClueBtn")

            //页面查询按钮
            let queryClueBtn = $("#queryClueBtn")
            //点击页面查询按钮
            queryClueBtn.click(() => {
                queryClue(1, demo.bs_pagination('getOption', 'rowsPerPage'))
            })

            //创建窗口数据
            let id = $("#id")
            let clueOwner = $("#edit-clueOwner")
            let company = $("#edit-company")
            let call = $("#edit-call")
            let surname = $("#edit-surname")
            let job = $("#edit-job")
            let email = $("#edit-email")
            let phone = $("#edit-phone")
            let website = $("#edit-website")
            let cellPhone = $("#edit-CellPhone")
            let states = $("#edit-status")
            let source = $("#edit-source")
            let describe = $("#edit-describe")
            let contactSummary = $("#edit-contactSummary")
            let nextContactTime = $("#edit-nextContactTime")
            let address = $("#edit-address")
            //点击修改线索按钮
            $("#modifyClueBtnView").click(() => {
                let checkedCheckbox = $("#clueTbody input[type='checkbox']:checked")
                if (checkedCheckbox.size() < 1) {
                    alert("请选择一条需要修改的线索")
                    return
                }
                if (checkedCheckbox.size() > 1) {
                    alert("只能选择一条需要修改的线索")
                    return
                }
                let clueId = checkedCheckbox[0].value
                $.ajax({
                    url: "workbench/clue/findClueById",
                    data: {
                        id: clueId
                    },
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == "1") {
                            // console.log(data.data)
                            id.val(data.data.id)
                            clueOwner.val(data.data.owner)
                            company.val(data.data.company)
                            call.val(data.data.appellation)
                            surname.val(data.data.fullName)
                            job.val(data.data.job)
                            email.val(data.data.email)
                            phone.val(data.data.phone)
                            website.val(data.data.website)
                            cellPhone.val(data.data.cellPhone)
                            states.val(data.data.state)
                            source.val(data.data.source)
                            describe.val(data.data.description)
                            contactSummary.val(data.data.contactSummary)
                            nextContactTime.val(data.data.nextContactTime)
                            address.val(data.data.address)
                            editClueModal.modal("show")
                        }
                    }
                })
            })
            //确定更新按钮单击事件
            modifyClueBtn.click(() => {
                //获取数据
                let idVal = id.val()
                let clueOwnerVal = clueOwner.val()
                let companyVal = company.val()
                let callVal = call.val()
                let surnameVal = surname.val()
                let jobVal = job.val()
                let emailVal = email.val()
                let phoneVal = phone.val()
                let websiteVal = website.val()
                let cellPhoneVal = cellPhone.val()
                let statesVal = states.val()
                let sourceVal = source.val()
                let describeVal = describe.val()
                let contactSummaryVal = contactSummary.val()
                let nextContactTimeVal = nextContactTime.val()
                let addressVal = address.val()
                //判断数据
                if (!clueOwnerVal) {
                    alert("所有者不能为空")
                    return
                }
                if (!companyVal) {
                    alert("公司不能为空")
                    return
                }
                if (!surnameVal) {
                    alert("姓名不能为空")
                    return
                }
                if (emailVal) {
                    if (!(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(emailVal))) {
                        alert("邮箱不符合要求")
                        return
                    }
                }
                if (phoneVal) {
                    if (!(/^0\d{2,3}-\d{7,8}|\(?0\d{2,3}[)-]?\d{7,8}|\(?0\d{2,3}[)-]*\d{7,8}$/).test(phoneVal)) {
                        alert("座机不符合要求")
                        return;
                    }
                }
                if (websiteVal) {
                    if (!(/^[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$/.test(websiteVal))) {
                        alert("网站不符合要求")
                        return
                    }
                }
                if (cellPhoneVal) {
                    if (!(/^1[3456789]\d{9}$/.test(cellPhoneVal))) {
                        alert("手机号码有误，请重填");
                        return
                    }
                }
                $.ajax({
                    url: "workbench/clue/modifyClue",
                    data: {
                        id: idVal,
                        fullName: surnameVal,
                        appellation: callVal,
                        owner: clueOwnerVal,
                        company: companyVal,
                        job: jobVal,
                        email: emailVal,
                        phone: phoneVal,
                        website: websiteVal,
                        cellPhone: cellPhoneVal,
                        state: statesVal,
                        source: sourceVal,
                        editBy: '${sessionScope.sessionUser.id}',
                        description: describeVal,
                        contactSummary: contactSummaryVal,
                        nextContactTime: nextContactTimeVal,
                        address: addressVal
                    },
                    type: "post",
                    dataType: "json",
                    success(data) {
                        if (data.code == "1") {
                            queryClue(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                            editClueModal.modal("hide")
                        }
                    }
                })
            })

            //创建_所有者
            let createClueOwner = $("#create-clueOwner")
            //创建_线索描述
            let createDescribe = $("#create-describe")
            //点击创建线索按钮
            $("#addClueBtnView").click(() => {
                $("#addClueForm")[0].reset()
                //设置选择框为当前用户
                createClueOwner.val("${sessionScope.sessionUser.id}")
                createClueModal.modal("show")
            })
            //点击创建线索事件
            createClueBtn.click(() => {
                //收集参数
                let owner = createClueOwner.val()
                let company = $("#create-company").val()
                let appellation = $("#create-call").val()
                let fullName = $("#create-surname").val()
                let job = $("#create-job").val()
                let email = $("#create-email").val()
                let phone = $("#create-phone").val()
                let website = $("#create-website").val()
                let cellPhone = $("#create-cellPhone").val()
                let state = $("#create-status").val()
                let source = $("#create-source").val()
                let description = $.trim(createDescribe.val())
                let contactSummary = $("#create-contactSummary").val()
                let nextContactTime = $("#create-nextContactTime").val()
                let address = $("#create-address").val()
                //判断参数
                if (!owner) {
                    alert("所有者不能为空")
                    return
                }
                if (!company) {
                    alert("公司不能为空")
                    return
                }
                if (!fullName) {
                    alert("姓名不能为空")
                    return
                }
                if (email) {
                    if (!(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(email))) {
                        alert("邮箱不符合要求")
                        return
                    }
                }
                if (phone) {
                    if (!(/^0\d{2,3}-\d{7,8}|\(?0\d{2,3}[)-]?\d{7,8}|\(?0\d{2,3}[)-]*\d{7,8}$/).test(phone)) {
                        alert("座机不符合要求")
                        return;
                    }
                }
                if (website) {
                    if (!(/^[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$/.test(website))) {
                        alert("网站不符合要求")
                        return
                    }
                }
                if (cellPhone) {
                    if (!(/^1[3456789]\d{9}$/.test(cellPhone))) {
                        alert("手机号码有误，请重填");
                        return
                    }
                }
                $.ajax({
                    url: "workbench/clue/addClue",
                    data: {
                        fullName: fullName,
                        appellation: appellation,
                        owner: owner,
                        company: company,
                        job: job,
                        email: email,
                        phone: phone,
                        website: website,
                        cellPhone: cellPhone,
                        state: state,
                        source: source,
                        description: description,
                        contactSummary: contactSummary,
                        nextContactTime: nextContactTime,
                        address: address
                    },
                    type: 'post',
                    dataType: 'json',
                    success(data) {
                        if (data.code == "1") {
                            queryClue(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                            createClueModal.modal("hide")
                        }
                    }
                })
            })

            //回车事件
            $(window).keydown(e => {
                if (e.key == "Enter") {
                    //判断是否在创建线索界面
                    if (!createClueModal.is(":hidden")) {
                        //确定创建
                        createClueBtn.click()
                    } else if (!editClueModal.is(":hidden")) {
                        //确定修改
                        modifyClueBtn.click()
                    } else {
                        //查询
                        queryClueBtn.click()
                    }
                }
            })

            //点击删除按钮
            $("#removeClueBtn").click(() => {
                let allChecked = $("#clueTbody input[type='checkbox']:checked");
                if (allChecked.size() < 1) {
                    alert("请选择一条要删除的线索")
                    return
                }
                let clueIds = ""
                $.each(allChecked, (index, object) => {
                    clueIds += "ids=" + object.value + "&"
                })
                clueIds = clueIds.substr(0, clueIds.length - 1)
                if (!confirm("确认删除吗")) return;
                $.ajax({
                    url: "workbench/clue/removeClueByIds?" + clueIds,
                    type: "post",
                    datatype: "json",
                    success(data) {
                        if (data.code == 1) {
                            queryClue(1, demo.bs_pagination('getOption', 'rowsPerPage'))
                        }
                    }

                })
            })
        });
    </script>
</head>
<body>
<!-- 创建线索的模态窗口 -->
<div class="modal fade" id="createClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">创建线索</h4>
            </div>
            <div class="modal-body">
                <form id="addClueForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-clueOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-clueOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-company" class="col-sm-2 control-label">公司<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-company">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-call">
                                <option></option>
                                <c:forEach items="${appellationList}" var="appellation">
                                    <option value="${appellation.id}">${appellation.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-surname">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-job">
                        </div>
                        <label for="create-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-email" autocomplete="on">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-phone" autocomplete="on">
                        </div>
                        <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-website">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-cellPhone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cellPhone">
                        </div>
                        <label for="create-status" class="col-sm-2 control-label">线索状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-status">
                                <option></option>
                                <c:forEach items="${clueStateList}" var="clueState">
                                    <option value="${clueState.id}">${clueState.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-source" class="col-sm-2 control-label">线索来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-source">
                                <option></option>
                                <c:forEach items="${sourceList}" var="source">
                                    <option value="${source.id}">${source.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">线索描述</label>
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
                <button id="createClueBtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改线索的模态窗口 -->
<div class="modal fade" id="editClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">修改线索</h4>
                <input id="id" type="hidden">
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-clueOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-company" class="col-sm-2 control-label">公司<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-company" value="动力节点">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-call">
                                <option></option>
                                <c:forEach items="${appellationList}" var="appellation">
                                    <option value="${appellation.id}">${appellation.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-surname" value="李四">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-job" value="CTO">
                        </div>
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone" value="010-84846003">
                        </div>
                        <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-website"
                                   value="http://www.bjpowernode.com">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-CellPhone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-CellPhone" value="12345678901">
                        </div>
                        <label for="edit-status" class="col-sm-2 control-label">线索状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-status">
                                <option></option>
                                <c:forEach items="${clueStateList}" var="clueState">
                                    <option value="${clueState.id}">${clueState.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-source" class="col-sm-2 control-label">线索来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-source">
                                <option></option>
                                <c:forEach items="${sourceList}" var="source">
                                    <option value="${source.id}">${source.value}</option>
                                </c:forEach>
                            </select>
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
                            <label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-contactSummary">这个线索即将被转换</textarea>
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
                                <textarea class="form-control" rows="1" id="edit-address">北京大兴区大族企业湾</textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="modifyClueBtn" type="button" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>
<%-- 标题--%>
<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>线索列表</h3>
        </div>
    </div>
</div>
<%-- 数据区--%>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">
        <%-- 查询列表--%>
        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon" style="width: 67px">名称</div>
                        <input id="queryName" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司</div>
                        <input id="queryCompany" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司座机</div>
                        <input id="queryPhone" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">线索来源</div>
                        <select id="querySource" class="form-control">
                            <option></option>
                            <c:forEach items="${sourceList}" var="source">
                                <option value="${source.id}">${source.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <br>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <%--                        <input id="" class="form-control" type="text">--%>
                        <select id="queryOwner" class="form-control" style="width: 196px;">
                            <option></option>
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">手机</div>
                        <input id="queryCellPhone" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">线索状态</div>
                        <select id="queryState" class="form-control" style="width: 196px;">
                            <option></option>
                            <c:forEach items="${clueStateList}" var="clueState">
                                <option value="${clueState.id}">${clueState.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <button id="queryClueBtn" type="button" class="btn btn-default"
                        style="width: 227px;background-color: #74a4ce;"><span style="color: #ffffff">查询</span></button>

            </form>
        </div>
        <%-- 操作列表--%>
        <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="addClueBtnView" type="button" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button id="modifyClueBtnView" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button id="removeClueBtn" type="button" class="btn btn-danger">
                    <span class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>
        </div>
        <%-- 数据区--%>
        <div style="position: relative;top: 50px">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="allCheckbox" type="checkbox"/></td>
                    <td>名称</td>
                    <td>公司</td>
                    <td>公司座机</td>
                    <td>手机</td>
                    <td>线索来源</td>
                    <td>所有者</td>
                    <td>线索状态</td>
                </tr>
                </thead>
                <tbody id="clueTbody">
                </tbody>
            </table>
            <div id="demo_pag"></div>
        </div>
    </div>
</div>
</body>
</html>