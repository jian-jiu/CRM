<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../../HeadPart.jsp" %>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <script type="text/javascript">
        $(() => {
            //给更新按钮添加点击事件
            $("#saveEditDicValue").click(() => {
                let id = $("#edit-id").val();
                let value = $.trim($("#edit-dicValue").val());
                let text = $.trim($("#edit-text").val());
                let orderNo = $.trim($("#edit-orderNo").val());
                //判断参数
                if (!value) {
                    alert("字典值不能为空")
                    return
                }
                $.post("settings/dictionary/value/saveEditDicValue", {
                    id: id,
                    value: value,
                    text: text,
                    orderNo: orderNo
                }, (data) => {
                    if (data.code == "1") {
                        location.href = "settings/dictionary/value/index.do"
                    } else {
                        alert(data.msg)
                    }
                }, "json")
            })
        })
    </script>
</head>
<body>
<div style="position:  relative; left: 30px;">
    <h3>修改字典值</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button id="saveEditDicValue" type="button" class="btn btn-primary">更新</button>
        <button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form class="form-horizontal" role="form">
    <input type="hidden" id="edit-id" value="${dicValue.id}">
    <div class="form-group">
        <label for="edit-dicValueCode" class="col-sm-2 control-label">字典类型</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="edit-dicValueCode" style="width: 200%;"
                   value="${dicValue.typeCode}" readonly>
        </div>
    </div>

    <div class="form-group">
        <label for="edit-dicValue" class="col-sm-2 control-label">字典值<span style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="edit-dicValue" style="width: 200%;"
                   value="${dicValue.value}">
        </div>
    </div>

    <div class="form-group">
        <label for="edit-text" class="col-sm-2 control-label">文本</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="edit-text" style="width: 200%;" value="${dicValue.value}">
        </div>
    </div>

    <div class="form-group">
        <label for="edit-orderNo" class="col-sm-2 control-label">排序号</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="number" class="form-control" id="edit-orderNo" style="width: 200%;"
                   value="${dicValue.orderNo}">
        </div>
    </div>
</form>

<div style="height: 200px;"></div>
</body>
</html>