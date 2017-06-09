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
    <link rel="stylesheet" href="resources/css/base.css">
<style type="text/css">


</style>
</head>
<body>
	<form id="loginForm">
        <input type="text" name="loginName">
        <input type="text" name="passWord">   
    </form>
    <input type="button" value="fuck" onclick="loginIn()" />
</body>


<script type="text/javascript" src="resources/js/zepto.min.js"></script>
<script>
function loginIn(){
	var data = $("#loginForm").serialize();	
	$.ajax({
		url:'loginIn.html',
		data:data,
		type:'post',
		success:function(res){
			console.log(res);
		},
		error:function(res){
			console.log(res);
		}
	})
}

</script>

</html>