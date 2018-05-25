var basepaths = $("#basePath").val();
$(function(){
    loadData(1);
});
	 	
//上一页
function proPage(){
	var pageNow = $("#pageCss").find(".pageNow").val();
	var pageNums = parseInt(pageNow)-1;
	if(pageNums<1){
		return;
	}else{
		loadData(pageNums);
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
		loadData(pageNums);
	}
}
//分页
function changePage(obj,pages){
	if(pages==""){
		JRYPopup.Jalert("请输入页码！");
	}else{
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
			loadData(pageNums);
		}
	}
}

//改变pagesize
function changePageSize(value){
    $("#pageSize").val(value);
    loadData($("#pageNum").val());
}
	         	 
//加载table list数据
function loadData(pageNums){
    if(isNaN(pageNums)){
        JRYPopup.Jalert("请输入正确的页码");
        return;
    }
    if(pageNums < 1){
        JRYPopup.Jalert("页码应从1开始");
        return;
	}
	var isUpperOrg = $("#isUpperOrg").val();
// 	if(validateCriteriaForm()){
	var basePath = $("#basePath").val();
	var pageSize = 10;
	$("#pageNum1").val(pageNums);
	var url="device/queryDevices.do";
	$.ajax({
		cache: true,
		type: "POST",
		url: url,
		dataType: "json",
		data:$('#searchCriteriaForm').serialize()+'&'+$('#naviForm').serialize(),
		success:function(data){

			var html = "";
			//isUpperOrg==true 为上级,显示数据的组织机构
			if(isUpperOrg){
				html += "<tr><th><input id='delAll' type='checkbox' onclick='toggleSelectAll(this)'/></th>"
						+ "<th>序号</th><th>组织机构</th><th>类型</th><th>IP地址</th><th>MAC地址</th><th>地点</th><th>版本号</th>"
						+ "<th>状态</th><th>工作状态</th><th>受控状态</th><th>开启模块</th><th>操作</th></tr>";
			}else{
				html += "<tr><th><input id='delAll' type='checkbox' onclick='toggleSelectAll(this)'/></th>"
					+ "<th>序号</th><th>类型</th><th>IP地址</th><th>MAC地址</th><th>地点</th><th>版本号</th>"
					+ "<th>状态</th><th>工作状态</th><th>受控状态</th><th>开启模块</th><th>操作</th></tr>";
			}


			//先清空table
			/*var tb = document.getElementById('table');
			var rowNum=tb.rows.length;
			for (i=1;i<rowNum;i++){
				tb.deleteRow(i);
				rowNum=rowNum-1;
				i=i-1;
			}*/
			if(data.result.total == 0){
//	  	            		$tr = "<font color='red'>没有相关数据展示</font>";
//	  	            		$("#table").append($tr);
				html += "<tr><td colspan='10' class='text-danger text-center'>没有相关数据</td></tr>";
			}else{
				var result=data.result.list;
				for(var i=0;i<result.length;i++){
					var index = i+1;
					var type = "未知";
					var status = "未知";
					var workStatus = "未知";
					var controlled = "未知";
					var operationType = "未知";

					if(result[i].type==1){
						type = "侦测";
					}else if(result[i].type==2){
						type = "阻断";
					}

					if(result[i].status==1){
						status = "在线";
					}else if(result[i].status==2){
						status = "离线";
					}

					if(result[i].workStatus==1){
						workStatus = "无考试计划";
					}else if(result[i].workStatus==2){
						workStatus = "考中";
					}else if(result[i].workStatus==3){
						workStatus = "考间";
					}else if(result[i].workStatus==4){
						workStatus = "空闲";
					}

					if(result[i].controlled==1){
						controlled = "自动";
					}else if(result[i].controlled==2){
						controlled = "手动";
					}

					if(result[i].operationType==1){
						operationType = "自动";
					}else if(result[i].operationType==2){
						operationType = "手动-全部";
					}else if(result[i].operationType==3){
						operationType = "手动-1G";
					}else if(result[i].operationType==4){
						operationType = "手动-手机";
					}else if(result[i].operationType==5){
						operationType = "手动-未选";
					}

					//
					html += "<tr><td>";
					if(result[i].type!=1){//这侧设备不允许删除
						html += "<input name='ids' type='checkbox' value='"+result[i].id+" ' />"
					}
					html += "</td><td>" + index + "</td>";
					if(isUpperOrg){
						html += "<td>" + result[i].organization.name + "</td>";
					}
					html += "<td >"+type+"</td>"
							+"<td >"+result[i].ip+"</td>"
							+"<td >"+result[i].mac+"</td>";
					if(result[i].address == null){
					    html += "<td></td>";
                    }else{
					    html += "<td >"+result[i].address+"</td>";
                    }

					html +=	"<td >"+result[i].version+"</td>"
							+"<td >"+status+"</td>";

					if(result[i].type==1){
					    html += "<td >"+workStatus+"</td>"
                                +"<td >"+ '---' +"</td>"
                                +"<td >"+ '---' +"</td>";
                    }else if(result[i].type==2){
                        html += "<td >"+ '---' +"</td>"
                                +"<td >"+controlled+"</td>"
                                +"<td >"+operationType+"</td>";
                    }
					html+= "<td >"
                            +"<img title='编辑' onclick='goEdit(this)' class='tdImg' name='"
                            +result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/edit.png'>"
							+"<img title='删除' onclick='del(this)' class='tdImg' name='"
							+result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/deleteT.png'>"

					if(result[i].type=="2" && result[i].status==1 ){//在线的阻断设备可开机
						html += "<img title='开机' style='border-width:0px;visibility:visible;' onclick='boot(this)' class='tdImg' name='"
							+result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/boot.png'>";
					}
					html += "</td></tr>";


						/*$tr = "<tr>"
						+"<td>"
						if(result[i].type!=1){//这侧设备不允许删除
							$tr+="<input name='ids' type='checkbox' value='"+result[i].id+" ' />"
						}
						+"</td>"
						if(pageNums==0){
							$tr+="<td >"+(parseInt(i)+1)+"</td>"
						}else{
							$tr+="<td >"+(parseInt(i)+1+(pageNums-1)*pageSize)+"</td>"
						}

						$tr+="<td >"+type+"</td>"
						+"<td >"+result[i].ip+"</td>"
						+"<td >"+result[i].mac+"</td>"
						+"<td >"+result[i].version+"</td>"
						+"<td >"+status+"</td>"
						+"<td >"+workStatus+"</td>"
						+"<td >"+controlled+"</td>"
						+"<td >"+operationType+"</td>"
						   // +"<img title='编辑' onclick='goEdit(this)' class='tdImg' name='"
							//+result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/edit.png'>"
						$tr+=
						"<td >"

							+"<img title='删除' onclick='del(this)' class='tdImg' name='"
							+result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/deleteT.png'>"

						if(result[i].type=="2" && result[i].status==1 ){//在线的阻断设备可开机
							$tr+="<img title='开机' style='border-width:0px;visibility:visible;' onclick='boot(this)' class='tdImg' name='"
								+result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/boot.png'>";
						}else {
							$tr+="<img title='开机' style='border-width:0px;visibility:hidden;' onclick='boot(this)' class='tdImg' name='"
								+result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/boot.png'>";
						}
						$tr+="</td></tr>";

					$("#table").append($tr);*/
				}
			}
			var tbody = $("#deviceList");
			tbody.html(html);

			$("#pageNum").val(data.result.pageNum);
			$("#pages").val(data.result.pages);

			var pageTotal = $("#pageCss").find(".pageTotal").val();
				JRYPage.pageInit('pageCss',pageNums,pageTotal,11,changePage);
		},
		error: function (msg) {
			JRYPopup.Jalert("数据加载失败!");
		}
	})
// 	 		}

}
	 	
