<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${not empty meuns}"> 

<div class="Jry_menu">
	<c:forEach items="${meuns}"  var="e" varStatus="stu">
	<c:if test="${e.menuLevel==1}">
	<div class="">
		<div class="menu_level_one">
			<div class="img_level_one"><img src="${basePath }/static/jy/img/pcImg/${e.remark}.png"></div>
			<div class="text_level_one">${e.menuName}</div>
			<div class="showimg_level_one"><img src="${basePath }/static/jy/img/pcImg/downArrow.png"></div>
		</div>
		<div class="menu_level_two">
			<c:forEach items="${meuns}"  var="ee" varStatus="stu">
			<c:if test="${ee.menuLevel==2}">
			<c:set var="oneBisId" scope="page" value="${fn:substring(e.bsid,0,5)}"/>
			<c:set var="twoBisId" scope="page" value="${fn:substring(ee.bsid,0,5)}"/>
			<c:if test="${oneBisId == twoBisId }">
				<div class="items_level_two" data-url="${ee.url }">
					<div class="img_level_two"><img src="${basePath }/static/jy/img/pcImg/rightArrow.png"></div>
					<div class="text_level_two">${ee.menuName }</div>
				</div>
			</c:if>
			</c:if>
			</c:forEach>
		</div>
	</div>
	</c:if>
	</c:forEach>
	<div style="width:100px;position:absolute;left:10px;bottom:0px;height:30px;line-height:30px;color:#fff;text-align:left;">
		V2.0.1
	</div>
</div>
</c:if>