<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
    <%@ include file="/WEB-INF/views/version.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/jry-Plug-in.css<%=version%>"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/table/tableList.css<%=version%>"/>
    
</head>
<body>
	<input type="hidden" id="message" value="${message}">
	<input type="hidden" id="basePath" value="<%=basePath%>">
	<div id="tables">
		<div class="Jry_query">
			<div class="query_part">
				<div class="query_items">
					<label>姓名   :</label>
					<div class="inputDivOne">
						 <input name="keyworldClock" id="keyworldClock" type="text" />
					</div>
				</div>
				
				<div class="query_items">
					<label>手机号   :</label>
					<div class="inputDivOne">
						<input name="clockPort" id="clockPort" type="text" />
					</div>
				</div>
				
				<div class="query_items">
					<label>身份证号   :</label>
					<div class="inputDivOne">
						<input name="clockIp" id="clockIp" type="text" />
					</div>
				</div>
				<div class="query_items">
					<div class="query_btns">
						<div class="query_btn" onclick="queryAll()">
							查询
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script  src="<%=basePath%>/static/common/js/jquery-3.1.1.js"></script>
<script src="<%=basePath%>/static/jy/js/common/jry-Plug-in.js"></script>
<script  src="<%=basePath%>/static/jy/js/table/tableList.js<%=version%>"></script>

</html>
