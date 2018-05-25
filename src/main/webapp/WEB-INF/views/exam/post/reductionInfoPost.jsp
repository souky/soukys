<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


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
				<th>考场</th>
				<th>频点</th>
				<th>文件类型</th>
				<th>信号类别</th>
				<th>识别结果</th>
				<th>还原时间</th>
				<th>操作</th>
			</tr>
			<c:if test="${not empty reductionInfoList}"> 
			<c:forEach items="${reductionInfoList}"  var="e" varStatus="stu">
			<tr>
				<td data-id="${e.id }"><input type="checkbox" name="choiceNum" /></td>
				<td>${stu.index+1 }</td>
                <c:if test="${isUpperOrg}">
                    <td>${e.organization.name}</td>
                </c:if>
				<td>${e.exam.examName }</td>
				<td>${e.examSub.name }</td>
				<fmt:parseNumber value="${e.frequency}" var="frequencyPoint" />
				<td><fmt:formatNumber value="${frequencyPoint/1000}"  pattern="0.000" /></td>
				<td>${e.suffix }</td>
				<td>
					<c:if test="${e.signalType==0 }">未知</c:if>
					<c:if test="${e.signalType==1 }">语音</c:if>
					<c:if test="${e.signalType==2 }">文本</c:if>
				</td>
				<td class="recognitionResult">
					<c:if test="${e.recognitionResult==0 }">未知</c:if>
					<c:if test="${e.recognitionResult==1 }">确认作弊</c:if>
					<c:if test="${e.recognitionResult==2 }">非作弊</c:if>
				</td>
				<td><fmt:formatDate value="${e.reductionTime }" pattern="YYYY-MM-dd HH:mm:ss" /></td>
				<td>
					<c:if test="${e.suffix=='wav' }">
						<img title="试听" data-src="${e.fileAddr }" onclick="listen(this)" class="tdImg" style="width: 27px;" src="${basePath }/static/jy/img/pcImg/listen.png"/>
					</c:if>
					<c:if test="${e.suffix=='txt' }">
						<img title="预览" data-src="${e.fileAddr }" onclick="preview(this)" class="tdImg" style="width: 27px;" src="${basePath }/static/jy/img/pcImg/preview.png"/>
					</c:if>
					<img title="确认作弊" onclick="Exclude(this,1)" class="tdImg" src="${basePath }/static/jy/img/pcImg/ischeat.png" />
					<img title="排除" onclick="Exclude(this,2)" class="tdImg" src="${basePath }/static/jy/img/pcImg/notcheat.png" />
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



