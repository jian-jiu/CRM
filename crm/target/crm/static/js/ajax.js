$(() => {
    $.ajaxSetup({
        complete: xhr => {
            let data = xhr.responseJSON
            if (data.code == "0") {
                alert(data.message)
            }
            if (data.data == "ת�����������") {
                window.top.location.href = '';
            }
        }
    })
})