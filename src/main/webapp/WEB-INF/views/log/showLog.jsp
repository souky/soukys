<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>考试列表</title>
<%@ include file="/WEB-INF/views/version.jsp" %>
</head>
<body>
<div id="logList">

	<div class="Jry_query">
		<div class="query_part">
			<form >
			<div class="query_items">
				<label>用户名称</label>
				<div class="inputDivOne">
					<input type="text" class="" id="userName" name="userName" >
				</div>
			</div>
			<div class="query_items">
				<label>操作事件</label>
				<div class="inputDivOne">
					<input type="text" class="" id="operationEvent" name="operationEvent" >
				</div>
			</div>
			<div class="query_items"></div>
			<div class="query_items">
				<div class="query_btn" onclick="queryLog(1,10)">
					查　询
				</div>
			</div>
			</form>
		</div>
	</div>
	
	<div class="logTable">
		<div class="Jry_table" id="logTables">
			<div class="table_body">
				<table>
					<tr>
						<th>序号</th>
						<th>用户ip</th>
						<th>用户名称</th>
						<th>操作事件</th>
						<th>操作时间</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
	
</div>
</body>
<script type="text/javascript">
	var basepaths = $("#basePath").val();
	var pageSize = 10;
	$(function(){
		queryLog(1,pageSize);
	})
	
	function queryLog(pageNum,pageSize){
        if(isNaN(pageNum)){
            JRYPopup.Jalert("请输入正确的页码");
            return;
        }
        if(pageNum < 1){
            JRYPopup.Jalert("页码应从1开始");
            return;
        }
		var userName = $('#userName').val();
		var operationEvent = $('#operationEvent').val();
		var data = {pageNum:pageNum,pageSize:pageSize,userName:userName,operationEvent:operationEvent};
		$.post(basepaths+'systemlog/querySystemLogs',data,function(html){
			$("#logList .logTable").html(html);
			JRYTable.tableInit('logTables','','choiceNum');
			var pageTotal = $("#pageCss").find(".pageTotal").val();
			JRYPage.pageInit('pageCss',pageNum,pageTotal,11,changePageCheate);
		})
	}
	
	//上一页
	function proPageCheate(){
		var pageNow = $("#pageCss").find(".pageNow").val();
		var pageNums = parseInt(pageNow)-1;
		if(pageNums<1){
			return;
		}else{
			queryLog(pageNums,pageSize);
		}
	}
	//下一页
	function nextPageCheate(){
		var pageNow = $("#pageCss").find(".pageNow").val();
		var pageTotal = $("#pageCss").find(".pageTotal").val();
		var pageNums = parseInt(pageNow)+1;
		if(pageNums > pageTotal){
			return;
		}else{
			queryLog(pageNums,pageSize);
		}
	}

	//分页
	function changePageCheate(obj,pages){
		var pageNums = 1;
		if(pages){
			pageNums = pages;
		}else{
			pageNums = $(obj).text();
		}
		var pageTotal = $("#pageCss").find(".pageTotal").val();
		if(pageNums!='...'){
			pageNums = parseInt(pageNums);
			pageTotal = parseInt(pageTotal);
			if (pageNums>pageTotal) {
                JRYPopup.Jalert("输入的页码超出最大范围");
                return;
			}
			queryLog(pageNums,pageSize);
		}
		
	}

</script>
</html>