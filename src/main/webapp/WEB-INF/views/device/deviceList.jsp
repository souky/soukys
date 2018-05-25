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
        <style type="text/css">
        	td{
        		text-align: center;
        	}
            .Jry_popup .Jcustom{
                width: 650px;
            }
        </style>
    </head>

    <body>
		<input type="hidden" id="_groupId">
		<div class="Jry_table" id="testTable" >
			<div class="buttons">
				<div class="btns addnew_btn">
					<div class="imgButton">
						<img src="<%=basePath%>static/jy/img/pcImg/add.png">
					</div>
					<div class="textButton" onclick="editEquipments()">新增</div>
				</div>
				<div class="btns delet_btn">
					<div class="imgButton">
						<img src="<%=basePath%>static/jy/img/pcImg/delete.png">
					</div>
					<div class="textButton" onclick="returnGroup()">返回分组</div>
				</div>
			</div>
			<div class="table_body">
				<table id="table_1">
					<tbody>
						<tr>
							<td>序号</td>
							<td>ip</td>
							<td>MAC</td>
							<td>地址</td>
							<td>操作</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div id="editEquipments" class="hide">
				<div class="Jcustom_title">编辑所属设备列表</div>
				<div class="Jcustom_content">
					<form class="saveAndEdit_JRY">
					</form>
						<!-- <input type="hidden" id="uid_JRY" name="uid_JRY" > -->
						<div class="table_body">
							<table id="table_2_JRY">
								<tbody>
									<tr>
										<td style="width:30px"><input type="checkbox" class="selectAll_JRY" name="checkAll_JRY" ></td>
										<td style="width:45px">序号</td>
										<td style="width:150px">ip</td>
										<td style="width:200px">MAC</td>
										<td style="width:160px">地址</td>
									</tr>
								</tbody>
							</table>
						</div>
					
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
	<script type="text/javascript">
			
		$(function(){
        	//初始化页面数据
        	initTable(1);
        	
        });
        
        function initTable(pageNum){
        	if(pageNum == ""){
        		pageNum = 1;
        	}
        	var groupId = $("#_groupId").val();
        	var pageSize = 10;
        	var pages = $("#pages").val();
        	if(!parseInt(pageNum) > 0){
        		alert("页码只能从1开始");
        		$("#toPageNum").val("");
        		return;
        	}
        	
        	$.ajax({
        		url:"<%=basePath%>devicegroup/queryDevicesByGroupNo",
        		type: "POST",
        		data: "pageNum=" + pageNum + "&pageSize=" + pageSize + "&id=" + groupId,  
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
        		    if(data.result.length > 0){
        		    	for(var i = 0; i < data.result.length; i++){
         				var device = data.result[i];
        					$tr = "<tr>"
        							+"<td>"+ (i + 1) +"</td>"
        							+"<td>"+ device.ip +"</td>";
          					
	         				$tr += "<td>"+ device.mac +"</td>";
	         				if(device.address != null){
                                $tr += "<td>"+ device.address +"</td>";
                            }else{
                                $tr += "<td></td>";
							}

		          			$tr += "<td>" +
		                              "<img title='删除' onclick='doDeleted(this)' class='tdImg' id='" + device.groupId + "' src='" + "<%=basePath%>static/jy/img/pcImg/deleteT.png" + "'/>" +
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
    	 
    	 //新建
    	 function editEquipments(){
    		 //JRYPopup.Jcustom("editEquipments",editEquipmentsFn);
    		 //获取所有设备
    		 var groupId = $("#_groupId").val();
    		 $.ajax({
    			 url: "<%=basePath%>devicegroup/queryDevicesAndSelected",
    			 data:"&id=" + groupId,
    			 type:'post',
    			 success:function(res){
    				 if(res.code == "10000"){
    					 var tb = document.getElementById('table_2_JRY');
	   	        		 var rowNum=tb.rows.length;
	   	        		 for (i=1;i<rowNum;i++){
	   	        		 	tb.deleteRow(i);
	   	        		    rowNum=rowNum-1;
	   	        		    i=i-1;
	   	        		 }
	   	        		 var $tr;
	   	        		
    					 var list = res.result;
    					 if(list.length > 0){
    						 for(var i = 0;i<list.length;i++){
    							 var deviceVO = list[i];
    							 $tr += "<tr>";
    							 if(deviceVO.selected){
    								 $tr += '<td><input type="checkbox" name="choiceNum" checked ="checked" value="'+ deviceVO.mac + '"/></td>';
    							 }else{
    								 $tr += '<td><input type="checkbox" name="choiceNum" value="'+ deviceVO.mac +'"/></td>';
    							 }
    							 $tr += '<td>'+ (i+1) +'</td>';
    							 $tr += '<td>'+ deviceVO.ip +'</td>';
    							 $tr += '<td>'+ deviceVO.mac +'</td>';
    							 if(deviceVO.address == null){
    								 $tr += '<td></td>';
    							 }else{
    								 $tr += '<td>'+ deviceVO.address +'</td>';
    							 }
    							 $tr += '</tr>'
    						 }
    					 }else{
    						 $tr += "<tr>没有相关数据</tr>"; 
    					 }
    					 JRYPopup.Jcustom("editEquipments",editEquipmentsFn);
    					 $("#table_2").append($tr);
    					 JRYTable.tableInit("table_2","deleteByNums","choiceNum");
    				 }else{
    					 JRYPopup.Jalert(res.message);
    				 }
    			 },error:function(){
    				 JRYPopup.Jalert("网络错误");
    			 }
    		 });
             //$("#groupName").val();
    		 //JRYPopup.Jcustom("editEquipments",editEquipmentsFn);
    	 }
    	 
    	 function editEquipmentsFn(){
    		 $("#uid").val();
    	 }
    	 
    	 //取消
        function groupCancel(){
        	JRYPopup.popupClose();
    	}       
        
        //删除数据
        function doDeleted(e) {
        	JRYPopup.Jconfim('确定要删除这条数据吗？', deleted, e.id);
        }
        function deleted(id) {
            $.ajax({
                type: "POST",
                url: "<%=basePath%>devicegroup/deleteDeviceGroupNo",
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
        
        //返回分组页
        function returnGroup(){
        	var urld = "device/deviceGroup";
			var data = {url:urld};
			 $.post("<%=basePath%>gotoMenuJsp",data,function (html) {
			   $(".right_part_context").html(html);
			});
        }
        
        function groupSave(){
       	    if($("input[name='choiceNum']:checked").length <= 0){
       			JRYPopup.Jalert("请选择设备");
       			return;
       		}
       	    //JRYPopup.Jconfim('确定要删除已选择的数据吗？',deleteByNumsT,"");
       	    saveEquipmentDetail();
        }
        
        function saveEquipmentDetail(){
        	var groupId = $("#_groupId").val();
	       	var macs = "";
	       	var selecteds = $("input[name='choiceNum']:checked");
	       	$("input[name='choiceNum']:checked").each(function(){
	       		macs += $(this).val()+",";
	       	});
	       	$.ajax({
	       		url:'<%=basePath%>devicegroup/saveDeviceGroupNo',
	       		data:{macs:macs,groupId:groupId},
	       		type:'post',
	       		success:function(res){
	       			if(res.result!='0'){
	       				var pageNow = $("#pageCss").find(".pageNow").val();
	       				initTable(pageNow);
	       				JRYPopup.popupClose();
	       			 }else{
	       				 JRYPopup.Jalert("操作失败");
	       			 }
	       		},error:function(res){
	       			JRYPopup.Jalert("操作失败");
	       		}
	       	});
        }
        
    </script>
    
</html>
