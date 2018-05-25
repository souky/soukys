<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人信息</title>

<%@ include file="/WEB-INF/views/version.jsp"%>
<!-- 引入工具类 -->
<link href="<%=basePath%>/static/common/css/test-email.css" type="text/css" rel="stylesheet"/>
<link href="<%=basePath%>/static/common/css/test-box.css" type="text/css" rel="stylesheet"/>
<link href="<%=basePath%>/static/jy/css/user/userEdit.css<%=version%>" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="Jcustom">
	<div class="Jcustom_content">
		<form id="commentForm">
			<input type="hidden"  value="" name="id" class="userId">
			<input type="hidden" id="basePath" value="<%=basePath%>"/>
			<div class="Jcustom_content_items">
				<label>用户名</label>
				<input type="text" id="userName" name="userName" class="userName" readonly style="cursor: no-drop"/>
			</div>
			<div class="Jcustom_content_items">
				<label>姓名</label>
				<input type="text" id="name" name="name" class="name" placeholder="请输入姓名">
				<div class="error_text"></div>
			</div>
		
			<div class="Jcustom_content_items ">
				<label>性别</label>
				<select id="sex" name="sex" class="sex" placeholder="请输入性别" readonly>
				  <option value="1">女</option>
				  <option value="0">男</option>
				</select>
				<div class="error_text"></div>
			</div>
		
			<div class="Jcustom_content_items ">
				<label>年龄</label>
				 <input type="text" id="age" name="age" class="age" placeholder="请输入年龄">
				<div class="error_text"></div>
			</div>
		
			<div class="Jcustom_content_items">
				<label>邮箱</label>
				<div class="parentCls">
					<input type="text" id="email" name="email" class="email inputElem" placeholder="请输入邮箱">
				</div>
				<div class="error_text"></div>
			</div>
			
			<div class="Jcustom_content_items">
				<label>电话号码</label>
				<input type="text" id="phone" name="phone" class="phone" placeholder="请输入电话号码">
				<div class="error_text"></div>
			</div>
			
			<div class="Jcustom_content_items ">
				<label>地址</label>
				<input type="text" id="address" name="address" class="address" placeholder="请输入地址">
				<div class="error_text"></div>
			</div>
			
			<div class="Jcustom_content_items ">
				<label>机构</label>
				<input type="text" id="orgName" name="orgName" class="orgName" readonly style="cursor: no-drop">
				<div class="error_text"></div>
			</div>	
		</form>
		<div class="Jcustom_content_btns">
			<div class="okBtn btns saveUser" onclick="saveUser()">保存</div>
		</div>
	</div>
</div>
</body>
<script src="<%=basePath%>/static/jy/js/common/test-email.js"></script>
<script src="<%=basePath%>/static/jy/js/common/test-box.js"></script>
<script src="<%=basePath%>/static/jy/js/common/validate.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/jy/js/user/updateUser.js<%=version%>" charset="UTF-8"></script>
</html>