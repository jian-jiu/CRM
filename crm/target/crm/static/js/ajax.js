$(() => {
    $.ajaxSetup({
        complete: xhr => {
            let data = xhr.responseJSON
            if (data.code == "0") {
                alert(data.message)
            }
            if (data.data == "转发到登入界面") {
                window.top.location.href = '';
            }
        }
    })
})