var pageSize = 10;
var basepaths = $("#basePath").val();
$(function(){
	//初始化表格
	initExamType(1,pageSize);
})

function initExamType(pageNum,pageSize){
    if(isNaN(pageNum)){
        JRYPopup.Jalert("请输入正确的页码");
        return;
    }
    if(pageNum < 1){
        JRYPopup.Jalert("页码应从1开始");
        return;
    }
	var data = {pageNum:pageNum,pageSize:pageSize};
	$.post(basepaths+'examtype/queryExamTypes',data,function(html){
		$("#showExamTypeList").html(html);
		JRYTable.tableInit("showExamTypeList","deleteByChiose","choiceNum");
		var pageTotal = $("#pageCss").find(".pageTotal").val();
		JRYPage.pageInit('pageCss',pageNum,pageTotal,11,changePageType);
	})
}
//上一页
function proPageType(){
	var pageNow = $("#pageCss").find(".pageNow").val();
	var pageNums = parseInt(pageNow)-1;
	if(pageNums<1){
		return;
	}else{
		initExamType(pageNums,pageSize);
	}
}
//下一页
function nextPageType(){
	var pageNow = $("#pageCss").find(".pageNow").val();
	var pageTotal = $("#pageCss").find(".pageTotal").val();
	var pageNums = parseInt(pageNow)+1;
	if(pageNums > pageTotal){
		return;
	}else{
		initExamType(pageNums,pageSize);
	}
}

//分页
function changePageType(obj,pages){
	 var pageNums = 1;
	 if(pages){
		 pageNums = pages;
	 }else{
		 pageNums = $(obj).text();
	 }
	 var pageTotal = $("#pageCss").find(".pageTotal").val();
	 if(pageNums!='...'){
		 pageNums = parseInt(pageNums);
		 pageTotal = parseInt(pageTotal);
		 if (pageNums>pageTotal) {
             JRYPopup.Jalert("输入的页码超出最大范围");
             return;
		 }
		 initExamType(pageNums,pageSize);
	 }
}
//批量删除
function deleteByChiose(){
	if($("input[name='choiceNum']:checked").length <= 0){
		JRYPopup.Jalert("请选择删除项");
		return;
	}
	JRYPopup.Jconfim('确定要删除已选择的数据吗？',deleteByChioseT,"");
}
function deleteByChioseT(){
	var ids = "";
	$("input[name='choiceNum']:checked").each(function(){
		ids += $(this).val()+",";
	});
	var data = {ids:ids}
	$.ajax({
		url:basepaths+'examtype/deleteExamTypeByIds',
		data:data,
		type:'post',
		success:function(res){
			if(res.result!='0'){
				var pageNow = $("#pageCss").find(".pageNow").val();
				if(pageNow > 0){
                    initExamType(pageNow - 1,pageSize);
                }
				examCancelType();
			}else{
			    JRYPopup.Jalert("操作失败");
			}
		},error:function(res){
			JRYPopup.Jalert("操作失败");
		}
	})
}

//打开新建标签
function newExamType(){
	JRYPopup.Jcustom("newExamType");
    $('#examTypeNo').css("readonly",false);
    $('#examTypeNo').css("cursor",'');
    $(".Jcustom_title").html("新增考试类型");
}
//关闭新建类型标签
function examCancelType(){
	JRYPopup.popupClose();
}
//保存考试类型
function typeSaveOrEdit(){
	var data = $(".SaveType").serialize();
	//验证非空
 	var examTypeName = $("#examTypeName").val();
 	var examTypeNo = $("#examTypeNo").val();
 	$(".Jcustom_content_items").removeClass("haserror");
	$(".error_text").html("");
	var reg = /^\+?[1-9][0-9]*$/;
	if(!reg.test(examTypeNo)){
		$("#examTypeNo").closest(".Jcustom_content_items").addClass("haserror");
		$("#examTypeNo").parent().find(".error_text").html("考试类型编号只能是1～999的正整数");
		//清除提示信息
        $("#examTypeNo").focus(function(){
			$("#examTypeNo").parent().find(".error_text").html("");
			$("#examTypeNo").closest(".Jcustom_content_items").removeClass("haserror");
		});
		return;
	}
	if(examTypeName == ""){
		$("#examTypeName").closest(".Jcustom_content_items").addClass("haserror");
		$("#examTypeName").parent().find(".error_text").html("请填写正确的类型名称");
        $("#examTypeName").focus(function(){
            $("#examTypeName").parent().find(".error_text").html("");
            $("#examTypeName").closest(".Jcustom_content_items").removeClass("haserror");
        });
		return;
	}
	$.ajax({
		url:basepaths+'examtype/examTypeSaveOrUpdata',
		data:data,
		type:'post',
		success:function(res){
			if(res.code=='10000'){
				var pageNow = $("#pageCss").find(".pageNow").val();
				initExamType(pageNow,pageSize);
				examCancelType();
				JRYPopup.Jalert("操作成功");
			 }else{
				 JRYPopup.Jalert(res.message);
			 }
		},error:function(res){
			JRYPopup.Jalert("操作失败");
		}
	})
}
//编辑
function editType(obj){
	var id = $(obj).parent().parent().children().eq(0).attr("data-id");
	var examTypeNo = $(obj).parent().parent().children().eq(1).text();
 	var examTypeName = $(obj).parent().parent().children().eq(2).text();
 	newExamType();
 	$("#id").val(id);
 	$("#examTypeNo").val(examTypeNo);
 	$("#examTypeName").val(examTypeName);
    $('#examTypeNo').css("readonly",true);
    $('#examTypeNo').css("cursor",'no-drop');
    $(".Jcustom_title").html("编辑考试类型");
}
//删除
function deletExamTypeS(obj){
	var id = $(obj).parent().parent().children().eq(0).attr("data-id");
	JRYPopup.Jconfim('删除考试类型后对应的考试计划也会被一并删除，确定删除该考试类型吗？',deletExamTypeT,id);
}
function deletExamTypeT(id){
	var data = {id:id}
	 $.ajax({
		 url:basepaths+'examtype/deleteExamType',
		 data:data,
		 type:'post',
		 success:function(res){
			 var result = res.result;
			 if(result=="1"){
				 var pageNow = $("#pageCss").find(".pageNow").val();
				 JRYPopup.popupClose();
				 initExamType(pageNow,pageSize);
			 }else{
				 JRYPopup.popupClose();
				 JRYPopup.Jalert("操作失败");
			 }
		 },error:function(){
			 JRYPopup.popupClose();
			 JRYPopup.Jalert("操作失败");
		 }
	 })
}