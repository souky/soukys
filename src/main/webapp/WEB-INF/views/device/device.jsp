<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Equipment Page</title>
	<%@ include file="/WEB-INF/views/version.jsp"%>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/equipment/equipment.css<%=version%>"/>
</head>
<body>

	<input type="hidden" id="basePath" value="<%=basePath%>"/>
	<form id="searchCriteriaForm">
		<div class="Jry_query">
			<div class="query_part">
				<div class="query_items">
					<label>IP地址</label>
					<div class="inputDivOne">
						<input name="ip" id="ipSearch" type="text" />
					</div>
				</div>
				
				<div class="query_items">
					<label>MAC地址</label>
					<div class="inputDivOne">
						<input name="mac" id="macSearch" type="text" />
					</div>
				</div>
				
				<div class="query_items">
					<label>类型</label>
					<div class="inputDivOne">
						<select name="type" id="typeSelect">
	                        <option value=-1>全部</option>
							<option value=0>未知</option>
							<option value=1>侦测</option>
							<option value=2>阻断</option>
	                    </select>
					</div>
				</div>
			
				<div class="query_items">
					<label>状态</label>
					<div class="inputDivOne">
						<select name="status" id="statusSelect">
	                        <option value=-1>全部</option>
							<option value=0>未知</option>
							<option value=1>在线</option>
							<option value=2>离线</option>
	                    </select>
					</div>
				</div>
				
				<div class="query_items">
				</div>
				
				<div class="query_items">
				</div>
				
				<div class="query_items">
				</div>
				
				<div class="query_items">
					<div class="query_btns">
						<div class="query_btn" onclick="loadData(1)">
							查询
						</div>
						<div class="query_btn"  onclick="exportDeviceList()">
							导出
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	
	<form id="tbForm">
	<div class="Jry_table" id="testTable">
		<div class="buttons">
			<div class="btns delet_btn" onclick="delAll()">
				<div class="imgButton">
					<img src="<%=basePath%>/static/jy/img/pcImg/delete.png">
				</div>
				<div class="textButton">删除</div>
			</div>
			<div class="btns delet_btn" onclick="openOrCloseSelectedDevices(2)">
				<div class="imgButton">
					<img src="<%=basePath%>/static/jy/img/pcImg/authorization.png">
				</div>
				<div class="textButton">开启</div>
			</div>
			<div class="btns delet_btn" onclick="openOrCloseSelectedDevices(5)">
				<div class="imgButton">
					<img src="<%=basePath%>/static/jy/img/pcImg/boot.png">
				</div>
				<div class="textButton">关闭</div>
			</div>
			<div class="btns delet_btn" onclick="openOrCloseAllDevices(2)">
				<div class="imgButton">
					<img src="<%=basePath%>/static/jy/img/pcImg/authorization.png">
				</div>
				<div class="textButton">一键开启</div>
			</div>
			<div class="btns delet_btn" onclick="openOrCloseAllDevices(5)">
				<div class="imgButton">
					<img src="<%=basePath%>/static/jy/img/pcImg/boot.png">
				</div>
				<div class="textButton">一键关闭</div>
			</div>
		</div>
		<div class="table_body">
			<input type="hidden" id="isUpperOrg" value="${isUpperOrg}">
			<table id="table">
				<tbody id="deviceList">
					<tr>
						<td><input id="delAll" type="checkbox" onclick="toggleSelectAll(this)"/></td>
						<td>序号</td>
						<td>类型</td>
						<td>IP地址</td>
						<td>MAC地址</td>
						<td>版本号</td>
						<td>状态</td>
						<td>工作状态</td>
						<td>受控状态</td>
						<td>开启模块</td>
						<td>操作</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	</form>	
	
	<div class="navi">
		<form id="naviForm">
			<div class="Jry_page" id="pageCss">
				<input type="hidden" class="pageNow"  id="pageNum" />
				<input type="hidden" class="pageTotal" id="pages" />
				<input type="hidden" name="pageNum" id="pageNum1"/>
				<input type="hidden" name="pageSize" value="10"/>
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
		</form>
	</div>
	
	<div class="hide" id="bootDiv" style="width:350px">
		<form id="bootForm_JRY"> 
	     	<div class="Jcustom_title" id="bootTitle_JRY"></div>
	     	<input id="hiddenId" type="hidden" name="id"/>
	     	<div class="Jcustom_content">
	     		<br/>
	     		<div class="row clearfix">
     				<div class="fl">选择控制方式：</div>
     				<div class="fl inputRadio">
     					<input id="manualRedio_JRY" type="radio" name="controlled" value=2 onclick="enableModule()" />
     				</div>
     				<div class="fl inputText">手动</div>
     				<div class="fl inputRadio">
     					<input id="autoRadio_JRY" type="radio" name="controlled" value=1 onclick="disableModule()"/>
     				</div>
 					<div class="fl inputText">自动</div>
     				<div class="fl rightpart"><font color="red">注</font>："手动"可选模块,"自动"清除手控命令</div>
	     		</div>
	     		<br/>
	     		<div class="row" id="moduleDiv">
	     			<div class="fl">选择打开模块：</div>
	     			<div class="fl inputRadio">
	     				<input id="1g_JRY" type="checkbox" class="moduleInput" name="operationType1G" value=3 />
	     			</div>
	     			<div class="fl inputText">1G模块</div>
	     			<div class="fl inputRadio">
	     				<input id="phone_JRY" type="checkbox" class="moduleInput" name="operationTypePhone" value=4 />
 					</div>
 					<div class="fl inputText">手机模块</div>
 					<div class="fl rightpart"><font color="red">注</font>：全不选两个模块休眠 </div>
	     		</div>
	     		<br/>
	     		<div class="Jcustom_content_btns">
					<div class="okBtn btns"  onclick="doBoot()">确定</div>
					<div class="cancelBtn btns" onclick="CancelPop()">取消</div>
				</div>
	     	</div>
				
	     </form>
	</div>
	
	<div class="hide " id="editDiv"> 
    	<form id="editForm_JRY"> 
	     	<div class="Jcustom_title" id="titleId_JRY"></div>
			<div class="Jcustom_content">
				<input type="hidden" name="id" id="id_JRY"/>
				<div class="Jcustom_content_items">
					<label>设备类型:</label>
					<select class="required_JRY edit" name="type" id="type_JRY" disabled>
					<option value='' selected>请选择</option>
					<option value=0>未知</option>
					<option value=1>侦测</option>
					<option value=2>阻断</option>
		  			</select>
					<div class="error_text"></div>
				</div>
		
				<div class="Jcustom_content_items">
					<label>设备IP:</label>
					<input type="text" name="ip_JRY" id="ip_JRY" placeholder="请输入设备IP" maxlength="32" class="required_JRY edit" readonly/>
					<div class="error_text"></div>
				</div>
				
				<div class="Jcustom_content_items">
					<label>设备MAC:</label>
					<input type="text" name="mac" id="mac_JRY" placeholder="请输入设备MAC" maxlength="32" class="required_JRY edit" readonly/>
					<div class="error_text"></div>
				</div>
				
				<div class="Jcustom_content_items">
					<label>版本号:</label>
					<input type="text" name="version" id="version_JRY" placeholder="请输入版本号" maxlength="32" class="required_JRY edit" readonly/>
					<div class="error_text"></div>
				</div>

				<div class="Jcustom_content_items">
					<label>地点:</label>
					<input type="text" name="address" id="address_JRY" placeholder="请输入地点信息" maxlength="50" class="required_JRY edit"/>
					<div class="error_text"></div>
				</div>
		
				<div class="Jcustom_content_btns">
					<div class="okBtn btns" id="editBtn_JRY" >确定</div>
					<div class="cancelBtn btns" onclick="CancelPop()">取消</div>
				</div>
			</div>
		</form>
	</div>
		
	          
</body>

<script type="text/javascript" src="static/jy/js/common/validate.js"></script>
<script type="text/javascript" src="static/jy/js/device/device.js<%=version%>"></script>
</html>