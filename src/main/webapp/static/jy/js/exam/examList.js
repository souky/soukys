var pageSize = 10;
 $(function(){
	 var pageNum = 1;
	 initTable(pageNum,pageSize);
	 initType();
	 $.fn.datetimepicker.defaults = {
	     //默认语言
	     language: 'zh-CN',
	     //默认选择格式
	     format: "yyyy-mm-dd hh:ii:00",
	     autoclose: true,
	     todayBtn: true,
	     //选择板所在输入框位置
	     pickerPosition: "top-left"
	 };

 })

//修改考试状态,线程开关
function startThread(id,status){
    $.ajax({
        url:$("#basePath").val()+'changeStatus',
        data:{id:id,status:status},
        type:'post',
        success:function(res){
            if(res.code=='10000'){
                var pageNow = $("#pageCss").find(".pageNow").val();
                initTable(pageNow,pageSize);
                examCancel();
                JRYPopup.Jalert("操作成功");
            }else{
                JRYPopup.Jalert(res.message);
            }
        },error:function(){
            JRYPopup.Jalert("网络错误");
        }
    })
}
 // 	导出
function exportExams(){
	location.href = $("#basePath").val()+'exportExams';
}
 
 //新建考试
 function newExam(){
	 JRYPopup.Jcustom("newExam");
	 $("#examStartTime").datetimepicker();
	 $("#examEndTime").datetimepicker();
	 $("#enabled").parent().hide();
	 initNum();
	 
 }
 
