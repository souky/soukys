<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


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
			<c:if test="${not empty packageinfoList}"> 
			<c:forEach items="${packageinfoList}"  var="e" varStatus="stu">
			<tr>
				<td data-id="${e.id }"><input type="checkbox" name="choiceNum" /></td>
				<td>${stu.index+1 }</td>
				<td style="width:500px;" class="cells">${e.fileName }</td>
				<td>${e.examName }</td>
				<td>${e.examSubName}</td>
				<c:if test="${e.endTime == '' || e.endTime == null }">
					<td>正在打包</td>			
				</c:if>
				<c:if test="${e.endTime != '' && e.endTime != null }">
					<td>打包完成</td>			
				</c:if>
				<td><fmt:formatDate value="${e.startTime }" pattern="YYYY-MM-dd HH:mm:ss" /></td>
				<td><fmt:formatDate value="${e.endTime }" pattern="YYYY-MM-dd HH:mm:ss" /></td>
				<td>${e.fileNumbers }</td>
				<c:if test="${e.fileSize < 1024}">
					<td>${e.fileSize}B</td>
				</c:if>
				<c:if test="${e.fileSize > 1024 && e.fileSize < (1024*1024)}">
					<td><fmt:formatNumber value="${e.fileSize/1024}"  pattern="0.000" />KB</td>
				</c:if>
				<c:if test="${e.fileSize > (1024*1024) && e.fileSize < (1024*1024*1024)}}">
					<td><fmt:formatNumber value="${e.fileSize/(1024*1024)}"  pattern="0.000" />MB</td>
				</c:if>
				<c:if test="${e.fileSize > (1024*1024*1024)}}">
					<td><fmt:formatNumber value="${e.fileSize/(1024*1024*1024)}"  pattern="0.000" />GB</td>
				</c:if>
				<td>${e.remark }</td>
				<td>
					<img title="删除" onclick="deletePackage('${e.id }')" class="tdImg" src="${basePath }/static/jy/img/pcImg/delete.png" />
					<img title="下载" data-url="${e.id }" onclick="downloadPackage(this)" class="tdImg" src="${basePath }/static/jy/img/pcImg/dis_issued.png" />
				</td>
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



