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
	
	if(username.val() == 'lvyadi' && password.val() == 'zuipiaoliang'){
		console.log('成功上朝');
	}
}