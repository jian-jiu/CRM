$(() => {
    $.ajaxSetup({
        complete: xhr => {
            let data = xhr.responseJSON;
            if (data.code == "0") {
                alert(data.msg);
            }
            if (data.data == "1") {
                window.top.location.href = '';
            }
        }

    })
})