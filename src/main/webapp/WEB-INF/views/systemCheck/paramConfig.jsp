<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>参数配置</title>
<%@ include file="/WEB-INF/views/version.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/jy/css/systemInfo/paramConfig.css<%=version%>"/>
</head>
<body>

<div id="config">
	<div class="title">
		服务控制
	</div>
	<div class="services clearfix">
		<div class="items fl" id="startConnect">
			<div class="ser_name al">通信服务</div>
			<div class="ser_status ac">服务状态中</div>
			<div class="ser_opretion ac CP clearfix">
				<div class="fr" style="margin-right:30px;" onclick="connectServer(0)">
					停止
				</div>
				<div class="ser_opretion_img fr" onclick="connectServer(0)">
					<img alt="" src="<%=basePath%>static/jy/img/pcImg/logout.png">
				</div>
			</div>
		</div>
		<div class="items close fl" id="closeConnect">
			<div class="ser_name al">屏蔽服务</div>
			<div class="ser_status ac">服务关闭</div>
			<div class="ser_opretion ac CP clearfix">
				<div class="fr" style="margin-right:30px;" onclick="connectServer(1)">
					启动
				</div>
				<div class="ser_opretion_img fr" onclick="connectServer(1)">
					<img alt="" src="<%=basePath%>static/jy/img/pcImg/logout.png">
				</div>
			</div>
		</div>
	</div>
	
	<div class="clearfix mt20">
		<%--<div class="title_half_left fl">
			<div class="title">
				平台广播地址
			</div>
			<div>
				<div class="query_items">
					<label>IP地址:</label>
					<div class="inputDivOne">
						<input type="text" class="" id="userName" name="userName" placeholder="请填写IP">
					</div>
				</div>
			</div>
		</div>--%>
		
		
		<div class="title_half_left fl">
			<div class="title">
				工作模式
			</div>
			<div class="right_btns clearfix">
				<div class="right_btn fl ac CP active" id="withDetection">
					有侦测模式
					<div>√</div>
				</div>
				<div class="right_btn fl ac CP fobid" id="noDetection">
					无侦测模式
				</div>
			</div>
		</div>
		
	</div>
	
	<div class="clearfix mt20">
		<%--<div class="title_half_left fl">
			<div class="title">
				网络通讯方式
			</div>
			<div class="right_btns choices clearfix">
				<div class="right_btn fl ac CP active">
					广播
					<div>√</div>
				</div>
				<div class="right_btn fl ac CP ">
					组播(多播)
					<div>√</div>
				</div>
			</div>
		</div>--%>
		
		
		<div class="title_half_left fl">
			<div class="title">
				考前数据初始化
			</div>
			<div class="clear_btn ac CP" style="float: left;margin-left: 5% " onclick="clearDataBeforeExam()">
				清理数据
			</div>
		</div>
		
	</div>
	
	<div class="title mt20">
		关于作弊防控系统
	</div>
	<div>
		<div class="info_text">管理平台：2.0.0</div>
        <div class="info_text">平台服务程序：2.0.0</div>
        <!-- <div class="info_text">实时监听插件：2.0.0</div> -->
        <div class="info_text">安全播放插件：2.0.0</div>
	</div>
</div>

</body>
<script type="text/javascript" src="<%=basePath%>static/jy/js/systemInfo/paramConfig.js<%=version%>" charset="UTF-8"></script>
</html>