var pageSize = 10;
$(document).ready(function () {
    loadData(1, pageSize);
});
//加载数据
function loadData(pageNums, pageSize) {
    if(isNaN(pageNums)){
        JRYPopup.Jalert("请输入正确的页码");
        return;
    }
    if(pageNums < 1){
        JRYPopup.Jalert("页码应从1开始");
        return;
    }
	var data = $("#findForm").serialize();
	data += "&pageNum=" + pageNums + "&pageSize=" + pageSize;
	$.ajax({
        url: $("#basePath").val() + "user/getUsers",
        dataType: "json",
        type: "POST",
        data: data,
        success: function (data) {
        	var html = "";
            html += "<tr><th><input type='checkbox' class='selectAll' name='checkAll'></th><th>序号</th><th>用户名</th><th>姓名</th><th>性别</th><th>手机</th><th>角色</th><th>组织机构</th><th>邮箱</th><th>操作</th></tr>"
            if (data.result.total > 0) {
            	var userList = data.result.list;
            	var tr;
            	for(var i = 0; i < userList.length; i++){
            		var user = userList[i];
            		html += "<tr><td><input type=\"checkbox\" name=\"choiceNum\" value='" + user.id + "'></td>";
            		html +=	"<td>" + (i + 1) + "</td>";
            		if(user.userName != null){
                		html +=	"<td>" + user.userName + "</td>";
            		}else {
            			html +=	"<td></td>";
            		}
            		if(user.name != null){
            			html +=	"<td>" + user.name + "</td>";
            		}else {
            			html +=	"<td></td>";
            		}
            		if(user.sex == 1){
            			html +=	"<td>女</td>";
            		} else if(user.sex == 0){
            			html +=	"<td>男</td>";
            		} else {
            			html +=	"<td></td>";
            		}
            		html +=	"<td>" + user.phone + "</td>";
            		html +=	"<td>" + user.roleName + "</td>";
            		html +=	"<td>" + user.orgName + "</td>";
            		if(user.email != null){
            			html +=	"<td>" + user.email + "</td>";
            		}else {
            			html +=	"<td></td>";
            		}
            		html +=	"<td>" +
                                "<img title='编辑' onclick='doEdit(this)' class='tdImg' id='" + user.id + "' src='" + $("#basePath").val() + "/static/jy/img/pcImg/edit.png'/>" +
                                "<img title='删除' onclick='doDeleted(this)' class='tdImg' id='" + user.id + "' src='" + $("#basePath").val() + "/static/jy/img/pcImg/deleteT.png'/>" +
                                "<img title='授权' onclick='showOrgTree(this)' class='tdImg authorization' id='" + user.id + "' src='" + $("#basePath").val() + "/static/jy/img/pcImg/org.png'/>" +
                              "</td>"
            				+ "</tr>"; 
            	}
            }
            var tbody = $("#tbody");
            tbody.html(html);
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
			JRYTable.tableInit("userlistTables","deleteByNums","choiceNum");
			JRYPage.pageInit('pageIconJs',data.result.pageNum,data.result.pages,3,changePage);
        }
	});
}
//获取roles
function getRoles(roleId){
	$.ajax({
		type:"POST",
		data:{pageNum:0,pageSize:0},
		url: $("#basePath").val() + "role/queryRoles",
		success:function (data) {
			var select = document.getElementById('roles');
			$("#roles").empty();
			select.options.add(new Option(" --请选择-- ",''));
		    for(var i = 0; i < data.result.list.length; i++){
				var role = data.result.list[i];
		    	select.options.add(new Option(role.roleName,role.id));
			}
		    if(roleId){
			    $("#roles").val(roleId);
		    }
		},
		error:function (data) {
			JRYPopup.Jalert("获取角色列表失败！");
		}
	});
}
//获取orgs
function getOrgs(orgId){
	$.ajax({
		type:"POST",
		url: $("#basePath").val() + "organization/getOrganizations",
		success:function (data) {
			var select = document.getElementById('orgs');
			$("#orgs").empty();
			select.options.add(new Option(" --请选择-- ",''));
		    for(var i = 0; i < data.result.length; i++){
				var organization = data.result[i];
		    	select.options.add(new Option(organization.name,organization.id));
			}
		    if(orgId){
			    $("#orgs").val(orgId);
		    }
		},
		error:function (data) {
			JRYPopup.Jalert("获取组织列表失败！");
		}
	});
}
//新建用户
function doCreated() {
    //修改标题
    $(".Jcustom_title").text("");// 清空数据
    $(".Jcustom_title").append("新建用户信息");
    getRoles();
    getOrgs();
    JRYPopup.Jcustom("editUserInfo");
}
//弹出编辑窗口
function doEdit(e) {
    //修改标题
    $(".Jcustom_title").text("");// 清空数据
    $(".Jcustom_title").append("编辑用户信息");
    JRYPopup.Jcustom("editUserInfo");
    $.ajax({
        type: "POST",
        url: $("#basePath").val() + "user/getUserById",
        data: {id:e.id},
        success: function (data) {
        	if (data.code == '10000') {
                var user = data.result;
                $("#id").val(user.id);
                $("#name").val(user.name);
                $("#userName").val(user.userName);
                $("#phone").val(user.phone);
		        getRoles(user.roleId);
		        getOrgs(user.orgId);
            } else {
                JRYPopup.Jalert(data.message)
            }
        },
        error: function () {
            JRYPopup.Jalert("该用户不存在！");
        }
    })
}
//保存
function doSave() {
	var name = $('#name').val();
    var userName = $('#userName').val();
    var phone = $('#phone').val();
    var roles = $('#roles').val();
    var orgs = $('#orgs').val();
    if(name == null || name.length < 1){
        $("#name").closest(".Jcustom_content_items").addClass("haserror");
        $("#name").parent().find(".error_text").html("姓名不能为空");
        $("#name").focus(function(){
            $("#name").parent().find(".error_text").html("");
            $("#name").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
	}
    if(userName == null || userName.length < 1){
        $("#userName").closest(".Jcustom_content_items").addClass("haserror");
        $("#userName").parent().find(".error_text").html("用户名不能为空");
        $("#userName").focus(function(){
            $("#userName").parent().find(".error_text").html("");
            $("#userName").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
    }
    if(phone == null || phone.length < 1){
        $("#phone").closest(".Jcustom_content_items").addClass("haserror");
        $("#phone").parent().find(".error_text").html("手机号不能为空");
        $("#phone").focus(function(){
            $("#phone").parent().find(".error_text").html("");
            $("#phone").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
    }
    var reg = /^1[3|4|5|7|8][0-9]{9}$/;
    if(!reg.test(phone)){
        $("#phone").closest(".Jcustom_content_items").addClass("haserror");
        $("#phone").parent().find(".error_text").html("手机号不符合规范");
        $("#phone").focus(function(){
            $("#phone").parent().find(".error_text").html("");
            $("#phone").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
    }
    if(roles == null || roles.length < 1){
        $("#roles").closest(".Jcustom_content_items").addClass("haserror");
        $("#roles").parent().find(".error_text").html("请选择角色");
        $("#roles").focus(function(){
            $("#roles").parent().find(".error_text").html("");
            $("#roles").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
    }
    if(orgs == null || orgs.length < 1){
        $("#orgs").closest(".Jcustom_content_items").addClass("haserror");
        $("#orgs").parent().find(".error_text").html("请选择组织机构");
        $("#orgs").focus(function(){
            $("#orgs").parent().find(".error_text").html("");
            $("#orgs").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
    }

	var data = $('#editUser').serialize();
	$.ajax({
        type: "POST",
        url: $("#basePath").val() + "user/editUser",
        data: data,
        success: function (data) {
            if (data.code == '10000') {
            	$("#id").val("");
            	JRYPopup.popupClose();
                loadData(1, pageSize);
                JRYPopup.Jalert("保存成功！")
            } else {
                JRYPopup.Jalert(data.message)
            }
        },
        error: function () {
            JRYPopup.Jalert("保存失败！");
        }
    })

}
//取消窗口
function doCancel() {
    JRYPopup.popupClose();
}

//删除用户
function doDeleted(e) {
	JRYPopup.Jconfim('确定要删除这条数据吗？', deleted, e.id);
}
function deleted(id) {
    $.ajax({
        type: "POST",
        url: "user/deleteUser",
        data: {id:id},
        success: function (data) {
            if (data.code == '10000') {
                loadData(1, pageSize);
                JRYPopup.Jalert("删除成功！")
            } else {
                JRYPopup.Jalert(data.message)
            }
        },
        error: function () {
            JRYPopup.Jalert("删除失败！");
            }
        })

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
		url:$("#basePath").val() + 'user/deleteUsers',
		data:data,
		type:'post',
		success:function(res){
			if(res.result!='0'){
				var pageNow = $("#pageIconJs").find(".pageNow").val();
				loadData(pageNow,pageSize);
				JRYPopup.popupClose();
			 }else{
				 JRYPopup.Jalert("操作失败");
			 }
		},error:function(res){
			JRYPopup.Jalert("操作失败");
		}
	})
}
//分页
function changePage(obj,pageNow,pageTotal){
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
        loadData(pageNums,pageSize);
    }
}
  //分页-上一页
function proPage(){
	var pageNow = $("#pageIconJs").find(".pageNow").val();
	var pageNums = parseInt(pageNow)-1;
	if(pageNums<1){
		return false;
	}else{
		loadData(pageNums,pageSize);
	}
}
//分页-下一页
function nextPage(){
	var pageNow = $("#pageIconJs").find(".pageNow").val();
	var pageTotal = $("#pageIconJs").find(".pageTotal").val();
	var pageNums = parseInt(pageNow)+1;
	if(pageNums > pageTotal){
		return;
	}else{
		loadData(pageNums,pageSize);
	}
}
//机构
function showOrgTree(e){
	$(document).on("click",".authorization",function(){
		$("#userId").val(e.id); 
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
		    url:$("#basePath").val() + "organization/queryOrganizations",
		    type:'post',
		    data:{userId:e.id},
		    dataType:'json',
		    success:function (data) {
		    	datas = data.result;
		    	JRYPopup.Jcustom("orgAuthorization",orgEvent);
		    }
		});
	})
}
function orgEvent(){
	$.fn.zTree.init($("#treeDemo"), setting, datas);
}
//给用户授权管理机构
function grentUserOrganization(){
	var userId = $("#userId").val();
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
    var nodes = zTree.getCheckedNodes(true);
    if(nodes.length == 0){
    	JRYPopup.Jalert("请选择机构");
    	return;
    }
    var ids = "";
    for(var i = 0; i < nodes.length; i++){
    	ids += nodes[i].id + ",";
    }
    ids = ids.substring(0,ids.length - 1);
	$.ajax({
        type: "POST",
        url: "user/grentUserOrganization",
        data: {userId:userId,organizationids:ids},
        success: function (data) {
            if (data.code == '10000') {
                loadData(1, pageSize);
                $("#userId").val("");
                JRYPopup.popupClose();
                JRYPopup.Jalert("选择成功！")
            } else {
                JRYPopup.Jalert(data.message)
            }
        },
        error: function () {
            JRYPopup.Jalert("选择失败！");
        }
    })
}
//取消授权
function orgCancel(){
	JRYPopup.popupClose();
}
//导出
function exportList(){
	var data = $("#findForm").serialize();
	//alert(data);
	location.href = $("#basePath").val() + "user/exportUsers?" + data;
}
