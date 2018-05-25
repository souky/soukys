var pageSize = 10;
$(document).ready(function () {
    loadData(1, pageSize);
    
    $(".a-upload").on("change","input[type='file']",function(){
        var filePath=$(this).val();
        if(filePath.indexOf("xls")!=-1 || filePath.indexOf("xlsx")!=-1){
            var arr=filePath.split('\\');
            var fileName=arr[arr.length-1];
            $(this).parent().find(".text_file").html(fileName)
        }else{
        	$(this).parent().find(".text_file").html("上传格式有误");
            return false 
        }
    })
});
//导入
function submitExcel(){
	    var excelFile = $("#file").val();  
        //如果文件为空  
        if (excelFile == '') {  
            JRYPopup.Jalert('请上传excel文件!');  
            return;  
        }  
  
        /*var option = {  
            url : $("#basePath").val() + "blackwhitelist/importBlackWhiteList",  
            type : 'POST',  
            dataType : "json",  
            clearForm: true,  
            success : function(data) {  
                if (data.code == '10000') {  
                    JRYPopup.Jalert('导入信息成功!');  
                }  
            }  
        };  
        $("#importExcel").ajaxSubmit(option);  */
        $.ajaxFileUpload({ 
            method:"POST",
            url:$("#basePath").val() + "blackwhitelist/importBlackWhiteList", 
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
//导出
function exportList() {
    var frequencyType = $("#frequencyType").val();
    var type = $("#type").val();
    var source = $("#source").val();
    location.href = $("#basePath").val() + "blackwhitelist/exportBlackWhiteList.do?frequencyType="
        + frequencyType + "&type=" + type + "&source=" + source;
};
function loadData(pageNums, pageSize) {
    if(isNaN(pageNums)){
        JRYPopup.Jalert("请输入正确的页码");
        return;
    }
    if(pageNums < 1){
        JRYPopup.Jalert("页码应从1开始");
        return;
    }
    var isUpperOrg = $("#isUpperOrg").val();
    var blackwhitelist = $("#findForm").serialize();
    var basePath = $("#basePath").val();
    blackwhitelist += "&pageNum=" + pageNums + "&pageSize=" + pageSize;
    $.param(blackwhitelist);
    $.ajax({
        url: $("#basePath").val() + "blackwhitelist/queryBlackWhiteLists",
        async: false,
        dataType: "json",
        type: "POST",
        data: blackwhitelist,
        success: function (data) {
            var html = "";
            var pageNum = data.result.pageNum;
            var pageTotal = data.result.pages;
            if(isUpperOrg){
                html+="<tr><th><input type='checkbox' class='selectAll' name='checkAll'></th><th>序号</th><th>组织机构</th><th>频类</th><th>类型</th><th>主频点/开始频点</th><th>副频点/结束频点</th><th>来源</th><th>操作</th></tr>"
            }else{
                html+="<tr><th><input type='checkbox' class='selectAll' name='checkAll'></th><th>序号</th><th>频类</th><th>类型</th><th>主频点/开始频点</th><th>副频点/结束频点</th><th>来源</th><th>操作</th></tr>"
            }
            $(".pageNow").val(pageNum);
            $(".pageTotal").val(pageTotal);
            if (data.result.list != null) {
                var bwList = data.result.list;
                var frequencyType = "";
                var type = "";
                var source = "";
                for (var i = 0; i < bwList.length; i++) {
                    if(null != bwList[i].frequencyType && bwList[i].frequencyType==1){
                    	frequencyType = "频点";
                    }else if(bwList[i].frequencyType==2){
                    	frequencyType = "频段";
                    }else{
                    	frequencyType = "未知";
                    }
                    
                    if (null != bwList[i].type && bwList[i].type == "1") {
                        type = "黑名单";
                    } else if (null != bwList[i].type && bwList[i].type == "2") {
                        type = "高可疑";
                    }else if (null != bwList[i].type && bwList[i].type == "3") {
                        type = "中可疑";
                    } else if (null != bwList[i].type && bwList[i].type == "4") {
                        type = "低可疑";
                    } else if (null != bwList[i].type && bwList[i].type == "5") {
                    	type = "白名单";
                    }else {
                    	type = "未知";
                    }
                    
                    if (null != bwList[i].source && bwList[i].source == 2) {
                        source = "平台";
                    }else if (null != bwList[i].source && bwList[i].source == 1) {
                        source = "本地";
                    } else {
                    	source = "未知";
                    }

                    if (null != bwList[i].source && bwList[i].source == 2) {
                        html += "<tr><td></td>";
                    } else {
                        html += "<tr><td> <input type='checkbox' name='choiceNum' value='" + bwList[i].id + "'></td>";
                    }
                    html += "<td>" + (i + 1) + "</td>";
                    if(isUpperOrg){
                        html += "<td>" + bwList[i].organization.name + "</td>";
                    }
                    html += "<td>" + frequencyType + "</td>" + "<td>" + type + "</td>";
                    if (!bwList[i].marjorFrequency) {
                        html += "<td></td>";
                    } else {
                        html += "<td>" + (bwList[i].marjorFrequency / 1000).toFixed(3) + "</td>";
                    }
                    if (!bwList[i].secondFrequency) {
                        html += "<td></td>";
                    } else {
                        html += "<td>" + (bwList[i].secondFrequency / 1000).toFixed(3) + "</td>";
                    }
                    if (null != bwList[i].source && bwList[i].source == "2") {
                        html += "<td>" + source + "</td>" +
                            "<td>无权限</td></tr>";
                    } else {
                        html += "<td>" + source + "</td>" +
                            "<td>" +
                            "<img title='编辑' onclick='doEdit(this)' class='tdImg' name=\"" + bwList[i].id + "\" src='" + basePath + "/static/jy/img/pcImg/edit.png'/>" +
                            "<img title='删除' onclick='doDeleted(this)' class='tdImg' name=\"" + bwList[i].id + "\" src='" + basePath + "/static/jy/img/pcImg/deleteT.png'/>" +
                            "<img style='display:none;' title='下发' onclick='doIssued(this)' class='tdImg' name=\"" + bwList[i].marjorFrequency + "\" src='" + basePath + "/static/jy/img/pcImg/issued.png'/>" +
                            "</td></tr>";
                    }
                }

            } else {
                html += "<tr><td colspan='10' class='text-danger text-center'>没有相关数据</td></tr>";
            }
            var tbody = $("#tbody");
            tbody.html(html); // 添加Html内容，不能用Text 或 Val
            $(".assistantStrsTd").hover(function(){
            	//$(this).find(".assistantStrs").removeClass("hide");
            	$(this).popover('show');
            },function(){
            	//$(this).find(".assistantStrs").addClass("hide");
            	$(this).popover('hide');
            })
            JRYTable.tableInit("showBlackwhitelist", "deleteByNums", "choiceNum");
            JRYPage.pageInit('pageCss', pageNum, pageTotal, 11, changePage);
        },
        error: function (data) {
            JRYPopup.Jalert("操作失败");
        }
    });
};

function deleteByNums() {

    if ($("input[name='choiceNum']:checked").length <= 0) {
        JRYPopup.Jalert("请选择删除项");
        return;
    }
    JRYPopup.Jconfim('确定要删除已选择的数据吗？', deleteByNumsT, "");
}

function deleteByNumsT() {
    var ids = "";
    $("input[name='choiceNum']:checked").each(function () {
        ids += $(this).val() + ",";
    });
    var data = {ids: ids}
    $.ajax({
        url: "blackwhitelist/deleteBlackWhiteLists",
        data: data,
        type: 'post',
        dataType:'json',
        success: function (res) {
            if (res.result != '0') {
                var pageNow = $("#pageCss").find(".pageNow").val();
                loadData(1, pageSize);
                JRYPopup.popupClose();
            } else {
                JRYPopup.Jalert("操作失败");
            }
        }, error: function (res) {
            JRYPopup.Jalert("操作失败");
        }
    })
}

//分页
function changePage(obj, pages) {
    var pageNums = 1;
    if (pages) {
        pageNums = pages;
    } else {
        pageNums = $(obj).text();
    }
    var pageTotal = $("#pageCss").find(".pageTotal").val();
    if (pageNums != '...') {
        pageNums = parseInt(pageNums);
        pageTotal = parseInt(pageTotal);
        if (pageNums > pageTotal) {
            JRYPopup.Jalert("输入的页码超出最大范围");
            return;
        }
        loadData(pageNums, pageSize);
    }

}

//上一页
function proPage() {
    var pageNow = $("#pageCss").find(".pageNow").val();
    var pageNums = parseInt(pageNow) - 1;
    if (pageNums < 1) {
        return;
    } else {
        loadData(pageNums, pageSize);
    }
}
//下一页
function nextPage() {
    var pageNow = $("#pageCss").find(".pageNow").val();
    var pageTotal = $("#pageCss").find(".pageTotal").val();
    var pageNums = parseInt(pageNow) + 1;
    if (pageNums > pageTotal) {
        return;
    } else {
        loadData(pageNums, pageSize);
    }
}

//新建黑白名单
function doCreated() {
    //修改标题
    $(".Jcustom_title").text("");// 清空数据
    $(".Jcustom_title").append("新建黑白名单"); // 添加Html内容，不能用Text 或 Val
    JRYPopup.Jcustom("editBlackwhitelist");

    //新增默认为本地数据，切不可编
//    $("#source2").val(1);
    $("#typeSub").remove();
//    $("#source2").attr("disabled", "disabled");
}

//弹出编辑窗口
function doEdit(e) {
    //修改标题
    $(".Jcustom_title").text("");// 清空数据
    $(".Jcustom_title").append("编辑黑白名单"); // 添加Html内容，不能用Text 或 Val
    var id = e.name;

    JRYPopup.Jcustom("editBlackwhitelist");
    $.get("blackwhitelist/getBlackwhitelistById?id=" + id, function (data) {
        var blackwhitelist = data.result;
        
        $("#id").val(blackwhitelist.id);
        $("#frequencyType2").val(blackwhitelist.frequencyType);
        $("#type2").val(blackwhitelist.type);
        $(".sectionLabel").text("");
        
        if (blackwhitelist.frequencyType ==1) {
            $(".sectionLabel").text("主频点:");
            $("#assintPoint").html("副频点:");
        } else {
            $(".sectionLabel").text("开始频点:");
            $("#assintPoint").html("结束频点:");
        }
        $("#marjorFrequency").val((blackwhitelist.marjorFrequency / 1000).toFixed(3));
        
        $("#secondFrequency").val((blackwhitelist.secondFrequency / 1000).toFixed(3));
        
        $("#source2").val(blackwhitelist.source);
        //不可编辑来源信息频类信息,
        $("#type2").attr("disabled", "disabled");
        $("#source").attr("disabled", "disabled");
    });
}

//编辑页面，频点频段变化
function changeSectionValue(obj) {
    var type = $(obj).val();
    if (type == 2) {
        $(".sectionLabel").html("开始频点:");
        $("#assintPoint").html("结束频点:");
        $("#marjorFrequency").attr("placeholder", "请输入开始频点");
        $("#secondFrequency").attr("placeholder", "请输入结束频点");
    } else {
        $(".sectionLabel").html("主频点:");
        $("#assintPoint").html("副频点:");
        $("#marjorFrequency").attr("placeholder", "请输入主频点");
        $("#secondFrequency").attr("placeholder", "请输入副频点");
    }

}

//保存
function doSave(){

    var frequencyType = $("#frequencyType2").val();
    var type = $("#type2").val();
    var id = $("#id").val();
    var mFrequency = $("#marjorFrequency").val();
    var sFrequency = $("#secondFrequency").val();

    if(frequencyType == null || frequencyType == ""){
        $("#frequencyType2").closest(".Jcustom_content_items").addClass("haserror");
        $("#frequencyType2").parent().find(".error_text").html("请选择");
        //清除提示信息
        $("#frequencyType2").focus(function(){
            $("#frequencyType2").parent().find(".error_text").html("");
            $("#frequencyType2").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
    }
    if(type == null || type == ""){
        $("#type2").closest(".Jcustom_content_items").addClass("haserror");
        $("#type2").parent().find(".error_text").html("请选择");
        //清除提示信息
        $("#type2").focus(function(){
            $("#type2").parent().find(".error_text").html("");
            $("#type2").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
    }

    if(isNaN(mFrequency) || isNaN(sFrequency)){
        JRYPopup.Jalert("输入的频点只能为数字");
        return;
    }
    var marjorFrequency = parseFloat(mFrequency) * 1000;
    var secondFrequency = parseFloat(sFrequency) * 1000;
    //频点范围100-1300
    if(mFrequency < 100 || mFrequency > 1300 || (marjorFrequency + '').indexOf(".") != -1){
        $("#marjorFrequency").closest(".Jcustom_content_items").addClass("haserror");
        $("#marjorFrequency").parent().find(".error_text").html("输入的频点范围100-1300,最多3位小数");
        $("#marjorFrequency").focus(function(){
            $("#marjorFrequency").parent().find(".error_text").html("");
            $("#marjorFrequency").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
    }
    if(sFrequency < 100 || sFrequency > 1300 || (secondFrequency + '').indexOf(".") != -1){
        $("#secondFrequency").closest(".Jcustom_content_items").addClass("haserror");
        $("#secondFrequency").parent().find(".error_text").html("输入的频点范围100-1300,最多3位小数");
        $("#secondFrequency").focus(function(){
            $("#secondFrequency").parent().find(".error_text").html("");
            $("#secondFrequency").closest(".Jcustom_content_items").removeClass("haserror");
        });
        return;
    }

    if(frequencyType == '2' && secondFrequency <= marjorFrequency){
        JRYPopup.Jalert("结束频点应大于开始频点");
        return;
    }
	
	var data = {
			id:id,
			marjorFrequency:marjorFrequency,
			secondFrequency:secondFrequency,
			frequencyType:frequencyType,
			type:type,
	}
	
	$.ajax({
        type: "POST",
        url: $("#basePath").val()+"blackwhitelist/updateBlackWhiteList",
        data: data,
        success: function (res) {
            if (res.code == '10000') {
                JRYPopup.popupClose();
                loadData(1, pageSize);
                JRYPopup.Jalert("保存成功！")
            } else {
                JRYPopup.Jalert(res.message)
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

//删除黑白名单
function doDeleted(e) {
    JRYPopup.Jconfim('确定要删除这条数据吗？', deleted, e.name);
}

function deleted(id) {
    $.ajax({
        type: "POST",
        url: "blackwhitelist/deleteBlackWhiteList",
        data: {"id": id},
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

//下发数据
function doIssued(e) {
    JRYPopup.Jconfim('确定要下发这条数据吗？', issued, e.name);
}
//TODO 下发功能
function issued(marjorFrequency) {
	var data = {marjorFrequency:marjorFrequency}
	JRYPopup.popupClose();
	JRYPopup.Jloading("正在下发");
	 $.ajax({
        type: "POST",
        url: "blackwhitelist/issuedBWList",
        data: data,
        success: function (data) {
            if (data.code == '10000') {
            	JRYPopup.popupClose();
            	JRYPopup.Jalert("下发成功！");
            } else {
            	JRYPopup.popupClose();
                JRYPopup.Jalert(data.message)
            }
        },
        error: function () {
        	JRYPopup.popupClose();
        	JRYPopup.Jalert("下发成功！");
        }
    })
    
}