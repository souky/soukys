<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@ include file="/WEB-INF/views/version.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/jy/css/shield/shield.css<%=version%>"/>
</head>
<body>
   <div class="Jry_query" style="display:none">
			<div class="query_part">
				<div class="query_items">
					<label>教室楼栋数</label>
					<div class="inputDivOne">
						<select id="buildingSelect">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
	                    </select>
					</div>
				</div>
			
				<div class="query_items">
					<label>每栋楼层数</label>
					<div class="inputDivOne">
						<select id="floorSelect">
	                        <option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
	                    </select>
					</div>
				</div>
				<div class="query_items">
					<label>每层教室数</label>
					<div class="inputDivOne">
						<select id="classSelect">
	                        <option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
	                    </select>
					</div>
				</div>
				<div class="query_items">
					<div class="query_btns">
						<div class="query_btn" onclick="startAll()">
							生成
						</div>
					</div>
				</div>
			</div>
	</div>
	<div id="allDom">
	</div>
	<div class="hide" id="bootDiv" style="width:350px">
		<form id="bootForm_JRY"> 
	     	<div class="Jcustom_title" id="bootTitle_JRY"></div>
	     	<input id="hiddenId" type="hidden" name="id"/>
	     	<div class="Jcustom_content">
	     		<br/>
	     		<div class="row clearfix" style="font-size:16px">
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
	     		<div class="row clearfix" id="moduleDiv"  style="font-size:16px">
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
    	<form id="editFormShield_JRY"> 
	     	<div class="Jcustom_title" id="titleId_JRY"></div>
			<div class="Jcustom_content">
				<input type="hidden" name="id" id="id_JRY"/>
				<input type="hidden" name="listOrder" id="listOrder_JRY"/>
		
				<div class="Jcustom_content_items">
					<label>设备IP:</label>
<!-- 					<input type="text" name="ip_JRY" id="ip_JRY" placeholder="请输入设备IP" maxlength="32" class="required_JRY edit" readonly />
 -->					<select class="required_JRY edit" name="ip_JRY"" id="ip_JRY">
					<option value='' selected>请选择设备IP</option>
					
		  			</select>
					<div class="error_text"></div>
				</div>
				<div class="Jcustom_content_items">
					<label>地点:</label>
					<input type="text" name="address" id="address_JRY" placeholder="请输入地点信息" maxlength="50" class="required_JRY edit"/>
					<div class="error_text"></div>
				</div>
		
				<div class="Jcustom_content_btns">
					<div class="okBtn btns" id="editBtn_JRY"  >确定</div>
					<div class="cancelBtn btns" onclick="CancelPop()">取消</div>
				</div>
			</div>
		</form>
	</div>
	
</body>
<script type="text/javascript" src="static/jy/js/common/validate.js"></script>
<script type="text/javascript" src="<%=basePath%>static/jy/js/shield/shield.js<%=version%>" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>static/jy/js/shield/shieldmain.js<%=version%>" charset="UTF-8"></script>
<script>

</script>
</html>
