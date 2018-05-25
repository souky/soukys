<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <title>用户列表</title>
	    <%@ include file="/WEB-INF/views/version.jsp"%>
	    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/page.css"/>
	    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
	    <link rel="stylesheet" href="<%=basePath%>/static/common/css/ztree/zTreeStyle/zTreeStyle.css" type="text/css">
	</head>
<body>
	<input type="hidden" id="basePath" value="<%=basePath%>"/>
	<div class="Jry_query">
	    <div class="query_part">
	        <form id="findForm">
	            <div class="query_items">
	                <label>姓名：</label>
	                <div class="inputDivOne">
	                    <input type="text" name="name">
	                </div>
	            </div>
	            <div class="query_items">
	                <label>用户名：</label>
	                <div class="inputDivOne">
	                    <input type="text" name="userName">
	                </div>
	            </div>
	            <div class="query_items">
	                <label>电话：</label>
	                <div class="inputDivOne">
	                    <input type="text" name="phone">
	                </div>
	            </div>
	            <div class="query_items">
	            	<div class="query_btns">
		                <div class="query_btn" onclick="exportList()">
		                    	 导出
		                </div>
		                <div class="query_btn" onclick="loadData(1,10)">
								 查询
		                </div>
		            </div>
	            </div>
	        </form>
				
	    </div>
	    
	    <!-- <div class="query_part">
	        <form action="" id="importExcel" method="post"enctype="multipart/form-data">
	            <div class="query_items">
	                <label>导入文件：</label>
	                <div class="inputDivOne">
	                    <input type="file" name="file" id="file">
	                </div>
	            </div>
	            <div class="query_items">
	            </div>
	            <div class="query_items">
	            </div>
	            <div class="query_items">
	            	<div class="query_btns">
		                <button onclick="submitExcel();">导入</button>
		                <input type="button" value="导入" onclick="submitExcel();"/>
		                <div class="query_btn" onclick="submitExcel()">
		                    	 导入
		                </div>
		            </div>
	            </div>
	        </form>
	    </div> -->
	    
	    
	</div>

	<div id="showuserlist">
	    <div class="Jry_table" id="userlistTables">
	        <div class="buttons">
	            <div class="btns addnew_btn">
	            <div class="imgButton">
	            <img src="<%=basePath%>/static/jy/img/pcImg/add.png">
	            </div>
	            <div class="textButton" onclick="doCreated()">新增</div>
	            </div>
	            <div class="btns delet_btn">
	            <div class="imgButton">
	            <img src="<%=basePath%>/static/jy/img/pcImg/delete.png">
	            </div>
	            <div class="textButton">删除</div>
	            </div>
	        </div>
	        <div class="table_body">
	            <table>
	            	<tbody id="tbody">
	                </tbody>
	            </table>
	        </div>
	    </div>
	    <%--分页--%>
	    <div class="Jry_page" id="pageIconJs">
			<!-- 当前页 -->
			<input type="hidden" class="pageNow"/>
			<!-- 总页数 -->
			<input type="hidden" class="pageTotal"/>
			<div class="page_body">
				<div class="prev_page" onclick="proPage()">上一页</div>
				<div class="maps_page"></div>
				<div class="next_page" onclick="nextPage()">下一页</div>
				<div class="jump_page">
				<!-- 现在数据库一共有12条数据，每页要求是5条记录，所以最大页数为3页。 -->
					跳转到<input type="text" maxlength="3">页
				</div>
				<div class="jump_button">GO</div>
			</div>
		</div>
	</div>
	<!-- 模态框（Modal） -->
	<div id="editUserInfo" class="hide">
		<div class="Jcustom_title">编辑用户信息</div>
		<div class="Jcustom_content">
		    <form class="commentForm" action="" id="editUser_JRY">
		    	<div class="Jcustom_content_items ">
			    	<label>姓名</label>
			    	<input type="hidden" id="id_JRY" name="id">
			    	<input type="text" id="name_JRY" name="name" placeholder="请输入用户姓名">
					<div class="error_text"></div>
		    	</div>
		    	<div class="Jcustom_content_items ">
			    	<label>用户名</label>
			    	<input type="text" id="userName_JRY" name="userName_JRY" placeholder="请输入用户名">
					<div class="error_text"></div>
		    	</div>
		    	<div class="Jcustom_content_items ">
			    	<label>手机</label>
			    	<input type="text" id="phone_JRY" name="phone" placeholder="请输入用户手机号码">
					<div class="error_text"></div>
		    	</div>
		    	<div class="Jcustom_content_items ">
			    	<label>角色</label>
			    	<!-- <input type="text" id="" name="role" placeholder="请选择用户角色信息"> -->
			    	<select name="roleId" id="roles_JRY">
			    		<option disabled selected> --请选择-- </option>
			    	</select>
					<div class="error_text"></div>
		    	</div>
		    	<div class="Jcustom_content_items ">
			    	<label>组织机构</label>
			    	<!-- <input type="text" id="" name="org" placeholder="请选择用户组织机构"> -->
			    	<select name="orgId" id="orgs_JRY">
			    		<option disabled selected> --请选择-- </option>
			    	</select>
					<div class="error_text"></div>
		    	</div>
		    </form>
		    <div class="Jcustom_content_btns">
		        <div class="okBtn btns" onclick="doSave()">确定</div>
		        <div class="cancelBtn btns" onclick="doCancel()">取消</div>
		    </div>
		</div>
	</div>
	
	<!-- 授权机构 -->
	<div id="orgAuthorization" class="hide">
		<div class="Jcustom_title">授权机构</div>
		<div class="Jcustom_content">
		    <div class="zTreeDemoBackground left">
		        <input type="hidden" id="userId"/>
		        <ul id="treeDemo_JRY" class="ztree"></ul>
		    </div>
			<div class="Jcustom_content_btns">
				<div class="okBtn btns" onclick="grentUserOrganization()">保存</div>
				<div class="cancelBtn btns" onclick="orgCancel()">取消</div>
			</div>
		</div>
	</div>
</body>
<script language="javascript" src="<%=basePath%>/static/common/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/common/js/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/common/js/ztree/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/jy/js/user/user_list.js<%=version%>"></script>
<script type="text/javascript" src="<%=basePath%>/static/jy/js/user/ajaxfileupload.js"></script>
<script type="text/javascript">
    function submitExcel(){
        var excelFile = $("#file").val();
        //如果文件为空  
        if (excelFile == '') {
            JRYPopup.Jalert('请上传excel文件!');
            return;
        }

        //如果文件不是xls或者xlsx 提示输入正确的excel文件  
        if ((excelFile.indexOf('.xls') == -1 && excelFile.indexOf('.xlsx') == -1)) {
            JRYPopup.Jalert('请上传正确的excel,后缀名为xls或xlsx!');
            return;
        }

        $.ajaxFileUpload({
            method:"POST",
            url:"<%=basePath%>user/importUsers",
            secureuri:true,
            fileElementId:'file', //文件选择框的id属性
            data:$('#importExcel').serialize(),
            dataType: 'json',
            success: function(data, status){
                //上传成功之后的操作
                if (data.code == '10000') {
                    JRYPopup.Jalert(data.result);
                    loadData(1,10);
                }else if (data.code == '30000') {
                    JRYPopup.Jalert(data.message);
                }
            },error: function (data){
                //上传失败之后的操作
                JRYPopup.Jalert('导入信息失败!');
            }
        });

    }
</script>
</html>