<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="Jry_table" id="cheateTables">
	<div class="buttons">
		<div class="btns addnew_btn">
			<div class="imgButton">
				<img src="${basePath }/static/jy/img/pcImg/add.png">
			</div>
			<div class="textButton" onclick="newExamType()">新增</div>
		</div>
		<%--<div class="btns delet_btn">
			<div class="imgButton">
				<img src="${basePath }/static/jy/img/pcImg/delete.png">
			</div>
			<div class="textButton">删除</div>
		</div>--%>
	</div>
	<div class="table_body">
		<table>
			<tr>
				<th><input type="checkbox" class="selectAll" name="checkAll" ></th>
				<th>序号</th>
				<th>考试类型名称</th>
				<th>操作</th>
			</tr>
			<c:if test="${not empty examTypeList}"> 
			<c:forEach items="${examTypeList}"  var="e" varStatus="stu">
			<tr>
				<td data-id="${e.id }"><input value="${e.id }" type="checkbox" name="choiceNum" /></td>
				<td>${e.examTypeNo }</td>
				<td>${e.examTypeName }</td>
				<td>
					<img title="编辑" onclick="editType(this)" class="tdImg" src="${basePath }/static/jy/img/pcImg/edit.png"/>
					<img title="删除" onclick="deletExamTypeS(this)" class="tdImg" src="${basePath }/static/jy/img/pcImg/deleteT.png" />
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
		<div class="prev_page" onclick="proPageType()">上一页</div>
		<div class="maps_page"></div>
		<div class="next_page" onclick="nextPageType()">下一页</div>
		<div class="jump_page">
			跳转到<input type="text" maxlength="3">页
		</div>
		<div class="jump_button">GO</div>
	</div>
</div>

