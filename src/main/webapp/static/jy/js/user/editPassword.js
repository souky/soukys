$(document).ready(function () {
    //密码校验(密码不能为空，密码只能输入字母和数字，输入的新密码和确认密码相同！)

    $(document).on("click", ".savePassword", function () {
        if(!tipMessage("inputPassWord")){
            return;
        }
        if(!tipMessage("newPassWord")){
            return;
        }
        if(!tipMessage("newPassWords")){
            return;
        }
        var newPassWord = $("#newPassWord").val();
        var newPassWords = $("#newPassWords").val();

        if (newPassWord != newPassWords) {
            JRYPopup.Jalert("输入的新密码和确认密码不同！");
            return;
        }

        var data = $('#updatePWD').serialize();
        $.ajax({
            async: false,
            type: "post",
            url: $("#basePath").val() + "user/updatePassword",
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.code == 10000) {
                    JRYPopup.Jalert("密码重置成功");
                } else {
                    JRYPopup.Jalert(data.message);
                }
                $("#inputPassWord").val("");
                $("#newPassWord").val("");
                $("#newPassWords").val("");
            },
            error: function (res) {
                JRYPopup.Jalert("请求密码重置失败");
                $("#inputPassWord").val("");
                $("#newPassWord").val("");
                $("#newPassWords").val("");
            }
        });
    });

});

function tipMessage(id) {
    id = "#" + id;
    var text = $(id).val();
    var msg;
    if (text == null || text.length < 6 || text.length > 16) {
        msg = "密码长度必须在6-16位之间";
        $(id).closest(".Jcustom_content_items").addClass("haserror");
        $(id).parent().find(".error_text").html(msg);
        //清除提示信息
        $(id).focus(function () {
            $(id).parent().find(".error_text").html("");
            $(id).closest(".Jcustom_content_items").removeClass("haserror");
        });
        return false;
    }

    var pattern = /^[0-9a-zA-Z]*$/;
    if (!pattern.test(text)) {
        msg = "密码只能由字母和数字组成";
        $(id).closest(".Jcustom_content_items").addClass("haserror");
        $(id).parent().find(".error_text").html(msg);
        //清除提示信息
        $(id).focus(function () {
            $(id).parent().find(".error_text").html("");
            $(id).closest(".Jcustom_content_items").removeClass("haserror");
        });
        return false;
    }
    return true;
}