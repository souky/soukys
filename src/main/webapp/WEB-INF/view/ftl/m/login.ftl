<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
    <title>商户后台登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
    <meta name="author" content="Souky" />
    <meta name="copyright" content="Souky" />
    <meta name="keywords" content="Souky"/>
    <link rel="shortcut icon" href="resources/favicon.ico"/>
	<link rel="bookmark" href="resources/favicon.ico"/>
    <link rel="stylesheet" href="resources/css/common/base.css?${(v_souky)!}">
    <link rel="stylesheet" href="resources/css/common/souky.css?${(v_souky)!}">
<style type="text/css">
#loginM{height:100%;width:100%;background:rgba(0,0,0,0.82);}
#loginM .soukyForm{margin-top:150px;color:#fff;}
#loginM .soukyForm input{background:rgba(0,0,0,0);color:#fff;}
#loginM .soukyForm .btn{border-color:#fff;color:#fff;}
</style>
</head>
<body class="wm YH">
	<nav class="clearfix">
		<div class="titleNav">
			后台登录
			<div class="navLeft">
				<img class="leftArrow" />
			</div>
			<div class="navRight" onclick="refresh()">
				<img class="refresh"/>
			</div>
		</div>
	</nav>
	<div id="loginM" class="afterNav">
		<form class="soukyForm">
			<div class="textInput">
				<label>用户名:</label>
				<input id="loginName" name="loginName" type="text" placeholder="填写用户名" />
			</div>
			<div class="textInput">
				<label>密　码:</label>
				<input id="passWord" name="passWord" type="password" placeholder="填写密码" />
			</div>
			<div class="loginBtn btn" onclick="">
				登　录
			</div>
			<div class="registerBtn btn">
				注　册
			</div>
		</form>
	</div>
</body>


<script type="text/javascript" src="resources/js/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/common/souky.js?${(v_souky)!}"></script>
<script>

$(function(){
	//S.Toast.show('info','测试内容',1500);
	//S.Loading.start('hasClose','正在加载');
})

function loginIn(){
	var data = $("#loginForm").serialize();	
	$.ajax({
		url:'loginIn',
		data:data,
		type:'post',
		dataType:'json',
		success:function(res){
			var code = res.code;
			if(code=="1000"){
				window.location.href = "index";
			}else{
				S.Toast.show('error',res.message,1500);
			}
		},
		error:function(res){
			S.Toast.show('error',"网络错误",1500);
		}
	});
}

function refresh(){
	window.location.href = window.location.href;
}

</script>

</html>