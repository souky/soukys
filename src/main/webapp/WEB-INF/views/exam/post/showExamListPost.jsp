<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="Jry_table" id="cheateTables">
	<div class="buttons">
		<div class="btns addnew_btn">
			<div class="imgButton">
				<img src="${basePath}/static/jy/img/pcImg/add.png">
			</div>
			<div class="textButton" onclick="newExam()">新增</div>
		</div>
		<div class="btns delet_btn">
			<div class="imgButton">
				<img src="${basePath}/static/jy/img/pcImg/delete.png">
			</div>
			<div class="textButton">删除</div>
		</div>
	</div>
	<div class="table_body">
		<table id="examTable">
			<tr>
				<th><input type="checkbox" class="selectAll" name="checkAll" ></th>
				<th>序号</th>
                <c:if test="${isUpperOrg}">
				    <th>组织机构</th>
                </c:if>
				<th>编号</th>
				<th>考试计划名称</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
			<c:if test="${not empty examList}"> 
			<c:forEach items="${examList}"  var="e" varStatus="stu">
			<tr>
				<td data-id="${e.id }"><input type="checkbox" name="choiceNum" value="${e.id}" /></td>
				<td>${stu.index+1 }</td>
                <c:if test="${isUpperOrg}">
                    <td>${e.organization.name}</td>
                </c:if>
                <td class="examNo">${e.examNo}</td>
				<td class="examName">${e.examName }</td>
				<td class="startTime"><fmt:formatDate value="${e.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td class="endTime"><fmt:formatDate value="${e.endTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td class="status" data-status="${e.status}">
                    <c:if test="${e.status==1 }">
                        <a onclick="startThread('${e.id }',2)">启用</a>
                    </c:if>
                    <c:if test="${e.status==2 }">
                        <a onclick="startThread('${e.id }',1)">禁用</a>
                    </c:if>
                </td>
				<td>
					<input type="hidden" class="examTypeId" value="${e.examTypeId }">
					<img title="编辑" onclick="edit(this)" class="tdImg" src="${basePath }/static/jy/img/pcImg/edit.png"/>
					<img title="删除" onclick="deletExam(this)" class="tdImg" src="${basePath }/static/jy/img/pcImg/deleteT.png" />
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
		<div class="prev_page" onclick="proPage()">上一页</div>
		<div class="maps_page"></div>
		<div class="next_page" onclick="nextPage()">下一页</div>
		<div class="jump_page">
			跳转到<input type="text" maxlength="3">页
		</div>
		<div class="jump_button">GO</div>
	</div>
</div>

