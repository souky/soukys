$(function(){
	initOrganizationListTree();
})

/**
 * 给搜索到的选项加颜色标记
 */
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


/**
 * 无图标的内容
 */
var setting = {
	view : {
		showIcon : true,
		fontCss : {
			'font-size': 56,
		}
	},
	data : {
		simpleData : {
			enable : true,
			idKey : "id",
			pIdKey : "pId"
		}
	},
	check: {
        enable: false
    },
    callback: {
		onClick: zTreeOnClick
	}
};



function initOrganizationListTree () {
	$.ajax({
		type : "POST",
		contentType : "application/json",
		url : $("#basePath").val() +"organization/queryOrganizations",
		data : '',
		success: function (data) {
			var organizations = data.result;
			$.fn.zTree.init($("#organizationListTree"), setting, organizations);
			var treeObj = $.fn.zTree.getZTreeObj("organizationListTree");
			$("#organizationListTree").find(".level0").click();
		}
	});
	
}

function zTreeOnClick(event, treeId, treeNode) {
//    alert(treeNode.id + ", " + treeNode.pId);
	var data = {id:treeNode.id};
	$.ajax({
		type : "POST",
		url : $("#basePath").val() +"organization/getOrganizationById",
		data : data,
		success: function (res) {
			var organization = res.result;
			var html = template("editWithDelete",organization);
			$(".rightPart").html(html);
		}
	});
};

function update(obj){
	var form = $(obj).parent().parent();
	var name = form.find("input[name='name']").val();
	var remark = form.find("input[name='remark']").val();
	var ip = form.find("input[name='ip']").val();
	$(".Jcustom_content_items").removeClass("haserror");
	$(".error_text").html("");
	var reg = /^\s*$/;
	var regIp = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	if(reg.test(name)){
		form.find("input[name='name']").closest(".Jcustom_content_items").addClass("haserror");
		form.find("input[name='name']").parent().find(".error_text").html("机构名称不能为空");
		$("input[name='name']").focus(
				function() {
					$("input[name='name']").parent().find(".error_text").html("");
					$("input[name='name']").closest(".Jcustom_content_items").removeClass("haserror");
				});
		return;
	}
	if(!regIp.test(ip)){
		 form.find("input[name='ip']").closest(".Jcustom_content_items").addClass("haserror");
		 form.find("input[name='ip']").parent().find(".error_text").html("ip不合法");
		 $("input[name='ip']").focus(
					function() {
						$("input[name='ip']").parent().find(".error_text").html("");
						$("input[name='ip']").closest(".Jcustom_content_items").removeClass("haserror");
					});
		 return;
	 }
	var data = form.serialize();
	$.ajax({
		type : "POST",
		url : $("#basePath").val() +"organization/updateOrganization",
		data : data,
		success: function (res) {
			if(res.code=="10000"){
				JRYPopup.Jalert("修改成功");
				initOrganizationListTree();
			}else{
				JRYPopup.Jalert("修改失败："+res.message);
			}
		}
	});
}

function deletes(obj){
	var form = $(obj).parent().parent();
	var data = form.serialize();
	$.ajax({
		type : "POST",
		url : $("#basePath").val() +"organization/deleteOrganization",
		data : data,
		success: function (res) {
			if(res.code=="10000"){
				form.find("input[name='name']").val("");
				form.find("input[name='remark']").val("");
				form.find("input[name='ip']").val("");
				JRYPopup.Jalert("删除成功");
				initOrganizationListTree();
			}else{
				JRYPopup.Jalert("删除失败："+res.message);
			}
		}
	});
}

function save(obj,pid){
	var form = $(obj).parent().parent();
	var name = form.find("input[name='name']").val();
	var remark = form.find("input[name='remark']").val();
	var ip = form.find("input[name='ip']").val();
	$(".Jcustom_content_items").removeClass("haserror");
	$(".error_text").html("");
	var reg = /^\s*$/;
	var regIp = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	if(reg.test(name)){
		form.find("input[name='name']").closest(".Jcustom_content_items").addClass("haserror");
		form.find("input[name='name']").parent().find(".error_text").html("机构名称不能为空");
		$("input[name='name']").focus(
				function() {
					$("input[name='name']").parent().find(".error_text").html("");
					$("input[name='name']").closest(".Jcustom_content_items").removeClass("haserror");
				});
		return;
	}
	if(!regIp.test(ip)){
		 form.find("input[name='ip']").closest(".Jcustom_content_items").addClass("haserror");
		 form.find("input[name='ip']").parent().find(".error_text").html("ip不能为空");
		 $("input[name='ip']").focus(
					function() {
						$("input[name='ip']").parent().find(".error_text").html("");
						$("input[name='ip']").closest(".Jcustom_content_items").removeClass("haserror");
					});
		 return;
	 }
	if(pid){
		var data = {name:name,remark:remark,parentId:pid,ip:ip}
	}else{
		var data = {name:name,remark:remark,ip:ip}
	}
	
	$.ajax({
		type : "POST",
		url : $("#basePath").val() +"organization/saveOrganization",
		data : data,
		success: function (res) {
			if(res.code=="10000"){
				JRYPopup.Jalert("新增成功");
				form.find("input[name='name']").val("");
				form.find("input[name='remark']").val("");
				form.find("input[name='ip']").val("");
				initOrganizationListTree();
			}else{
				JRYPopup.Jalert("新增失败："+res.message);
			}
		}
	});
}