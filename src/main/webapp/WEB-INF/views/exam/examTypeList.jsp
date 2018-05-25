<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>考试类型列表</title>
<%@ include file="/WEB-INF/views/version.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/jy/css/exam/examTypeList.css<%=version%>"/>
</head>
<body>
<div id="examTypeList">
	<div class="showInfo ">
		<div id="showExamTypeList">
			
		</div>
	</div>
	
	<div id="newExamType" class="hide">
		<div class="Jcustom_title">新增考试类型</div>
		<div class="Jcustom_content">
			<form class="SaveType_JRY">
			<div class="Jcustom_content_items ">
				<label>考试类型编号</label>
				<input type="hidden" id="id_JRY" name="id_JRY">
				<input type="text" id="examTypeNo_JRY" name="examTypeNo_JRY" placeholder="请输入考试类型编号">
				<div class="error_text"></div>
			</div>
			<div class="Jcustom_content_items">
				<label>考试类型名称</label>
				<input type="text" id="examTypeName_JRY" name="examTypeName_JRY" placeholder="请输入考试类型名称">
				<div class="error_text"></div>
			</div>
			</form>
			<div class="Jcustom_content_btns">
				<div class="okBtn btns" onclick="typeSaveOrEdit()">确定</div>
				<div class="cancelBtn btns" onclick="examCancelType()">取消</div>
			</div>
		</div>
	</div>
</div>

</body>
<script language="javascript" src="<%=basePath%>/static/common/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="<%=basePath%>static/jy/js/exam/examTypeList.js<%=version%>" charset="UTF-8"></script>
<script>

</script>

</html>