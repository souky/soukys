<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/version.jsp"%>
<link href="<%=basePath%>/static/common/css/test-box.css" type="text/css" rel="stylesheet"/>
<link href="<%=basePath%>/static/jy/css/user/editPassword.css<%=version%>" type="text/css" rel="stylesheet"/>

</head>
<body>
<div class="Jcustom">
	<div class="Jcustom_content">
		<form id="updatePWD" >
            <input type="hidden" id="basePath" value="<%=basePath%>"/>
			<div class="Jcustom_content_items">
				<label>原密码</label>
				<input type="password" id="inputPassWord" name="inputPassWord" class="inputPassWord" placeholder="请输入原密码">
				<div class="error_text"></div>
			</div>
			
			<div class="Jcustom_content_items">
				<label>新密码</label>
				<input type="password" id="newPassWord" name="newPassWord" class="newPassWord" placeholder="请输入新密码">
				<div class="error_text"></div>
			</div>
			
			<div class="Jcustom_content_items">
				<label>确认新密码</label>
				<input type="password" id="newPassWords" name="newPassWords" class="newPassWords" placeholder="请确认新密码">
				<div class="error_text"></div>
			</div>
        </form>
        <div class="Jcustom_content_btns">
			<div class="okBtn btns savePassword">保存</div>
	    </div>
	</div>
</div>
</body>
<script src="<%=basePath%>/static/jy/js/common/validate.js"></script>
<script src="<%=basePath%>/static/jy/js/common/test-box.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/jy/js/user/editPassword.js<%=version%>" charset="UTF-8"></script>
</html>
