<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
    <%@ include file="/WEB-INF/views/version.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/jry-Plug-in.css<%=version%>"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/login/loginNew.css<%=version%>"/>
    
</head>
<body id="login">
	<input type="hidden" id="message" value="${message}">
	<input type="hidden" id="basePath" value="<%=basePath%>">
	<div class="mainLogin clearfix">
		<div class="fl loginImg">
			<img src="<%=basePath%>/static/jy/img/pcImg/loginLeft.png" />
		</div>
		<div class="fl loginLine" ></div>
		<div class="fl loginInput">
			<div class="title ac">
				登录
			</div>
			<div class="loginBody ">
				<form id="loginForm" >
					<div class="clearfix">
						<div class="loginItems fl">
							<input id="username" name="username" type="text" placeholder="请输入用户名"/>	
						</div>
						<div class="loginItems fl">
							<input type="password" id="password" name="password" placeholder="请输入密码"/>	
						</div>
					</div>
					
					<div class="loginButton" onclick="login_in()">
						登录
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="Jry_popup"></div>
	
	<div id="addOrg" class="hide">
		<div class="Jcustom_title">选择机构</div>
		<div class="Jcustom_content">
			<form class="saveAndEdit_JRY">
				<div class="Jcustom_content_items ">
					<div><label>当前是否为考点</label></div>
					<input style="height:40px;width:20px;padding-top: 9px;margin-left:10px" type="radio" id="isExamSpot" name="isExamSpot_JRY" value="Y">
					<div><label style="width:30px;margin-right:20px">是</label></div>
					<input style="height:40px;width:20px;margin-left:20px" type="radio" id="isExamSpot_JRY" name="isExamSpot" value="N">
					<div><label style="width:30px;">否</label></div>
					<div class="error_text"></div>
				</div>
				<div class="Jcustom_content_items ">
					<label>省/直辖市</label>
					<select id="province_JRY" name="provinceCode" class="province" onchange="changeCity(this.value)">
					  <option value="" selected>--请选择--</option>
					</select>
					<div class="error_text"></div>
				</div>
				<div class="Jcustom_content_items ">
					<label>城市</label>
					<select id="city_JRY" name="cityCode" onchange="changeArea(this.value)">
					  <option value="" selected>--请选择--</option>
					</select>
					<div class="error_text"></div>
				</div>
				<div class="Jcustom_content_items ">
					<label>区/县</label>
					<select id="area_JRY" name="areaCode">
					  <option value="" selected>--请选择--</option>
					</select>
					<div class="error_text"></div>
				</div>
				<div class="Jcustom_content_items">
					<label>当前机构名称</label>
					<input type="text" id="orgName" name="orgName_JRY" placeholder="请输入组织机构名称">
					<div class="error_text"></div>
				</div>
				<div class="Jcustom_content_items">
					<label>当前机构ip</label>
					<input type="text" id="orgIP" name="orgIp_JRY" placeholder="请输入组织机构ip">
					<div class="error_text"></div>
				</div>
			</form>
			<div class="Jcustom_content_btns">
				<div class="okBtn btns" onclick="orgSave()">确定</div>
				<div class="cancelBtn btns" onclick="orgCancel()">取消</div>
			</div>
		</div>
	</div>
</body>
<script  src="<%=basePath%>/static/common/js/jquery-3.1.1.js"></script>
<script  src="<%=basePath%>/static/jy/js/common/jry-Plug-in.js<%=version%>"></script>
<script  src="<%=basePath%>/static/jy/js/login/login.js<%=version%>"></script>

</html>
