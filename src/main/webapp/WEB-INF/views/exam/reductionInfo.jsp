
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>还原信号</title>
<%@ include file="/WEB-INF/views/version.jsp" %>
<link href="<%=basePath%>/static/jy/css/common/audioplayer.css" rel="stylesheet">
<style type="text/css">
.Jry_popup .Jcustom{
	margin:12% auto;
}
</style>
</head>
<body>
<div id="cheateList">

	<div class="Jry_query">
		<div class="query_part">
			<form >
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
			<div class="query_items">
				<label>文件类型</label>
				<div class="inputDivOne">
					<select class="" id="suffix" name="suffix">
				    	<option value="">全部类型</option>
				    	<option value="wav">音频文件</option>
				    	<option value="txt">数传文件</option>
				    	<option value="0">未知</option>
				    </select>
				</div>
			</div>
			<div class="query_items">
				<label>信号类型</label>
				<div class="inputDivOne">
					<select class="" id="signalType" name="signalType">
				    	<option value="">全部类型</option>
				    	<option value="1">语音</option>
				    	<option value="2">文本</option>
				    	<option value="0">未知</option>
				    </select>
				</div>
			</div>
			<div class="query_items">
				<label>频点范围</label>
				<div class="inputDivThree">
					<input type="text" class="" id="frequencyPointBegin" name="frequencyPointBegin" placeholder="起始范围">
					<div>-</div>
					<input type="text" class="" id="frequencyPointEnd" name="frequencyPointEnd" placeholder="终止范围">
				</div>
			</div>
			<div class="query_items">
				<label>识别结果</label>
				<div class="inputDivOne">
					<select class="" id="recognitionResult" name="recognitionResult">
				    	<option value="">全部结果</option>
				    	<option value="1">确认作弊</option>
				    	<option value="2">非作弊</option>
				    	<option value="0">未知</option>
				    </select>
				</div>
			</div>
			<div class="query_items"></div>
			<div class="query_items">
				<div class="query_btn" onclick="queryCheate(1,10)">
					查　询
				</div>
			</div>
			</form>
		</div>
	</div>
	
	<div class="cheateTable">
		<div class="Jry_table" id="cheateTables">
			<div class="table_body">
				<table>
					<tr>
						<th></th>
						<th>序号</th>
						<c:if test="${isUpperOrg}">
							<th>组织机构</th>
						</c:if>
						<th>考试名称</th>
						<th>考场(场次)</th>
						<th>频点</th>
						<th>文件类型</th>
						<th>信号类别</th>
						<th>识别结果</th>
						<th>还原时间</th>
						<th>操作</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
	
	<div id="wrapper_JRY" style="margin:25% auto;display:none;">
		<div id="play_JRY">
		</div>
		<input type="hidden" value="<%=listenPath%>" id="listenPath">
	</div>
	
	
	<div id="readTxt" class="hide">
		<div class="Jcustom_title">文件预览</div>
		<div class="Jcustom_content">
			<div id="readTxtId_JRY" style="width:80%;margin:auto;text-align:center;">
							
			</div>			
			<div class="Jcustom_content_btns">
				<div class="okBtn btns" onclick="cancelRead()">确定</div>
				<div class="cancelBtn btns" onclick="cancelRead()">取消</div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript" src="<%=basePath%>static/jy/js/common/audioplayer.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>static/jy/js/exam/reductionInfo.js<%=version%>" charset="UTF-8"></script>
</html>