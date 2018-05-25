var pageSize = 10;
var basePath = $("#basePath").val();
$(document).ready(function(){
	//初始化列表页
	queryRole(1,pageSize);
	//修改角色信息-设值
	roleEdit();
	//删除角色
	roleDelete();
	//获取权限
	getPermissions();
	
 });
 
//查询角色信息
function queryRole(pageNum,pageSize){
    if(isNaN(pageNum)){
        JRYPopup.Jalert("请输入正确的页码");
        return;
    }
    if(pageNum < 1){
        JRYPopup.Jalert("页码应从1开始");
        return;
    }
	$.ajax({
 		type:"post",
		url:basePath + "role/queryRoles",
		data:{
			pageNum:pageNum,//此处是第1页（通过当前页来请求数据）
			pageSize:pageSize //每页的记录数
		},
		dataType:"json",
		success:function(data,textStatus,jqXHR){
			if(data!=null){
				$(".appendRemove").remove();
				var htmls="";
				var roles=data.result.list;
				for(var i = 0 ;i < roles.length ; i++){
					var roleId=roles[i].id;
					var roleName=roles[i].roleName;
					var roleRemark=roles[i].remark;
					htmls+="<tr class='appendRemove'>";
					htmls+="<td><input type='checkbox' value='"+ roleId +"' name='choiceNum'/></td>";
					htmls+="<td roleId='"+roleId+"'>"+(parseInt(i)+1)+"</td>";
					htmls+="<td>"+roleName+"</td>";
					htmls+="<td>"+roleRemark+"</td>";
					htmls+="<td><img title='编辑' class='tdImg roleEdit' src='"+basePath+"/static/jy/img/pcImg/edit.png'/>";
					htmls+="<img title='删除' class='tdImg roleDelete' src='"+basePath+"/static/jy/img/pcImg/deleteT.png' />";
					htmls+="<img title='用户授权' class='tdImg authorization' src='"+basePath+"/static/jy/img/pcImg/authorization.png' />";
					htmls+="</td></tr>";
				}
				$(".roleData").append(htmls);
				$("table tr").removeClass("hidden");
				//设置当前页-在分页js中要用到
				$(".pageNow").val(data.result.pageNum);//初始化加载的时候，pageNow为1
				//设置总页数-在分页js中要用到
				$(".pageTotal").val(data.result.pages);
				/*分页(分页参数)：
					pageIconJs:要绑定初始化的容器；和html分页的id进行对应；
					data.result.pageNum:当前页数；//后台分页查询返回的数据
					data.result.pages:总页数；//后台分页查询返回的数据
					3:分页插件显示的页码数量；//分页处显示的页码:1,2,3
					changePage:跳转页方法；//点击每个页码跳转的方法，加载对应的页码
				*/
				JRYTable.tableInit("roleTable","deleteByNums","choiceNum");
				JRYPage.pageInit('pageIconJs',data.result.pageNum,data.result.pages,3,changePage);
			}
			 
		},
		error:function(XMLHttpRequest,textStatus,errorThrown){
			alert("查询角色失败！");
		}
 	});
}
//批量删除
function deleteByNums(){
	if($("input[name='choiceNum']:checked").length <= 0){
		JRYPopup.Jalert("请选择删除项");
		return;
	}
 	JRYPopup.Jconfim('确定要删除已选择的数据吗？',deleteByNumsT,"");
}
function deleteByNumsT(){
	 var ids = "";
	$("input[name='choiceNum']:checked").each(function(){
		ids += $(this).val()+",";
	});
	ids = ids.substring(0,ids.length-1);
	var data = {ids:ids}
	$.ajax({
		url:basePath + 'role/deleteRoles',
		data:data,
		type:'post',
		success:function(res){
			if(res.result!='0'){
				var pageNow = $("#pageIconJs").find(".pageNow").val();
				queryRole(pageNow,pageSize);
				JRYPopup.popupClose();
			 }else{
				 JRYPopup.Jalert("操作失败");
			 }
		},error:function(res){
			JRYPopup.Jalert("操作失败");
		}
	})
}
//新增操作
function addRole(){
	//新增弹出框
	JRYPopup.Jcustom("addEditRole");
	$(".warnsroleName").remove();
	$(".warnsremark").remove();
	$(".addOrEdit").text("新增角色");
	$(".commentForm").attr("action",basePath + "role/editRole");
	roleValidate();
}
//取消新建角色
function roleCancel(){
	JRYPopup.popupClose();
}
//新增或修改角色的公共部分
function roleSaveEdit(){
	var name = $('#roleName').val();
	if(name == null || name.length < 1){
        $("#roleName").closest(".Jcustom_content_items").addClass("haserror");
        $("#roleName").parent().find(".error_text").html("角色名不能为空");
        $("#roleName").focus(function(){
            $("#roleName").parent().find(".error_text").html("");
            $("#roleName").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
	}
	$.ajax({
		type:"post",
		url:$(".commentForm").attr("action"),
		data:$(".commentForm").serialize(),//提交整个form表单
		dataType:"json",
		success:function(data){
			if(data.code == 10000){
                roleCancel();
                JRYPopup.Jalert("保存成功");
                $(".appendRemove").remove();
                var pageNum = $("#pageIconJs").find(".pageNow").val();
                queryRole(pageNum,pageSize);
            }else{
                JRYPopup.Jalert(data.message);
			}
		},
		error:function(){
			JRYPopup.Jalert("操作失败");
		}
	});
}
//获取权限
function getPermissions(){
	$(document).on("click",".authorization",function(){
		
		var roleId = $(this).parent().prev().prev().prev().attr("roleId");
		$("#roleId").val(roleId); 
		setting = {
	        data: {
	            simpleData: {
	                enable: true
	            }
	        },
	        check: {
	    		enable: true,
	    		chkStyle: "checkbox",
	    		chkboxType: {"Y": "ps", "N": "ps"}
	    	},
	    };
		$.ajax({
		    url:basePath + "permission/queryPermissions",
		    type:'post',
		    data:{roleId:roleId},//角色id
		    dataType:'json',
		    success:function (data) {
		    	datas = data.result
		    	JRYPopup.Jcustom("roleAuthorization",permissionsEven);
		    }
		});
	})
}
function permissionsEven(){
	$.fn.zTree.init($("#treeDemo"), setting, datas);
}

//角色授权
function grentPermissions(){
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
    var nodes = zTree.getCheckedNodes(true);
    if(nodes.length == 0){
    	JRYPopup.Jalert("请选择权限");
    	return;
    }
    var roleId = $("#roleId").val();
    //alert(nodes.length);
    //alert(nodes[0].name + "---" + nodes[0].id);
    var arr = new Array();
    for(var i = 0; i < nodes.length; i++){
    	arr[i] = nodes[i].id;
    }
    $.ajax({
    	type:"post",
		url:basePath + "permission/grentPermissions",
		data: "roleId=" + roleId +"&ids=" + arr,
		dataType:"json",
		success:function(data){
			JRYPopup.popupClose();
			JRYPopup.Jalert("保存成功");
		}
    });
    
}
//修改角色信息
//(1)先设值
function roleEdit(){
	$(document).on("click",".roleEdit",function(){
		var roleId=$(this).parent().prev().prev().prev().attr("roleId");
		$.ajax({
			type:"post",
			url:basePath + "role/getRoleById",
			data:{
				id:roleId
			},//角色id
			dataType:"json",
			success:function(data,textStatus,jqXHR){
				JRYPopup.Jcustom("addEditRole");
				roleValidate();
				$(".warnsroleName").remove();
				$(".warnsremark").remove();
				var roleId=data.result.id;
				var roleName=data.result.roleName;
				var remark=data.result.remark;
				$(".roleName").val(roleName);
				$(".roleId").val(roleId);
				$(".remark").val(remark);
				$(".addOrEdit").text("修改角色");
				$(".flag").val("true");
				$(".commentForm").attr("action",basePath + "role/editRole");
			},
			error:function(XMLHttpRequest,textStatus,errorThrown){
				JRYPopup.Jalert("获取角色信息失败！");
			}
		});
	});
}
//删除角色 单条记录
function roleDelete(){
	$(document).on("click",".roleDelete",function(){
		//eq(index):index是从0开始的。
		var roleId=$(this).parent().parent().children("td").eq(1).attr("roleId");
		//确定删除框 并且 //发送ajax请求删除数据
		JRYPopup.Jconfim("确定要删除这条数据吗？",roleDeleteAjax,roleId);
	});
}
//删除角色的ajax请求
function roleDeleteAjax(roleId){
	$.ajax({
		type:"post",
		url:basePath + "role/deleteRole",
		data:{
			id:roleId
		},//角色id
		dataType:"json",
		success:function(data,textStatus,jqXHR){
			JRYPopup.Jalert("删除角色成功！");
			$(".appendRemove").remove();
			var pageNum = $("#pageIconJs").find(".pageNow").val();
			queryRole(pageNum,pageSize);
		},
		error:function(XMLHttpRequest,textStatus,errorThrown){
			JRYPopup.Jalert("删除角色失败！");
		}
	});
}
//前台校验
function roleValidate(){
	//验证角色名称不能为空
	$(".roleName").focus(function(){
		var roleName=$(this).val();
		var roleNameId=$(this).attr("id");
		if($(".warns"+roleNameId)!=null){
			$(".warns"+roleNameId).remove();
		}
	});
	$(".roleName").blur(function(){
		var roleName=$(this).val();
		var roleNameId=$(this).attr("id");
		if(paramIsNull(roleName)==false){
			$(".warns"+roleNameId).remove();
			$(".roleNameError").append("<font class='warns"+roleNameId+"' color='red'><b>角色名称不能为空！</b></font>");
			return false;
		}
		$(".warns"+roleNameId).remove();
	});
	//验证备注不能为空
	/*$(".remark").focus(function(){
		var remark=$(this).val();
		var remarkId=$(this).attr("id");
		if($(".warns"+remarkId)!=null){
			$(".warns"+remarkId).remove();
		}
	});
	$(".remark").blur(function(){
		var remark=$(this).val();
		var remarkId=$(this).attr("id");
		if(paramIsNull(remark)==false){
			$(".warns"+remarkId).remove();
			$(".remarkError").append("<font class='warns"+remarkId+"' color='red'><b>备注不能为空！</b></font>");
			return false;
		}
		$(".warns"+remarkId).remove();
	});*/
}
//分页-点击指定的页数实现跳转并加载相应的数据
/*分页参数：
 * obj:对象
 * pageNow：当前页
 * pageTotal:总页数
 */
function changePage(obj,pageNow,pageTotal){
	 //$(".appendRemove").remove();
	 var pageNums = 1;
	 if(pageNow){
		 pageNums = pageNow;
	 }else{
		 pageNums = $(obj).text();
	 }
	 var pageTotal = $("#pageIconJs").find(".pageTotal").val();
	 if(pageNums!='...'){
		 pageNums = parseInt(pageNums);
		 pageTotal = parseInt(pageTotal);
		 if (pageNums>pageTotal) {
             JRYPopup.Jalert("输入的页码超出最大范围");
             return;
		 }
		 //$(".appendRemove").remove();
		 queryRole(pageNums,pageSize);
	 }
}
//分页-上一页
function roleProPage(){
	var pageNow = $("#pageIconJs").find(".pageNow").val();
	var pageNums = parseInt(pageNow)-1;
	if(pageNums<1){
		return false;
	}else{
		$(".appendRemove").remove();
		queryRole(pageNums,pageSize);
	}
}
//分页-下一页
function roleNextPage(){
	var pageNow = $("#pageIconJs").find(".pageNow").val();
	var pageTotal = $("#pageIconJs").find(".pageTotal").val();
	var pageNums = parseInt(pageNow)+1;
	if(pageNums > pageTotal){
		return;
	}else{
		$(".appendRemove").remove();
		queryRole(pageNums,pageSize);
	}
}