<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../../../../HeadPart.jsp" %>
    <script type="text/javascript">
        $(function () {
            //给创建按钮添加事件
            $("#createDicValueBtn").click(function () {
                window.location.href = "settings/dictionary/value/toSave.do"
            })

            //给删除按钮添加事件
            $("#deleteDicValueBtn").click(function () {
                //收集参数
                var chkedIds = $("#tBody input[type='checkbox']:checked")
                if (chkedIds.size() == 0) {
                    alert("请选择要删除的记录")
                    return
                }
                //遍历数组获取coed
                var idsStr = ""
                $.each(chkedIds, function () {
                    idsStr += "id=" + this.value + "&"
                })
                idsStr = idsStr.substr(0, idsStr.length - 1)
                if (window.confirm("确认删除吗？")) {
                    //发送请求
                    $.ajax({
                        url: 'settings/dictionary/value/deleteDicValueByIds.do',
                        data: idsStr,
                        type: 'post',
                        dataType: 'json',
                        success: function (data) {
                            if (data.code == "1") {
                                window.location.href = "settings/dictionary/value/index.do"
                            } else {
                                alert(data.message)
                            }
                        }
                    })
                }
            })

            //实现全选和取消全选
            $("#chkedAll").click(function () {
                //让列表中所有的复选框属性值和全选按钮的属性值一样
                $("#tBody input[type='checkbox']").prop("checked", $("#chkedAll").prop("checked"))
            })
            //给所有的复选框添加单击事件
            $("#tBody input[type='checkbox']").click(function () {
                //获取总的复选框和选中的复选框进行对比
                if ($("#tBody input[type='checkbox']").size() == $("#tBody input[type='checkbox']:checked").size()) {
                    $("#chkedAll").prop("checked", true)
                } else {
                    $("#chkedAll").prop("checked", false)
                }
            })

            //给编辑按钮添加事件
            $("#editDicValueBtn").click(function () {
                var chkedIds = $("#tBody input[type='checkbox']:checked")
                if (chkedIds.size() == 0) {
                    alert("请选择要编辑的记录")
                    return
                }
                if (chkedIds.size() > 1) {
                    alert("一次只能修改1条记录")
                    return
                }
                var id = chkedIds[0].value

                window.location.href = "settings/dictionary/value/editDIcValue.do?id=" + id
            })
        })
    </script>
</head>
<body>
<div>
    <div style="position: relative; left: 30px; top: -10px;">
        <div class="page-header">
            <h3>字典值列表</h3>
        </div>
    </div>
</div>

<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
    <div class="btn-group" style="position: relative; top: 18%;">
        <button type="button" class="btn btn-primary" id="createDicValueBtn"><span
                class="glyphicon glyphicon-plus"></span> 创建
        </button>
        <button type="button" class="btn btn-default" id="editDicValueBtn"><span
                class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button type="button" class="btn btn-danger" id="deleteDicValueBtn"><span
                class="glyphicon glyphicon-minus"></span> 删除
        </button>
    </div>
</div>
<div style="position: relative; left: 30px; top: 20px;">
    <table class="table table-hover">
        <thead>
        <tr style="color: #B3B3B3;">
            <td><input type="checkbox" id="chkedAll"/></td>
            <td>序号</td>
            <td>字典值</td>
            <td>文本</td>
            <td>排序号</td>
            <td>字典类型编码</td>
        </tr>
        </thead>
        <tbody id="tBody">
        <c:forEach items="${dicValuesList}" var="dv" varStatus="vs">
            <c:if test="${vs.count%2!=0}">
                <tr class="active">
            </c:if>
            <c:if test="${vs.count%2==0}">
                <tr>
            </c:if>
            <td><input type="checkbox" value="${dv.id}"></td>
            <td>${vs.count}</td>
            <td>${dv.value}</td>
            <td>${dv.text}</td>
            <td>${dv.orderNo}</td>
            <td>${dv.typeCode}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>