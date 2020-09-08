<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="../../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        $(() => {
            $("#saveCreateDicTypeBtn").click(() => {
                //收集参数
                let typeCode = $("#create-dicTypeCode").val();
                let value = $.trim($("#create-dicValue").val());
                let text = $.trim($("#create-text").val());
                let orderNo = $.trim($("#create-orderNo").val());
                //判断参数
                if (!typeCode) {
                    alert("类型编码不能为空")
                    return
                }
                if (!value) {
                    alert("字典值不能为空")
                    return;
                }
                $.post("settings/dictionary/value/saveCreateDicValue", {
                    typeCode: typeCode,
                    value: value,
                    text: text,
                    orderNo: orderNo
                }, (data) => {
                    if (data.code == "1") {
                        location.href = "settings/dictionary/value/index"
                    }
                }, "json")
            })
        })
    </script>
</head>
<body>
<div style="position:  relative; left: 30px;">
    <h3>新增字典值</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button id="saveCreateDicTypeBtn" type="button" class="btn btn-primary">保存</button>
        <button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form class="form-horizontal" role="form">

    <div class="form-group">
        <label for="create-dicTypeCode" class="col-sm-2 control-label">字典类型编码<span style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <select class="form-control" id="create-dicTypeCode" style="width: 200%;">
                <option></option>
                <c:forEach items="${dicTypesList}" var="dt">
                    <option value="${dt.code}">${dt.code}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="create-dicValue" class="col-sm-2 control-label">字典值<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="create-dicValue" style="width: 200%;">
        </div>
    </div>

    <div class="form-group">
        <label for="create-text" class="col-sm-2 control-label">文本</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="create-text" style="width: 200%;">
        </div>
    </div>

    <div class="form-group">
        <label for="create-orderNo" class="col-sm-2 control-label">排序号</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="number" class="form-control" oninput="value=value.replace(/[^\d]/g,'')" id="create-orderNo" style="width: 200%;">
        </div>
    </div>
</form>

<div style="height: 200px;"></div>
</body>
</html>