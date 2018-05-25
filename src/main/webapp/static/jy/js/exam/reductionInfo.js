var basepaths = $("#basePath").val();
var listenPath = $("#listenPath").val();
var pageSize = 10;
$(function(){
	//初始化数据
	initQuery();
})

//初始化查询条件
function initQuery(){
	$.ajax({
		url:basepaths+'showExamListData',
		data:'',
		type:'post',
		success:function(res){
			var list = res.result;
			var html = '<option value="">请选择考试名称</option>';
			for(var i=0;i<list.length;i++){
				html += '<option value="'+list[i].id+'">'+list[i].examName+'</option>';
			}
			$("#examPlanId").html(html);
		},error:function(res){
			JRYPopup.Jalert("初始化查询条件失败");
		}
	});
	$("#examPlanId").change(function(){
		var examPlanId = $("#examPlanId").val();
		var data = {examPlanId:examPlanId}
		$.ajax({
			url:basepaths+'exsub/queryExsubs',
			data:data,
			type:'post',
			success:function(res){
				var list = res.result;
				var html = '<option value="">全部场次</option>';
				for(var i=0;i<list.length;i++){
					html += '<option value="'+list[i].id+'">'+list[i].name+'</option>';
				}
				$("#examNumberId").html(html);
			},error:function(res){
				JRYPopup.Jalert("未查询到场次信息");
			}
		});
	})
}


//查询
function queryCheate(pageNum,pageSize){
    if(isNaN(pageNum)){
        JRYPopup.Jalert("请输入正确的页码");
        return;
    }
    if(pageNum < 1){
        JRYPopup.Jalert("页码应从1开始");
        return;
    }
	var examPlanId = $("#examPlanId").val();
	var frequencyPointBegin = $("#frequencyPointBegin").val();
	var frequencyPointEnd = $("#frequencyPointEnd").val();
	var regnum = /\d{3}-\d{3}/;
	if(examPlanId == ""){
		JRYPopup.Jalert("请选择考试名称");
		return;
	}
	if(frequencyPointBegin!=""){
		if(regnum.test(frequencyPointBegin)){
			JRYPopup.Jalert("频点格式错误");
			return;
		}
	}
	if(frequencyPointEnd!=""){
		if(regnum.test(frequencyPointEnd)){
			JRYPopup.Jalert("频点格式错误");
			return;
		}
	}
	
	var data = initData(pageNum,pageSize);
	
	$.post(basepaths+'reductioninfo/queryReductionInfos',data,function(html){
		$("#cheateList .cheateTable").html(html);
		JRYTable.tableInit('cheateTables','','choiceNum');
		var pageTotal = $("#pageCss").find(".pageTotal").val();
		JRYPage.pageInit('pageCss',pageNum,pageTotal,11,changePageCheate);
	})
	
}

//上传作弊信号
function uploadCheat(obj){
	var id = $(obj).parent().parent().children().eq(0).attr("data-id");
	$.ajax({
		url:basepaths+'reductioninfo/uploadReductionInfo',
		data:{id:id},
		type:'post',
		success:function(res){
			if(res.code == "10000"){
				JRYPopup.popupClose();
				JRYPopup.Jalert(res.result);
			}
		},error:function(res){
			JRYPopup.popupClose();
			JRYPopup.Jalert("操作失败");
		}
	})
}


//排除作弊
function Exclude(obj,recognitionResult){
	var info;
	if(recognitionResult == 2){
		info = '确定要排除作弊吗？';
	}else if(recognitionResult == 1){
		info = '确认为作弊吗？';
	}
	var id = $(obj).parent().parent().children().eq(0).attr("data-id");
	JRYPopup.Jconfim(info,ExcludeT,id + "-" + recognitionResult);
}

function ExcludeT(str){
	var arr = str.split('-');
	var id = arr[0];
	var recognitionResult = arr[1];
	var data = {id:id,recognitionResult:recognitionResult};
	$.ajax({
		url:basepaths+'reductioninfo/updateReductionInfo',
		data:data,
		type:'post',
		success:function(res){
			if(res.code == '10000'){
				/*if(recognitionResult == 2){
					$("#cheateList td[data-id='"+id+"'").parent().find(".recognitionResult").text("非作弊");
				}else if(recognitionResult == 1){
					$("#cheateList td[data-id='"+id+"'").parent().find(".recognitionResult").text("确认作弊");
				}*/
				JRYPopup.popupClose();
				var pageNum = $('.pageNow').val();
				queryCheate(pageNum,10);
			}else{
				JRYPopup.popupClose();
				JRYPopup.Jalert(res.message);
			}
		},
		error:function(res){
			JRYPopup.popupClose();
			JRYPopup.Jalert("网络连接错误");
		}
	})
}

