<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        $(() => {
            $("#saveEditDIcTypeBtn").click(() => {
                let code = $("#create-code").val();
                let name = $.trim($("#create-name").val());
                let description = $.trim($("#create-description").val());
                $.post("settings/dictionary/type/saveEditDicType", {
                    code: code,
                    name: name,
                    description: description
                }, (data) => {
                    if (data.code == "1") {
                        location.href = "settings/dictionary/type/index.do"
                    }
                }, "json")
            })
        })
    </script>
</head>
<body>
<div style="position:  relative; left: 30px;">
    <h3>修改字典类型</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button id="saveEditDIcTypeBtn" type="button" class="btn btn-primary">更新</button>
        <button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form class="form-horizontal" role="form">

    <div class="form-group">
        <label for="create-code" class="col-sm-2 control-label">编码<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="create-code" style="width: 200%;" value="${dicType.code}"
                   disabled>
        </div>
    </div>

    <div class="form-group">
        <label for="create-name" class="col-sm-2 control-label">名称</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="create-name" style="width: 200%;" value="${dicType.name}">
        </div>
    </div>

    <div class="form-group">
        <label for="create-description" class="col-sm-2 control-label">描述</label>
        <div class="col-sm-10" style="width: 300px;">
            <textarea class="form-control" rows="3" id="create-description"
                      style="width: 200%;">${dicType.description}</textarea>
        </div>
    </div>

</form>
<div style="height: 200px;"></div>
</body>
</html>