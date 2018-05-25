<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>作弊防控系统</title>
    <%@ include file="/WEB-INF/views/version.jsp" %>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="<%=basePath%>/static/jy/img/favicon.ico"/>
	<link rel="bookmark" href="<%=basePath%>/static/jy/img/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/jry-Plug-in.css<%=version%>"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/main/mainPages.css<%=version%>"/>
</head>
<body>
<input type="hidden" id="basePath" value="<%=basePath%>"/>
<div class="Jry_top">
	<div class="top_title">
		作弊防控系统
	</div>
	<div class="top_user clearfix">
		<div class="fl" style="margin-top:18px;margin-right:5px;">
			<a href="<%=basePath%>logout"><img alt="" src="<%=basePath%>/static/jy/img/pcImg/logout.png"></a>
		</div>
		<div class="fl">
			<a href="<%=basePath%>logout" style="color: #fff">退出</a>
		</div>
	</div>
	<div class="logo">
		<img alt="" src="<%=basePath%>/static/jy/img/pcImg/logo_white.png">
	</div>
</div>

<div class="Jry_context">
	<div class="left_part_context">
		
	</div>
	<div class="right_part_context" data-selects="0">

	</div>
	<c:if test="${authStatistics==1}">
	<div class="goToMain" onclick="javascript:window.location.href='<%=basePath%>data/mainStatistics'">
		>
	</div>
	</c:if>
</div>
<div class="Jry_popup">
</div>
</body>
<script language="javascript" src="<%=basePath%>/static/common/js/jquery-3.1.1.js"></script>
<script language="javascript" src="<%=basePath%>/static/jy/js/common/jry-Plug-in.js<%=version%>"></script>
<script language="javascript" src="<%=basePath%>/static/jy/js/main/mainPages.js<%=version%>"></script>
</html>