/*function ischeat(obj){
	var uid = $(obj).parent().parent().children().eq(0).attr("data-id");
	JRYPopup.Jconfim('确认为作弊吗？',ischeatT,uid);
}

function ischeatT(uid){
	var reductState = "确认作弊";
	var data = {uid:uid,reductState:reductState};
	$.ajax({
		url:basepaths+'reductioninfo/updateReductionInfo',
		data:data,
		type:'post',
		success:function(res){
			if(res.result>0){
				$("#cheateList td[data-id='"+uid+"'").parent().children().eq(8).text("确认作弊");
				JRYPopup.popupClose();
			}else{
				JRYPopup.popupClose();
				JRYPopup.Jalert("操作失败");
			}
		},error:function(res){
			JRYPopup.popupClose();
			JRYPopup.Jalert("操作失败");
		}
	})
}*/

//试听
function listen(obj){
	//var src=listenPath+$(obj).attr("data-src");
	//$("#wrapper_JRY").find("audio source").attr("src",src);
	var id = $(obj).parent().parent().find("td:eq(0)").attr("data-id");
	var html = '<audio preload="auto" controls>';
	$.ajax({
		url:basepaths+'reductioninfo/listen',
		data:{id:id},
		type:'post',
		success:function(res){
			if(res.code == "10000"){
				var src1 = res.result;
				html += '<source src="'+src1+'"></audio>'
				JRYPopup.Jcustom("wrapper_JRY",function(){});
				$("#play").html(html);
				listenPer();
				//$(".Jry_popup").attr("onclick",'listenClose()');
			}else{
				JRYPopup.popupClose();
				JRYPopup.Jalert(res.message);
			}
		},error:function(res){
			JRYPopup.popupClose();
			JRYPopup.Jalert('网络错误');
		}
	});
}
function listenPer(){
	$( '#play audio' ).audioPlayer();
	$( '#play .audioplayer-playpause' ).click();
}

//function listenClose(){
//	JRYPopup.popupClose();
//	$("#play").html("");
//	$(".Jry_popup").attr("onclick",'JRYPopup.popupClose()');
//}

function preview(obj){
	var id = $(obj).parent().parent().find("td:eq(0)").attr("data-id");
	//var src = $(obj).attr("data-src");
	$.ajax({
		url:basepaths+'reductioninfo/readTxt',
		data:{id:id},
		type:'post',
		success:function(res){
			var list = res.result;
			var html = '<pre>';
			for(var i = 0 ;i<list.length;i++){
				html+=list[i]+"</br>";
			}
			html+="</pre>";
			JRYPopup.Jcustom("readTxt");
			$("#readTxtId").html(html);
		},error:function(res){
			JRYPopup.popupClose();
			JRYPopup.Jalert("操作失败");
		}
	})
}

function cancelRead(){
	JRYPopup.popupClose();
}

//上一页
function proPageCheate(){
	var pageNow = $("#pageCss").find(".pageNow").val();
	var pageNums = parseInt(pageNow)-1;
	if(pageNums<1){
		return;
	}else{
		queryCheate(pageNums,pageSize);
	}
}
//下一页
function nextPageCheate(){
	var pageNow = $("#pageCss").find(".pageNow").val();
	var pageTotal = $("#pageCss").find(".pageTotal").val();
	var pageNums = parseInt(pageNow)+1;
	if(pageNums > pageTotal){
		return;
	}else{
		queryCheate(pageNums,pageSize);
	}
}

//分页
function changePageCheate(obj,pages){
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
		queryCheate(pageNums,pageSize);
	}
	
}



//封装data
function initData(pageNum,pageSize){
	var examPlanId = $("#examPlanId").val();
	var examNumberId = $("#examNumberId").val();
	var suffix = $("#suffix").val();
	var signalType = $("#signalType").val();
	var recognitionResult = $("#recognitionResult").val();
	var frequencyPointBegin = $("#frequencyPointBegin").val();
	var frequencyPointEnd = $("#frequencyPointEnd").val();
	var data = {
		examPlanId:examPlanId,
		examNumberId:examNumberId,
		suffix:suffix,
		signalType:signalType,
		recognitionResult:recognitionResult,
		frequencyPointBegin:frequencyPointBegin,
		frequencyPointEnd:frequencyPointEnd,
		pageNum:pageNum,
		pageSize:pageSize
	}
	return data;
}