//检索条件验证
function validateCriteriaForm(){
	$("#searchCriteriaForm").find("font").remove();
	var flag=true;

    //ip地址校验
	var ipVal=$("#ipSearch").val();
	var re =  /^([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/;
	if(ipVal!=""&&!re.test(ipVal)){
		abscissaRed('ipSearch',"IP地址格式不正确!");
		flag=false;
	}

    //mac地址校验
	var macVal=$("#macSearch").val();
	var patternMac=/[A-F0-9]{2}(-[A-F0-9]{2}){5}/;
	if(macVal!=""&&!patternMac.test(macVal)){
		abscissaRed('macSearch',"MAC地址格式不正确!");
		flag=false;
	}

	return flag;
}
	 	
//弹出新增窗口
function goAdd(){

	JRYPopup.Jcustom("editDiv");
	$("#editBtn").attr("onclick","add()");
	$("#titleId").text("新增设备");
}
//新增设备
function add(){
	if(validateEditForm()){
		var type=$("#type").val();
		var ip=$("#ip").val();
		var mac=$("#mac").val();
		var versionNumber=$("#versionNumber").val();
		$.ajax({
			type:"POST",
			url:"device/saveEquipment.do",
			data:$('#editForm').serialize(),
			success:function(data){
				 if(data.code=='10000'){
					 CancelPop();
					loadData(1);
					JRYPopup.Jalert("填加成功！");
				 }else{
					 var msgs = data.message;
					 if(msgs.type!=undefined){
						 abscissaRed('type',msgs.type);
					 }
					 if(msgs.ip!=undefined){
						 abscissaRed('ip',msgs.ip);
					 }
					 if(msgs.mac!=undefined){
						 abscissaRed('mac',msgs.mac);
					 }
					 }
				 },

			error:function(){
				JRYPopup.Jalert("填加失败！");
			}
		})
	}

}
//清空输入框内的数据和验证提示信息
function clearEditForm(){
    $("#editDiv").find("font").remove();
    $(".edit").each(function(){
        $(this).val("");
    })
}
//必填信息验证
function validateEditForm(){
    $("#editForm").find("font").remove();
    var flag=true;
    var inputs=$(".required");
    inputs.each(function(){
        if(this.value==''){
            abscissaRed(this.id,"&nbsp必填");
            flag=false;

        }
    });

    //ip地址校验
    var ipVal=$("#ip").val();
    var re =  /^([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/;
    if(ipVal!=""&&!re.test(ipVal)){
        //$("#ip").after("<p class='validateMsg' style='color:red'> ip地址格式不正确，请修改</p>");
        abscissaRed('ip',"&nbspip地址格式不正确，请修改");
        flag=false;
    }

    //mac地址校验
    var macVal=$("#mac").val();
    var patternMac=/[A-F0-9]{2}(-[A-F0-9]{2}){5}/;
    if(macVal!=""&&!patternMac.test(macVal)){
    //$("#mac").after("<p class='validateMsg' style='color:red'> mac地址格式不正确，请修改</p>");
        abscissaRed('mac',"&nbspmac地址格式不正确，请修改");
        flag=false;
    }
    return flag;
}
//开机
function boot(e){
    var id = e.name;
    $("#hiddenId").val(id);
    $.ajax({
        async: false,
        url:"device/queryDeviceById",
        data:{"id":id},
        type:"POST",
        success: function(data){
            if(data.result!=null){
                if(data.result.controlled==1){
                    $("#autoRadio_JRY").attr("checked","checked");
                    disableModule();
                }else{
                    enableModule();
                    $("#autoRadio_JRY").attr("checked",false);
                    $("#manualRedio_JRY").attr("checked","checked");
                }

                if(data.result.operationType==2){
                    $("#1g_JRY").attr("checked","checked");
                    $("#phone_JRY").attr("checked","checked");
                }else if(data.result.operationType==3){
                    $("#1g_JRY").attr("checked","checked");
                    $("#phone_JRY").removeAttr("checked");
                }else if(data.result.operationType==4){
                    $("#phone_JRY").attr("checked","checked");
                    $("#1g_JRY").removeAttr("checked");
                }else if(data.result.operationType==5){
                    $("#phone_JRY").removeAttr("checked");
                    $("#1g_JRY").removeAttr("checked");
                }
            }
        }

    } );
    JRYPopup.Jcustom("bootDiv");
    $("#bootTitle").text("选择控制方式");

}
 function disableModule(){
	 $(".moduleInput").prop("checked",false);//从手动转为自动时,取消全选
     $(".moduleInput").prop("disabled",true);
 }
 function enableModule(){
     $(".moduleInput").prop("disabled",false);
 }
function doBoot(){
    $.ajax({
        type:"POST",
        url:"device/bootDevice",
        data:$("#bootForm").serialize(),
        success:function(data){
            if(data.code == '10000'){
                CancelPop();
                loadData(1);
            }else{
                JRYPopup.Jalert(data.message);
            }
        },
        error:function(){
            JRYPopup.Jalert("网络错误");
        }
    })

}
//弹出编辑窗口
function goEdit(e){
    JRYPopup.Jcustom("editDiv");
    //clearEditForm();
    $("#titleId").text("编辑设备信息");
    $("#editBtn").attr("onclick","edit()");
    var id=e.name;
    $.get("device/queryDeviceById.do?id="+id,function(data){
        var device =data.result;
        $("#id").val(device.id);
        $("#type").val(device.type);
        $("#ip").val(device.ip);
        $("#mac").val(device.mac);
        $("#version").val(device.version);
        $("#address").val(device.address);
    });

}
//修改
function edit(){
    if(validateEditForm()){
        $.ajax({
            type:"POST",
            url:"device/updateDevice",
            data:$('#editForm').serialize(),
            success:function(data){
                if(data.code=='10000'){
                    CancelPop();
                    loadData(1);
                    JRYPopup.Jalert("修改成功！")
                 }else{
                    JRYPopup.Jalert(data.message)
                 }
            },
            error:function(){
                JRYPopup.Jalert("修改失败！");
            }
        })
    }

}
	 	
 //取消弹出框
 function CancelPop(){
     JRYPopup.popupClose();
 }

//删除设备
function del(e){
    var id=e.name;
    JRYPopup.Jconfim('确定要删除已选择的数据吗？', deleteByConfirm, id);
}

function deleteByConfirm(id){
    $.post("device/deleteDevice.do?id="+id,function(data){
        loadData(1);
        JRYPopup.Jalert("删除成功！")
    });
}
//全选和全不选
function toggleSelectAll(e){
    if(e.checked){
        $("#table tbody").find("input[type='checkbox']").prop("checked",true);
    }else{
        $("#table tbody").find("input[type='checkbox']").prop("checked",false);
    }
}
	 	
//批量开启设备
function openOrCloseSelectedDevices(status){
    if($("input[name='ids']:checked").length <= 0){
        if(status==2){
            JRYPopup.Jalert("请选择开启项");
        }else{
            JRYPopup.Jalert("请选择关闭项");
        }
        return;
    }
    if(status==2){
        JRYPopup.Jconfim('确定要开启已选择的设备吗？',ajaxOpenClose,status);
    }else{
        JRYPopup.Jconfim('确定要关闭已选择的设备吗？',ajaxOpenClose,status);
    }


}
function ajaxOpenClose(status){
    var s = "";
    $("input[name='ids']").each(function(){
        var flag = $(this).prop("checked");
        if(flag){
            s += $(this).val()+',';
        }
    })
    var data = {ids:s,operationType:status};
    $.ajax({
        type:"POST",
        url:"device/openOrCloseSelectedDevices",
        data:data,
        success:function(data){
            if(data.code=='10000'){
                loadData(1);
                $("#delAll").prop('checked',false);
                JRYPopup.popupClose();
                JRYPopup.Jalert("操作成功！");
            }else{
                JRYPopup.popupClose();
                JRYPopup.Jalert(data.message);
            }
        },
        error:function(){
            JRYPopup.popupClose();
            JRYPopup.Jalert("网络错误");
        }
    })
}
		
//	  	
	 	
//一键开启设备
function openOrCloseAllDevices(status){
    if(status==2){
        JRYPopup.Jconfim('确定一键开启所有侦测设备？',ajaxOpenCloseAll,status);
    }else{
        JRYPopup.Jconfim('确定一键关闭所有侦测设备？',ajaxOpenCloseAll,status);
    }


}
function ajaxOpenCloseAll(status){
    var data = {operationType:status}
    $.ajax({
        type:"POST",
        url:"device/openOrCloseAllDevices",
        data:data,
        success:function(data){
            if(data.code=='10000'){
                loadData(1);
                $("#delAll").prop('checked',false);
                JRYPopup.popupClose();
                JRYPopup.Jalert("操作成功！");
            }else{
                JRYPopup.popupClose();
                JRYPopup.Jalert(data.message);
            }
        },
        error:function(){
            JRYPopup.popupClose();
            JRYPopup.Jalert("网络错误");
        }
    })
}
		
//一键关闭设备
function closeAllEquments(){
    JRYPopup.Jconfim('确定要关闭已选择的设备吗？',ajaxCloseAll,"");

}
function ajaxCloseAll(){
    $.ajax({
        type:"POST",
        url:"device/closeAllEquments.do",
        success:function(data){
            if(data.code=='10000'){
                loadData(1);
                $("#delAll").prop('checked',false);
                JRYPopup.popupClose();
                JRYPopup.Jalert("成功关闭所有阻断设备！")
             }else{
                JRYPopup.Jalert(data.message)
             }
        },
        error:function(){
            JRYPopup.Jalert("关闭失败！");
        }
    })
}
	 	
//批量删除
function delAll(){
    if($("input[name='ids']:checked").length <= 0){
        JRYPopup.Jalert("请选择删除项");
        return;
    }
    JRYPopup.Jconfim('确定要删除已选择的数据吗？',ajaxDel,"");

}
function ajaxDel(){
    $.ajax({
        type:"POST",
        url:"device/deleteDevices.do",
        data:$('#tbForm').serialize(),
        success:function(data){
            if(data.code=='10000'){
                loadData(1);
                $("#delAll").prop('checked',false);
                JRYPopup.popupClose();
                JRYPopup.Jalert("删除成功！")
             }else{
                JRYPopup.Jalert(data.message)
             }
        },
        error:function(){
            JRYPopup.Jalert("删除失败！");
        }
    })
}
	 	
//导出
function exportDeviceList(){
    var ip=$("#ipSearch").val();
    var mac=$("#macSearch").val();
    var msg=$("#msgSearch").val();
    var type=$("#typeSelect").val();
    var status=$("#statusSelect").val();
    location.href = "device/exportDeviceList.do?ip="+encodeURI(encodeURI(ip))
        +"&mac="+encodeURI(encodeURI(mac)) +"&type="+type+"&status="+status;

}

//设备分组
function deviceGroup(){

}