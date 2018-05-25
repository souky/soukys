<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>考后信息处理</title>
<%@ include file="/WEB-INF/views/version.jsp" %>
</head>
<body>
<div id="packageInfoList">
	<input id="listen" type="hidden" value="<%=listenPath%>">
	<div class="Jry_query">
		<div class="query_part">
			<form id="packForm">
			<div class="query_items">
				<label>考试名称</label>
				<div class="inputDivOne">
					<select class="" id="examPlanId" name="examPlanId">
				    	<option value="">请选择考试名称</option>
				    </select>
				</div>
			</div>
			<div class="query_items">
				<label>考试场次</label>
				<div class="inputDivOne">
					<select class="" id="examNumberId" name="examNumberId">
				    	<option value="">全部场次</option>
				    </select>
				</div>
			</div>
			<div class="query_items"></div>
			<div class="query_items">
				<div class="query_btn" onclick="savePackage()">
					打　包
				</div>
			</div>
			</form>
		</div>
	</div>
	
	<div class="packageTable">
		<div class="Jry_table" id="packageInfo">
			<div class="table_body">
				<table>
					<tr>
						<th></th>
						<th>序号</th>
						<th>文件名</th>
						<th>考试类型</th>
						<th>考试场次</th>
						<th>打包状态</th>
						<th>开始时间</th>
						<th>完成时间</th>
						<th>文件数</th>
						<th>文件包大小</th>
						<th>异常信息</th>
						<th>操作</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript" src="<%=basePath%>static/jy/js/exam/packageInfo.js<%=version%>" charset="UTF-8"></script>

</html>