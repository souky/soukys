<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


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
			<c:if test="${not empty logList}"> 
			<c:forEach items="${logList}"  var="e" varStatus="stu">
			<tr>
				<td>${stu.index+1 }</td>
				<td>${e.operationIp }</td>
				<td>${e.user.userName }</td>
				<td>${e.operationEvent }</td>
				<td><fmt:formatDate value="${e.operationTime }" pattern="YYYY-MM-dd HH:mm:ss" /></td>
			</tr>
			</c:forEach>
			</c:if>
		</table>
	</div>
</div>


<div class="Jry_page" id="pageCss">
	<input type="hidden" class="pageNow" value="${pageNow }"/>
	<input type="hidden" class="pageTotal" value="${pageTotal }"/>
	<div class="page_body">
		<div class="prev_page" onclick="proPageCheate()">上一页</div>
		<div class="maps_page"></div>
		<div class="next_page" onclick="nextPageCheate()">下一页</div>
		<div class="jump_page">
			跳转到<input type="text" maxlength="3">页
		</div>
		<div class="jump_button">GO</div>
	</div>
</div>



