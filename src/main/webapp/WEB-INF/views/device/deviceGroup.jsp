<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <%@ include file="/WEB-INF/views/version.jsp"%>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
		<link href="<%=basePath%>/static/common/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>static/common/css/bootstrap-datetimepicker.min.css"/>
        <style>
            th{
                text-align: center;
            }

        </style>
        <script type="text/javascript">
			
            $(document).ready(function() {
            	//初始化页面数据
            	initTable(1);

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

            });
            
            function initTable(pageNum){
            	//alert(43242);
            	var pageSize = 10;
            	var pages = $("#pages").val();
            	if(!parseInt(pageNum) > 0){
            		alert("页码只能从1开始");
            		$("#toPageNum").val("");
            		return;
            	}
            	
            	$.ajax({
            		url:"<%=basePath%>devicegroup/queryDeviceGroups",
            		type: "POST",
            		data: "pageNum=" + pageNum + "&pageSize=" + pageSize,  
            		dataType :"json",
            		success	:function(data){
            			var tb = document.getElementById('table_1');
            		    var rowNum=tb.rows.length;
            		    for (i=1;i<rowNum;i++){
            		        tb.deleteRow(i);
            		        rowNum=rowNum-1;
            		        i=i-1;
            		    }
            		    
            		    var $tr;
            		    if(data.result.total > 0){
	            			//alert(data.result.list[0].beginTime.substring(0,19));
            		    	for(var i = 0; i < data.result.list.length; i++){
	            				var deviceGroup = data.result.list[i];
	            				
	           					$tr = "<tr>"
	           							+"<td>"+ (i + 1) +"</td>"
	           							+"<td>"+ deviceGroup.groupName +"</td>"
			           					+"<td>"+ deviceGroup.userName +"</td>";

			           			if(deviceGroup.startTime != null){
			           				$tr += "<td>"+ timestampFormat(deviceGroup.startTime) +"</td>";
			           			}else{
			           				$tr += "<td></td>";
			           			}
                                if(deviceGroup.endTime != null){
                                    $tr += "<td>"+ timestampFormat(deviceGroup.endTime) +"</td>";
                                }else{
                                    $tr += "<td></td>";
                                }
                                if(deviceGroup.controlModule == 0){
                                    $tr += "<td>全部</td>";
                                }else if(deviceGroup.controlModule == 1){
                                    $tr += "<td>1g</td>";
                                }else if(deviceGroup.controlModule == 2){
                                    $tr += "<td>手机</td>";
                                }else{
                                    $tr += "<td></td>";
                                }

                                if(deviceGroup.isActive == 1){
                                    $tr += "<td>激活</td>";
                                }else{
                                    $tr += "<td>禁用</td>";
                                }

			           			$tr += "<td>" +
		                                "<img title='编辑' onclick='doEdit(this)' class='tdImg' id='" + deviceGroup.id + "' src='"+ "<%=basePath%>static/jy/img/pcImg/edit.png" +"'/>" +
		                                "<img title='删除' onclick='doDeleted(this)' class='tdImg' id='" + deviceGroup.id + "' src='" + "<%=basePath%>static/jy/img/pcImg/deleteT.png" + "'/>" +
		                                "<img title='所属设备列表' onclick='addEquipments(this)' class='tdImg' id='" + deviceGroup.id + "' src='"+ "<%=basePath%>static/jy/img/pcImg/openClose.png" +"'/>" +
	                              	"</td>";
			           			$tr += "</tr>";
			           			
	           					$("#table_1").append($tr);
	            			}
            		    }
            			//
                    	$("#pageNum").val(data.result.pageNum);
                    	$("#pages").val(data.result.pages);
                    	
                    	var pageTotal = $("#pageCss").find(".pageTotal").val();
               		 	JRYPage.pageInit('pageCss',pageNum,pageTotal,11,changePage);
            			
            		},
            		error:function(data){
                        JRYPopup.Jalert("网络错误");
            		}
           		});
            	
            }
        	
        	//上一页
        	 function proPage(){
        	 	var pageNow = $("#pageCss").find(".pageNow").val();
        	 	var pageNums = parseInt(pageNow)-1;
        	 	if(pageNums<1){
        	 		return;
        	 	}else{
        	 		initTable(pageNums);
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
        	 		initTable(pageNums);
        	 	}
        	 }
        	 //分页
        	 function changePage(obj,pages){
        		 var pageNums = 1;
        		 if(pages){
        			 pageNums = pages;
        		 }else{
        			 pageNums = $(obj).text();
        			 var reg = /^[0-9]+$/;
        			 if(!reg.test(pageNums)){
        				 return;
        			 }
        		 }
        		 var pageTotal = $("#pageCss").find(".pageTotal").val();
        		 if(pageNums!='...'){
        			 pageNums = parseInt(pageNums);
        			 pageTotal = parseInt(pageTotal);
        			 if (pageNums>pageTotal) {
        				pageNums = pageTotal;
        			 }
        			 initTable(pageNums);
        		 }
        		 
        	 }
        	 
        	 //时间戳转"YYYY-MM-DD HH:mm:ss"
        	 function timestampFormat(timestamp){
        		 var date = new Date(timestamp);
        		 Y = date.getFullYear();
        		 M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1);
        		 D = date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
        		 h = date.getHours() < 10 ? '0' + date.getHours() : date.getHours();
        		 m = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes();
        		 s = date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds(); 
        		 return Y+"-"+M+"-"+D+" "+h+":"+m+":"+s;
        	 }
        	 
        	 //新建分组
        	 function newEquipmentGrup(){
        		 JRYPopup.Jcustom("newEquipmentGrup", newOpenAndCloseFn);
        		 $("#id").val();
                 $("#groupName").val();
                 $("input").attr("checked", false);
        	 }

            function newOpenAndCloseFn(){
                $("#startTime").datetimepicker();
                $("#endTime").datetimepicker();
                $("#id").val();
            }

            //提交分组
            function groupSave(){

                var groupName = $("#groupName").val();
                if(groupName == null || groupName.length < 1){
                    $("#groupName").closest(".Jcustom_content_items").addClass("haserror");
                    $("#groupName").parent().find(".error_text").html("分组名称不能为空");
                    //清除提示信息
                    $("#groupName").focus(function(){
                        $("#groupName").parent().find(".error_text").html("");
                        $("#groupName").closest(".Jcustom_content_items").removeClass("haserror");
                    });
                    return;
                }

                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();
                var reg = /^\s*$/;
                if(reg.test(startTime)){
                    $("#startTime").closest(".Jcustom_content_items").addClass("haserror");
                    $("#startTime").parent().find(".error_text").html("请选择开始时间");
                    $("#startTime").focus(function(){
                        $("#startTime").parent().find(".error_text").html("");
                        $("#startTime").closest(".Jcustom_content_items").removeClass("haserror");
                    });
                    return;
                }
                if(reg.test(endTime)){
                    $("#endTime").closest(".Jcustom_content_items").addClass("haserror");
                    $("#endTime").parent().find(".error_text").html("请选择结束时间");
                    $("#endTime").focus(function(){
                        $("#endTime").parent().find(".error_text").html("");
                        $("#endTime").closest(".Jcustom_content_items").removeClass("haserror");
                    });
                    return;
                }
                var data = $(".saveAndEdit").serialize();
        		var id = $("#id").val();
        		$.ajax({
        		    url: "<%=basePath%>devicegroup/saveDeviceGroup",
        			data:data,
        			type:'post',
        			success:function(res){
        				if(res.code == "10000"){
        					var pageNow = $("#pageCss").find(".pageNow").val();
        					initTable(pageNow);
        					groupCancel();
                        }else{
        					JRYPopup.Jalert(res.message);
                        }
                    },error:function(){
                        JRYPopup.Jalert("网络错误");
                    }
                });
            }
            //取消
            function groupCancel(){
            	JRYPopup.popupClose();
        	}
        	 
            //弹出编辑窗口
            function doEdit(e) {
                //修改标题
                $(".Jcustom_title").text("");// 清空数据
                $("input").attr("checked", false);
                $(".Jcustom_title").append("编辑设备分组");
                JRYPopup.Jcustom("newEquipmentGrup");
                $.ajax({
                    type: "POST",
                    url: "<%=basePath%>devicegroup/queryDeviceGroupById",
                    data: {id:e.id},
                    success: function (data) {
                    	if (data.code == '10000') {
                            var devicegroup = data.result;
                            $("#id").val(devicegroup.id);
                            $("#groupName").val(devicegroup.groupName);
                            $("#startTime").val(timestampFormat(devicegroup.startTime));
                            $("#endTime").val(timestampFormat(devicegroup.endTime));
                            $("#startTime").datetimepicker();
                            $("#endTime").datetimepicker();
                            $("#controlModule").val(devicegroup.controlModule);
                            if(devicegroup.isActive == 1){
                                $("input").attr("checked", true);
                            }
                        } else {
                            JRYPopup.Jalert(data.message)
                        }
                    },
                    error: function () {
                        JRYPopup.Jalert("网络错误！");
                    }
                })
            };
            
            //删除数据
            function doDeleted(e) {
            	JRYPopup.Jconfim('确定要删除这条数据吗？', deleted, e.id);
            }
            function deleted(id) {
                $.ajax({
                    type: "POST",
                    url: "devicegroup/deleteDeviceGroup",
                    data: {id:id},
                    success: function (data) {
                        if (data.code == '10000') {
                        	initTable($("#pageCss").find(".pageNow").val());
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
            
            //添加设备
            function addEquipments(e){
            	var groupId = e.id;
            	var urld = "device/deviceList";
    			var data = {url:urld};
    			 $.post("<%=basePath%>gotoMenuJsp",data,function (html) {
    			   $(".right_part_context").html(html);
    			   $(".right_part_context").find("#_groupId").val(groupId);
    			});
            }
            
            
            
        </script>
           
    </head>

    <body>
		<div class="Jry_table" id="testTable">
			<div class="buttons">
				<div class="btns addnew_btn">
					<div class="imgButton">
						<img src="<%=basePath%>static/jy/img/pcImg/add.png">
					</div>
					<div class="textButton" onclick="newEquipmentGrup()">新增</div>
				</div>
				<%-- <div class="btns delet_btn">
					<div class="imgButton">
						<img src="<%=basePath%>static/jy/img/pcImg/delete.png">
					</div>
					<div class="textButton">删除</div>
				</div> --%>
			</div>
			<div class="table_body">
				<table id="table_1">
					<tbody>
						<tr>
							<th>序号</th>
							<th>设备分组名</th>
							<th>创建用户</th>
							<th>开始时间</th>
                            <th>结束时间</th>
                            <th>开启模块</th>
                            <th>是否激活</th>
							<th>操作</th>
						</tr>
					</tbody>
				</table>
			</div>
			<div id="newEquipmentGrup" class="hide">
				<div class="Jcustom_title">新增设备分组</div>
				<div class="Jcustom_content">
					<form class="saveAndEdit_JRY">
						<div class="Jcustom_content_items ">
							<label>分组名称</label>
							<input type="text" id="groupName_JRY" name="groupName_JRY" placeholder="请输入分组名称">
							<input type="hidden" id="id_JRY" name="id_JRY" >
							<div class="error_text"></div>
						</div>
                        <div class="Jcustom_content_items ">
                            <label>开始时间</label>
                            <input type="text" id="startTime_JRY" name="startTime_JRY" placeholder="开始时间" readonly>
                            <div class="error_text"></div>
                        </div>
                        <div class="Jcustom_content_items ">
                            <label>结束时间</label>
                            <input type="text" id="endTime_JRY" name="endTime_JRY" placeholder="结束时间" readonly>
                            <div class="error_text"></div>
                        </div>
                        <div class="Jcustom_content_items ">
                            <label>打开模块:</label>
                            <select id="controlModule_JRY" name="controlModule_JRY">
                                <option value="0" >全部</option>
                                <option value="1" >1G模块</option>
                                <option value="2" >手机模块</option>
                            </select>
                            <div class="error_text"></div>
                        </div>
                        <div class="Jcustom_content_items ">
                            <label>激活:</label>
                            <input type="checkbox" style="margin-top: 10px;height:18px;width: 20px;" id="isActive_JRY" name="isActive_JRY" value="1">
                        </div>
					</form>
					
					<div class="Jcustom_content_btns">
						<div class="okBtn btns" onclick="groupSave()">确定</div>
						<div class="cancelBtn btns" onclick="groupCancel()">取消</div>
					</div>
				</div>
			</div>
		</div>
		<div class="Jry_page" id="pageCss" style="width:330px;">
			<input type="hidden" class="pageNow"  id="pageNum" />
			<input type="hidden" class="pageTotal" id="pages" />
			<div class="page_body">
				<div class="prev_page" onclick="proPage()">上一页</div>
				<div class="maps_page"></div>
				<div class="next_page" onclick="nextPage()">下一页</div>
				<div class="jump_page">
					跳转到<input type="text" maxlength="3" id="toPageNum">页
				</div>
				<div class="jump_button">GO</div>
			</div>
		</div>
    </body>
    <script language="javascript" src="<%=basePath%>/static/common/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/static/common/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="<%=basePath%>/static/common/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
</html>
