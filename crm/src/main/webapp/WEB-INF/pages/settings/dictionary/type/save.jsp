<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        $(() => {
            $("#create-code").blur(function () {
                checkCode()
            })

            $("#saveCreateDicTypeBtn").click(() => {
                let code = $.trim($("#create-code").val());
                let name = $.trim($("#create-name").val());
                let description = $.trim($("#create-description").val());
                if (checkCode()) {
                    //发送保存数据
                    $.post("settings/dictionary/type/saveCreateDicType", {
                        code: code,
                        name: name,
                        description: description
                    }, (data) => {
                        if (data.code == "1") {
                            location.href = "settings/dictionary/type/index"
                        }
                    }, "json")
                }
            })
        })

        //重新编码是否符合要求
        function checkCode() {
            let codeMsg = $("#codeMsg")
            let code = $.trim($("#create-code").val());
            if (!code) {
                codeMsg.text("编码不能为空")
                return false
            }
            codeMsg.text("")
            //发送请求
            let ret = false;
            $.ajax({
                url: "settings/dictionary/type/checkCode",
                data: {
                    code: code
                },
                type: 'post',
                dataType: 'json',
                async: false,
                complete: false,
                success(data) {
                    if (data.code == "0") {
                        codeMsg.text("")
                        ret = true
                    } else {
                        codeMsg.text(data.msg)
                    }
                }
            })
            return ret
        }
    </script>
</head>
<body>
<div style="position:  relative; left: 30px;">
    <h3>新增字典类型</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button id="saveCreateDicTypeBtn" type="button" class="btn btn-primary">保存</button>
        <button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form class="form-horizontal" role="form">

    <div class="form-group">
        <label for="create-code" class="col-sm-2 control-label">编码<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="create-code" style="width: 200%;">
            <span id="codeMsg" style="color: red"></span>
        </div>
    </div>

    <div class="form-group">
        <label for="create-name" class="col-sm-2 control-label">名称</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" id="create-name" style="width: 200%;">
        </div>
    </div>

    <div class="form-group">
        <label for="create-description" class="col-sm-2 control-label">描述</label>
        <div class="col-sm-10" style="width: 300px;">
            <textarea class="form-control" rows="3" id="create-description" style="width: 200%;"></textarea>
        </div>
    </div>
</form>
<div style="height: 200px;"></div>
</body>
</html>