<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/header.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/login/loginNew.css<%=version%>"/>
<body id="login">
	<div class="title_fixed ac">POWER BY SOUKY</div>
	<input type="hidden" id="message" value="${message}">
	<input type="hidden" id="basePath" value="<%=basePath%>">
	<div class="mainLogin clearfix">
		<div class="fl loginInput">
			<div class="title ac">
				查看奏折
			</div>
			<div class="loginBody ">
				<form id="loginForm" >
					<div class="clearfix">
						<div class="loginItems fl">
							<input id="username" name="username" type="text" placeholder="请输入用户名"/>	
							<div class="error"></div>
						</div>
						<div class="loginItems fl">
							<input type="password" id="password" name="password" placeholder="请输入密码"/>	
							<div class="error"></div>
						</div>
					</div>
					
					<div class="loginButton" onclick="login_in()">
						上朝
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="bottomImg ">
		<div class="imgCenter clearfix">
			<div class="imgItems fl ac">
				<img src="<%=basePath%>/static/jy/img/floor/floor1.png" style="width:100%">
			</div>
			<div class="imgItems fl ac">
				<img src="<%=basePath%>/static/jy/img/floor/floor2.png" style="width:100%">
			</div>
			<div class="imgItems fl ac">
				<img src="<%=basePath%>static/jy/img/floor/floor3.png" style="width:100%">
			</div>
			<div class="imgItems fl ac">
				<img src="<%=basePath%>/static/jy/img/floor/floor4.png" style="width:100%">
			</div>
			<div class="imgItems fl ac">
				<img src="<%=basePath%>/static/jy/img/floor/floor5.png" style="width:100%">
			</div>
		</div>
	</div>
	
	<div class="Jry_popup"></div>
</body>
<script  src="<%=basePath%>/static/common/js/jquery-3.1.1.js"></script>
<script  src="<%=basePath%>/static/jy/js/common/jry-Plug-in.js"></script>
<script  src="<%=basePath%>/static/jy/js/login/login.js<%=version%>"></script>

</html>
