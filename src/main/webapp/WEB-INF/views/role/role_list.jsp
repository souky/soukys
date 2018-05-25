<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<meta charset="UTF-8">
<title>角色管理</title>
<%@ include file="/WEB-INF/views/version.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/page.css"/>
<link rel="stylesheet" href="<%=basePath%>/static/common/css/ztree/zTreeStyle/zTreeStyle.css" type="text/css">
<link href="<%=basePath%>/static/jy/css/role/roleList.css<%=version%>" rel="stylesheet" type="text/css">
</head>
<body>
<input type="hidden" id="basePath" value="<%=basePath%>"/>
<!-- 数据展现 -->	
<div class="Jry_table" id="roleTable">
	<div class="buttons">
		<div class="btns addnew_btn">
			<div class="imgButton">
				<img src="<%=basePath%>/static/jy/img/pcImg/add.png">
			</div>
			<div class="textButton" id="addRecord" onclick="addRole()">新增</div>
		</div>
		<div class="btns delet_btn">
			<div class="imgButton">
				<img src="<%=basePath%>/static/jy/img/pcImg/delete.png">
			</div>
			<div class="textButton">删除</div>
		</div>
	</div>
	<div class="table_body">
		<table class="roleData">
			<tr>
				<td><input type="checkbox" class="selectAll" name="checkAll"/></td>
				<td>序号</td>
				<td>角色名称</td>
				<td>备注</td>
				<td>操作</td>
			</tr>
			<!-- 展现数据-拼接 -->
		</table>
	</div>
</div>

<!-- 分页 -->
<div class="Jry_page" id="pageIconJs">
	<!-- 当前页 -->
	<input type="hidden" class="pageNow"/>
	<!-- 总页数 -->
	<input type="hidden" class="pageTotal"/>
	<div class="page_body">
		<div class="prev_page" onclick="roleProPage()">上一页</div>
		<div class="maps_page"></div>
		<div class="next_page" onclick="roleNextPage()">下一页</div>
		<div class="jump_page">
		<!-- 现在数据库一共有12条数据，每页要求是5条记录，所以最大页数为3页。 -->
			跳转到<input type="text" maxlength="3">页
		</div>
		<div class="jump_button">GO</div>
	</div>
</div>

<!-- 新增修改弹出框 -->
<div id="addEditRole" class="hide">
	<div class="Jcustom_title addOrEdit">新增角色</div>
	<div class="Jcustom_content">
		<form class="commentForm" action="">
			<input type="hidden" name="id_JRY" class="roleId"/>
			<div class="Jcustom_content_items">
				<label>角色名称</label>
				<input type="text" id="roleName_JRY" name="roleName_JRY" class="roleName" placeholder="请输入角色名称">
				<div class="error_text roleNameError" style="text-align:left;"></div>
			</div>
			<div class="Jcustom_content_items ">
				<label>备注</label>
				<input type="text" id="remark_JRY" name="remark_JRY" class="remark" placeholder="请输入备注">
				<div class="error_text remarkError" style="text-align:left;"></div>
			</div>
		</form>
		<div class="Jcustom_content_btns">
			<div class="okBtn btns" onclick="roleSaveEdit()">保存</div>
			<div class="cancelBtn btns" onclick="roleCancel()">取消</div>
		</div>
	</div>
</div>

<!-- 角色授权 -->
<div id="roleAuthorization" class="hide">
	<div class="Jcustom_title">角色授权</div>
	<div class="Jcustom_content">
	    <div class="zTreeDemoBackground left">
	        <input type="hidden" id="roleId"/>
	        <ul id="treeDemo_JRY" class="ztree"></ul>
	    </div>
		<div class="Jcustom_content_btns">
			<div class="okBtn btns" onclick="grentPermissions()">保存</div>
			<div class="cancelBtn btns" onclick="roleCancel()">取消</div>
		</div>
	</div>
</div>

</body>
<script type="text/javascript" src="<%=basePath%>/static/common/js/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/common/js/ztree/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/jy/js/role/role_list.js<%=version%>"></script>
<script src="<%=basePath%>/static/jy/js/common/validate.js"></script>
</html>
