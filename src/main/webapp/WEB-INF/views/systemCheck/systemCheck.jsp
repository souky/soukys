<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>系统检测</title>
		<%@ include file="/WEB-INF/views/version.jsp" %>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/systemInfo/systemCheck.css"/>
	</head>
	<body>
		<input type="hidden" id="basePath" value="<%=basePath%>"/>
		<div class="" id="testTable">
			<div class="table_body">
				<table id="table_1" style="margin-top:50px;">
					<tbody>
						<tr>
							<td id="lastCheckTime"><p>上次检测时间:</p><p class="lastCheckTimeP"></p></td>
							<td>
								<div class="lastCheckTimebutton" onclick="loadData()"><span>检测</span></div>
								<!-- <div class="lastCheckTimebutton"><span>导出文档</span></div> -->
							</td>
						</tr>
						<tr>
							<td colspan="2" class="title1 title-margin">
								管理平台
							</td>
						</tr>
						<tr>
							<td class="table-small-img online" colspan="2">
								<img src="<%=basePath%>static/jy/img/pcImg/duihao.png" height="25px" width="25px"/>
								<p class="f-left">作弊防控系统通信服务:</p><p id="communicationServer"></p>
							</td>
						</tr>
						<tr>
							<td class="table-small-img online" colspan="2">
								<img src="<%=basePath%>static/jy/img/pcImg/duihao.png" height="25px" width="25px"/>
								<p class="f-left">基础平台级联数据同步服务:</p><p id="syncServer"></p>
							</td>
						</tr>
						<tr>
							<td class="table-small-img online" colspan="2">
								<img src="<%=basePath%>static/jy/img/pcImg/duihao.png" height="25px" width="25px"/>
								<p class="f-left">基础平台服务器心跳服务:</p><p id="heartBreathServer"></p>
							</td>
						</tr>
						<tr>
							<td class="table-small-img online" colspan="2">
								<img src="<%=basePath%>static/jy/img/pcImg/duihao.png" height="25px" width="25px"/>
								<p class="f-left">基础平台服务器时钟同步服务:</p><p id="clockSyncServer"></p>
							</td>
						</tr>
						<tr>
							<td class="table-small-img" id="diskDetail" colspan="2">
								<img src="<%=basePath%>static/jy/img/pcImg/yuangantan.png" height="25px" width="25px"/>
								<p>作弊防控服务器存储空间(磁盘)使用情况:</p><p class="disk"></p>
							</td>
						</tr>
						<tr>
							<td class="table-small-img" id="platformServerTime" colspan="2">
								<img src="<%=basePath%>static/jy/img/pcImg/yuangantan.png" height="25px" width="25px"/>
								<p>作弊防控系统管理平台服务器时间:</p><p class="fuwu-time"></p>
							</td>
						</tr>
						<tr>
							<td class="table-small-img examPlan" colspan="2">
								<img src="<%=basePath%>static/jy/img/pcImg/duihao.png" height="25px" width="25px"/>
								<p class="exitsPlan">当前平台是否已有启用的考试计划:</p><p id="examPlanPText"></p>
							</td>
						</tr>
					</tbody>
				</table>
				<table id="table_2">
					<tbody>
						<tr>
							<td class="title1 title-margin" id="detectionEquipment">
								侦测设备<span></span>
							</td>
						</tr>
						<tr>
							<td class="now-p table-small-img">
								<img src='<%=basePath%>static/jy/img/pcImg/gantanhao.png' height='25px' width='25px'/>
								当前程序状态:<span></span>
							</td>
						</tr>
						<tr>
							<td class="now-p table-small-img">
								<img src='<%=basePath%>static/jy/img/pcImg/yuangantan.png' height='25px' width='25px'/>
								最新一次自检时间:<span></span>
							</td>
						</tr>
						<tr>
							<td class="now-p table-small-img">
								<img src='<%=basePath%>static/jy/img/pcImg/yuangantan.png' height='25px' width='25px'/>
								设备工作状态:<span></span>
							</td>
						</tr>
						<tr>
							<td class="now-p table-small-img">
								<img src='<%=basePath%>static/jy/img/pcImg/yuangantan.png' height='25px' width='25px'/>
								最新一次上报时侦测服务器时间:<span></span>
							</td>
						</tr>
						<tr>
							<td class="now-p table-small-img">
								<img src='<%=basePath%>static/jy/img/pcImg/duihao.png' height='25px' width='25px'/>
								考试计划与平台是否同步:<span></span>
							</td>
						</tr>
						<tr>
							<td class="now-p table-small-img">
								<img src='<%=basePath%>static/jy/img/pcImg/duihao.png' height='25px' width='25px'/>
								黑白名单与平台是否同步:<span></span>
							</td>
						</tr>
						<tr>
							<td class="now-p table-small-img">
								<img src='<%=basePath%>static/jy/img/pcImg/yuangantan.png' height='25px' width='25px'/>
								背景信号自动学习次数:<span></span>
							</td>
						</tr>
					</tbody>
				</table>
				<table id="table_3">
					<tr>
						<td class="title1">
							屏蔽设备
						</td>
					</tr>
					<tr>
						<td class="now-p table-small-img">
							<img src='<%=basePath%>static/jy/img/pcImg/gantanhao.png' height='25px' width='25px'/>
							阻断设备数量:注册 <span></span> 台,在线 <span></span> 台,离线 <span></span> 台
						</td>
					</tr>
					<tr>
						<td class="now-p table-small-img">
							<img src='<%=basePath%>static/jy/img/pcImg/duihao.png' height='25px' width='25px'/>
							所有阻断设备固件一致
						</td>
					</tr>
					<tr>
						<td class="now-p table-small-img">
							<img src='<%=basePath%>static/jy/img/pcImg/duihao.png' height='25px' width='25px'/>
							阻断设备IP地址重复数量:<span></span> 台
						</td>
					</tr>
					<tr>
						<td class="now-p table-small-img">
							<img src='<%=basePath%>static/jy/img/pcImg/duihao.png' height='25px' width='25px'/>
							阻断设备MAC地址重复数量:<span></span> 台
						</td>
					</tr>
					<tr>
						<td class="now-p table-small-img">
							<img src='<%=basePath%>static/jy/img/pcImg/duihao.png' height='25px' width='25px'/>
							阻断设备考场位置重复数量:<span></span> 台
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="<%=basePath%>static/jy/js/systemInfo/systemCheck.js<%=version%>" charset="UTF-8"></script>
</html>