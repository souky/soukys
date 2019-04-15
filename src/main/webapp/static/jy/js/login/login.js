
$(function(){
	document.onkeydown = function (event) {
        var e = event || window.event;
        if (e && e.keyCode == 13) { //回车键的键值为13
        	login_in(); //调用登录按钮的登录事件
        }
    }; 
})

function login_in(){
	var username = $("#username");
	var password = $("#password");
	if(username.val()){
		username.parent().find('.error').html('');
		username.css("border-color","#dedede");
	}else{
		username.parent().find('.error').html('请输入用户名');
		username.css("border-color","#f40");
		return;
	}
	
	if(password.val()){
		password.parent().find('.error').html('');
		password.css("border-color","#dedede");
	}else{
		password.parent().find('.error').html('请输入密码');
		password.css("border-color","#f40");
		return;
	}
	
	var data = {userName:username.val(),passwrod:password.val()};
	
	$.ajax({
		type:'POST',
		url:$("#basePath").val() + "login/loginIn",
		data:data,
		dataType:"json",
		success:function(res) {
			var code = res.code;
			console.log(code)
			if (code == '10000') {
				window.location.href = $("#basePath").val()+"auditionform/pages"
			} else {
				console.log(1)
				JRYPopup.Jalert(res.message);
				console.log(2)
			}

		},
		error:function() {
			JRYPopup.Jalert("网络错误");
		}
	});
}