//编号自动填写
 function initNum(){
	 $.ajax({
		 url:$("#basePath").val()+'queryMaxExamNo',
		 type:'post',
		 success:function(res){
			 if(res.code == "10000"){
				 var maxExamNo = res.result;
				 var examNo;
				 if(maxExamNo == "" || maxExamNo == null){
					 var date = new Date();
					 var year = date.getFullYear();
					 examNo = year + "001"; 
				 }else{
					_maxExamNo = maxExamNo.substring(4);
	 				var num = parseInt(_maxExamNo) + 1;
	 				if(num < 10){
	 					examNo = maxExamNo.substring(0,4) + "00" + num;
	 				}else if(num < 100){
	 					examNo = maxExamNo.substring(0,4) + "0" + num;
	 				} else if(num  < 1000){
	 					examNo = maxExamNo.substring(0,4) + "" + num;
	 				}
				 }
				 if($('#examNo').val() == ""){
					 $('#examNo').val(examNo);
				 }
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
 
 //删除考试数据
 function deletExam(obj){
	 //var uuid= $(obj).parent().parent().children().eq(0).attr("data-id");
	 var id = $(obj).parent().parent().children().eq(0).attr("data-id");
	 JRYPopup.Jconfim('确定要删除这条数据吗？',deletExamT,id);
 }
 function deletExamT(id){
	 var data = {id:id}
	 $.ajax({
		 url:$("#basePath").val()+'deleteExam',
		 data:data,
		 type:'post',
		 success:function(res){
			 var result = res.result;
			 if(result=="1"){
				 var pageNow = $("#pageCss").find(".pageNow").val();
				 var trs = $('#examTable tr');
				 if(trs.length == 1 && pageNow > 1){
				     pageNow -= 1;
                 }
				 initTable(pageNow,pageSize);
				 JRYPopup.popupClose();
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
 
 
 //保存考试数据 更新数据
 function examSave(){
	 //验证非空
	 var id = $("#id").val();
	 var examNo = $("#examNo").val();
	 var examName = $("#examName").val();
	 var examStartTime = $("#examStartTime").val();
	 var examEndTime = $("#examEndTime").val();
	 var examTypeId = $("#examTypeId").val();
	 $(".Jcustom_content_items").removeClass("haserror");
	 $(".error_text").html("");
	 var reg = /^\s*$/;
	 var regNum = /^[0-9]*$/;
	 if(reg.test(examName)){
		 $("#examName").closest(".Jcustom_content_items").addClass("haserror");
		 $("#examName").parent().find(".error_text").html("请填写正确的考试名称");
		 //清除提示信息
         $("#examName").focus(function(){
             $("#examName").parent().find(".error_text").html("");
             $("#examName").closest(".Jcustom_content_items").removeClass("haserror");
         });
		 return;
	 }
	 /*if(!regNum.test(examNo) || examNo==''){
		 $("#examNo").closest(".Jcustom_content_items").addClass("haserror");
		 $("#examNo").parent().find(".error_text").html("请填写正确的考试编号");
		 return;
	 }*/
	 if(reg.test(examStartTime)){
		 $("#examStartTime").closest(".Jcustom_content_items").addClass("haserror");
		 $("#examStartTime").parent().find(".error_text").html("请选择开始时间");
         $("#examStartTime").focus(function(){
             $("#examStartTime").parent().find(".error_text").html("");
             $("#examStartTime").closest(".Jcustom_content_items").removeClass("haserror");
         });
		 return;
	 }
	if(reg.test(examEndTime)){
		 $("#examEndTime").closest(".Jcustom_content_items").addClass("haserror");
		 $("#examEndTime").parent().find(".error_text").html("请选择结束时间");
        $("#examEndTime").focus(function(){
            $("#examEndTime").parent().find(".error_text").html("");
            $("#examEndTime").closest(".Jcustom_content_items").removeClass("haserror");
        });
		 return;
	}
	if(reg.test(examTypeId)){
		 $("#examTypeId").closest(".Jcustom_content_items").addClass("haserror");
		 $("#examTypeId").parent().find(".error_text").html("请选择考试类型");
		 return;
	 }
	 var data = $(".saveAndEdit").serialize();
	 $.ajax({
		 url:$("#basePath").val()+'saveOrUpdateExam',
		 data:data,
		 type:'post',
		 success:function(res){
			 if(res.code=='10000'){
				 var pageNow = $("#pageCss").find(".pageNow").val();
				 initTable(pageNow,pageSize);
				 examCancel();
				 JRYPopup.Jalert("操作成功");
			 }else{
				 JRYPopup.Jalert(res.message);
			 }
		 },error:function(){
			 JRYPopup.Jalert("网络错误");
		 }
	 })
 }
 
 //取消新建考试
 function examCancel(){
	 JRYPopup.popupClose();
 }
 
 //编辑考试信息
 function edit(obj){
	 var examId = $(obj).parent().parent().children().eq(0).attr("data-id");
	 var examNo = $(obj).parent().parent().find(".examNo").text();
	 var examName = $(obj).parent().parent().find(".examName").text();
	 //考试计划的开始时间与结束时间
	 var examStartTime = $(obj).parent().parent().find(".startTime").text();
	 var examEndTime = $(obj).parent().parent().find(".endTime").text();
	 var status = $(obj).parent().parent().find(".status").attr("data-status");
	 var examTypeId = $(obj).parent().find(".examTypeId").val();
	 newExam();
	 $("#examId").val(examId);
	 $("#examNo").val(examNo);
	 $("#examName").val(examName);
	 $("#examStartTime").val(examStartTime);
	 $("#examEndTime").val(examEndTime);
	 $("#status").val(status);
	 $("#examTypeId").val(examTypeId);
	 //场次信息显示
	 initexsub();
	 $("#exSub").removeClass("hide");
	 //某些信息禁用
	 $("#typeNum").attr("disabled","disabled");
	 
	 //修改title
	 $(".Jcustom_title").html("编辑信息");
	 $("#enabled").parent().show();
	 $("#subStartTime").datetimepicker();
	 $("#subEndTime").datetimepicker();
	 
	 $(".datetimepicker").hover(function(){
		 $(".Jry_popup").attr("onclick",null);
	 },function(){
		$(".Jry_popup").attr("onclick","JRYPopup.popupClose()");
	 })
	 
 }
 
 //初始化考场信息
 function initexsub(){
	var examId = $("#examId").val();
	var data = {examPlanId:examId};
	 $.ajax({
		url:$("#basePath").val()+'exsub/queryExsubs',
		data:data,
		type:'post',
		success:function(res){
			var html = '<tr><th>场次序号</th><th>场次名称</th><th>开始时间</th><th>结束时间</th><th>操作</th></tr>';
			var list = res.result;
			if(list.length==0){
				html+='<tr><td colspan="5">没有场次信息</td></tr>';
			}else{
				for(var i=0;i<list.length;i++){
					html+="<tr>"
					html+='<td>'+list[i].no+'</td>';
					html+='<td>'+list[i].name+'</td>';
					var databg = new Date();
					databg.setTime(list[i].startTime);
					var dataeg = new Date();
					dataeg.setTime(list[i].endTime);
					html+='<td>'+databg.Format("yyyy-MM-dd HH:mm:ss")+'</td>';
					html+='<td>'+dataeg.Format("yyyy-MM-dd HH:mm:ss")+'</td>';
					html+='<td onclick="deleteSub(this)" data-id="'+list[i].id+'"><img src="'+$("#basePath").val()+'static/jy/img/pcImg/deleteT.png"/></td></tr>';
				}
			}
			$(".exSubTable").find("table").html(html);
		},error:function(res){
		}
	})
 }
 
 //新增场次信息
 function saveExsub(obj){
	 var no = $("#no").val();
	 var name = $("#name").val();
	 var examStartTime = $("#examStartTime").val();
	 var examEndTime = $("#examEndTime").val();
	 var examId = $("#examId").val();
	 var subStartTime = $("#subStartTime").val();
	 var subEndTime = $("#subEndTime").val();
	 
	 
	 var reg = /^\s*$/;
	 var regNum = /^[0-9]*$/;
	 
	 if(!regNum.test(no)){
		 JRYPopup.Jalert("场次号必须为数字");
		 return;
	 }
	 if(reg.test(name)){
		 JRYPopup.Jalert("场次名称不能为空");
		 return;
	 }
	 if(reg.test(subStartTime)){
		 JRYPopup.Jalert("请选择开始时间");
		 return;
	 }
	 if(reg.test(subEndTime)){
		 JRYPopup.Jalert("请选择结束时间");
		 return;
	 }
	 
	 var data = {no:no,name:name,examStartTime:examStartTime,examEndTime:examEndTime,examId:examId,subStartTime:subStartTime,subEndTime:subEndTime}
	 
	 $.ajax({
		url:$("#basePath").val()+'exsub/saveExsub',
		data:data,
		type:'post',
		success:function(res){
			if(res.code=="20000"){
				var	messages = res.message.error;
				JRYPopup.Jalert(messages);
			}else{
				JRYPopup.Jalert("新增场次成功");
				$("#no").val("");
				$("#name").val("");
				$("#subStartTime").val("");
				$("#subEndTime").val("");
				initexsub();
			}
		},error:function(res){
			JRYPopup.Jalert("网络异常");
		}
	})
	 
 }
 
 function deleteSub(obj){
	 var id = $(obj).attr("data-id");
	 var data = {id:id}
	 $.ajax({
		url:$("#basePath").val()+'exsub/deleteExsub',
		data:data,
		type:'post',
		success:function(res){
			if(res.code=="20000"){
				var	messages = res.message.error;
				JRYPopup.Jalert(messages);
			}else{
				JRYPopup.Jalert("删除成功");
				initexsub();
			}
		},error:function(res){
			JRYPopup.Jalert("网络异常");
		}
	})
 }
 
 //初始化考试信息数据
 function initTable(pageNum,pageSize){
     if(isNaN(pageNum)){
         JRYPopup.Jalert("请输入正确的页码");
         return;
     }
     if(pageNum < 1){
         JRYPopup.Jalert("页码应从1开始");
         return;
     }
	 var data = {pageNum:pageNum,pageSize:pageSize}
	 $.post($("#basePath").val()+'showExamList',data,function(html){
		 $("#showExamList").html(html);
		 JRYTable.tableInit("showExamList","deleteByNums","choiceNum");
		 var pageTotal = $("#pageCss").find(".pageTotal").val();
		 JRYPage.pageInit('pageCss',pageNum,pageTotal,11,changePage);

         //考试状态禁用, 当前时间大于考试结束时间
         var td = $('.status');
         if(td != '' && td.length > 0){
             for(var i = 0;i < td.length;i++){
                 var endTime = $(td[i]).prev().text();
                 if(new Date(endTime) < new Date()){
                     $(td[i]).children().each(function(){
                         //$(this).attr("disabled",true);
                         $(this).removeAttr('onclick');
                     })

                 }

             }
         }
	 })
 }
 
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
	var data = {ids:ids}
	$.ajax({
		url:$("#basePath").val()+'deleteExamByNums',
		data:data,
		type:'post',
		success:function(res){
			if(res.result!='0'){
				var pageNow = $("#pageCss").find(".pageNow").val();
				if(pageNow > 1){
				    pageNow -= 1;
                }
				initTable(pageNow,pageSize);
				JRYPopup.popupClose();
			 }else{
				 JRYPopup.Jalert("操作失败");
			 }
		},error:function(res){
			JRYPopup.Jalert("操作失败");
		}
	})
 }
 
 //初始化考试类型
 function initType(){
	 var optionlist = $("#typeNum_JRY").find("option");
	 if(optionlist.length>1){
		 return;
	 }
	 $.ajax({
		 url:$("#basePath").val()+'examtype/getExamTypeData',
		 data:'',
		 type:'post',
		 success:function(res){
			 var result = res.result;
			 var html = '';
			 for(var i = 0;i<result.length;i++){
				 html+='<option value="'+result[i].id+'">'+result[i].examTypeName+'</option>'
			 }
			 $("#examTypeId_JRY").html(html);
		 },error:function(){
			 JRYPopup.Jalert("初始化类型失败");
		 }
	 })
 }
 


 
function showSub(obj){
	var show = $(obj).attr("data-show");
	if(show=='0'){
		var src = $(obj).find(".titleImg img").attr("src").replace("add.png","sub.png");
		$(obj).find(".titleImg img").attr("src",src);
		$(obj).addClass("active");
		$(".exSubTable").slideDown(300);
		$(obj).attr("data-show","1");
	}else{
		var src = $(obj).find(".titleImg img").attr("src").replace("sub.png","add.png");
		$(obj).find(".titleImg img").attr("src",src);
		$(obj).removeClass("active");
		$(".exSubTable").slideUp(300);
		$(obj).attr("data-show","0");
	}
} 

//上一页
 function proPage(){
 	var pageNow = $("#pageCss").find(".pageNow").val();
 	var pageNums = parseInt(pageNow)-1;
 	if(pageNums<1){
 		return;
 	}else{
 		initTable(pageNums,pageSize);
 	}
 }
 //下一页
 function nextPage(){
 	var pageNow = $("#pageCss").find(".pageNow").val();
 	var pageTotal = $("#pageCss").find(".pageTotal").val();
 	var pageNums = parseInt(pageNow)+1;
 	if(pageNums > pageTotal){
 		return;
 	}else{
 		initTable(pageNums,pageSize);
 	}
 }
 //分页
function changePage(obj,pages){
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
		if(pageNums>pageTotal) {
			JRYPopup.Jalert("输入的页码超出最大范围");
			return;
		}
		initTable(pageNums,pageSize);
	}
}
 
Date.prototype.Format = function(fmt){
 	//author: sjn
    var o = {
        "M+" : this.getMonth()+1,                 //月份
		"d+" : this.getDate(),                    //日
		"H+" : this.getHours(),                   //小时
		"m+" : this.getMinutes(),                 //分
		"s+" : this.getSeconds(),                 //秒
		"q+" : Math.floor((this.getMonth()+3)/3), //季度
		"S"  : this.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt))
		fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
		if(new RegExp("("+ k +")").test(fmt))
    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
}