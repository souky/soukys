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

</style>
</head>
<body class="wm YH">
	<nav class="clearfix">
		<div class="titleNav">
			后台登录
			<div class="navLeft">
				<img class="leftArrow" />
			</div>
			<div class="navRight">
				<img class="refresh"/>
			</div>
		</div>
	</nav>
	<div id="loginM" class="afterNav">
		<form id="loginForm">
	        <input type="text" name="loginName">
	        <input type="text" name="passWord">   
	    </form>
	    <input type="button" value="fuck" onclick="loginIn()" />
	</div>
	
</body>


<script type="text/javascript" src="resources/js/zepto.min.js"></script>
<script type="text/javascript" src="resources/js/common/souky.js?${(v_souky)!}"></script>
<script>

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
				var location = window.location.href;
				var locations = location.split("/")[(location.split("/").length-1)];
				if(locations=="login"){
					window.location.href = "index";
				}else{
					window.location.href=window.location.href;
				}
				
			}else{
				alert(res.message);
			}
		},
		error:function(res){
			alert("网络错误");
		}
	})
	
}

</script>

</html>