<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>组织机构</title>
	<%@ include file="/WEB-INF/views/version.jsp"%>
	<link rel="stylesheet" href="<%=basePath%>/static/common/css/ztree/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>/static/jy/css/common/common.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>/static/jy/css/common/jry-Plug-in.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>/static/jy/css/org/orgList.css<%=version%>" type="text/css">
</head>
<body>
	<input type="hidden" id="basePath" value="<%=basePath%>" />
	<div id="orgMain" class="clearfix YH">
		<div class="fl leftPart">
			<div class="searchs clearfix">
				<div class="fl searchInput">
					<input type="text" placeholder="查找机构" id="searchBtn"/>
				</div>
				<div class="fl searchImg CP" onclick="searchOrg()">
					<img src="<%=basePath%>static/jy/img/pcImg/searchBlack.png" />
				</div>
				
			</div>
			<div class="zTreeDemoBackground YH">
                <ul id="organizationListTree" class="ztree"></ul>
            </div>
		</div>
		<div class="fl rightPart">
			<div class="Jcustom_content">
				<form class="saveAndEdit">
					<div class="Jcustom_content_items clearfix">
						<label>机构名称</label>
						<input type="text" id="name" name="name" placeholder="请输入机构名称">
						<div class="error_text"></div>
					</div>
					<div class="Jcustom_content_items clearfix">
						<label>ip</label>
						<input type="text" id="ip" name="ip" placeholder="请输入ip">
						<div class="error_text"></div>
					</div>
					<div class="Jcustom_content_items clearfix">
						<label>备注</label>
						<input type="text" id="remark" name="remark" placeholder="请输入备注">
						<div class="error_text"></div>
					</div>
					<div class="btn" onclick="save(this)">
						新建机构
					</div>
				</form>
			</div>
			
		</div>
	</div>
</body>
<script type="text/javascript" src="<%=basePath%>/static/common/js/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/common/js/ztree/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/jy/js/org/template-web.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/jy/js/org/orgList.js<%=version%>"></script>
<script id="editWithDelete" type="text/html">
	<div class="Jcustom_content">
		<div class="Jcustom_title">编辑</div>
		<form class="saveAndEdit">
			<div class="Jcustom_content_items clearfix">
				<label>机构名称</label>
				<input type="text" id="name" name="name" value="{{name}}" placeholder="请输入机构名称">
				<div class="error_text"></div>
			</div>
			<div class="Jcustom_content_items clearfix">
				<label>ip</label>
				<input type="text" id="ip" name="ip" value="{{ip}}" placeholder="请输入ip">
				<div class="error_text"></div>
			</div>
			<div class="Jcustom_content_items clearfix">
				<label>备注</label>
				<input type="text" id="remark" name="remark" value="{{remark}}" placeholder="请输入备注">
				<div class="error_text"></div>
			</div>
			<input type="hidden" id="orgId" name="id" value="{{id}}">
			<input type="hidden" id="orgPid" name="parentId" value="{{parentId}}">
			<div class="btns clearfix">
				<div class="btn fl" onclick="update(this)">
					保存修改
				</div>
				<div class="btn forbid fl" onclick="deletes(this)">
					删除机构
				</div>
			</div>
		</form>
	</div>
	
	<div class="Jcustom_content">
		<div class="Jcustom_title">新增</div>
		<form class="saveAndEdit">
			<div class="Jcustom_content_items clearfix">
				<label>机构名称</label>
				<input type="text" id="name" name="name" value="" placeholder="请输入机构名称">
				<div class="error_text"></div>
			</div>
			<div class="Jcustom_content_items clearfix">
				<label>ip</label>
				<input type="text" id="ip" name="ip" value="" placeholder="请输入ip">
				<div class="error_text"></div>
			</div>
			<div class="Jcustom_content_items clearfix">
				<label>备注</label>
				<input type="text" id="remark" name="remark" value="" placeholder="请输入备注">
				<div class="error_text"></div>
			</div>
			<div class="btns clearfix">
				<!-- <div class="btn fl" onclick="save(this,'{{parentId}}')">
					新增同级
				</div>
 				-->
				<div class="btn fl" onclick="save(this,'{{id}}')">
					新增下级
				</div>
			</div>
		</form>
	</div>
</script>
<script type="text/javascript">
	function searchOrg(){
		var lis = $("span");
		var searchBtnValue = $("#searchBtn").val();
		for(var i = 0; i < lis.length;i++){
			lis[i].style.background='';
			if(searchBtnValue != "" || searchBtnValue.length > 0){
				if(lis[i].innerText.match(searchBtnValue)){
					lis[i].style.background = '#97CBFF';
				}
			}
		}
	}
</script>
</html>
