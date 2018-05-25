$(document).ready(function(){
	//loadData();
})
			
function loadData(){
	//查询当前系统磁盘容量
	systemCheck();
	getDevice();
	getDeviceByTypeB();
	getExamPlan();
	//查看是否已连接平台
	getConnectStatus();
	//获取上次检测时间
	getLastCheckTime();

	var time = getNowFormatDate();
	var text = $("#lastCheckTime .lastCheckTimeP").text();
	if(text == ""){
		$("#lastCheckTime .lastCheckTimeP").text(time);
	}
	$("#platformServerTime .fuwu-time").html("<font color='#228B22'>"+ time +"</font>");
}

function getLastCheckTime(){
	$.ajax({
        url: "systemCheck/getLastCheckTime",
        type: 'post',
        dataType: 'json', 
        success: function (res) {
            if (res.code == '10000') {
            	var result = res.result;
            	if(result != ""){
            		$("#lastCheckTime .lastCheckTimeP").text(result);
            	}
            }else {
                JRYPopup.Jalert("网络错误");
            }
        }, 
        error: function (res) {
            JRYPopup.Jalert("网络错误");
        }
    });
}

function getConnectStatus(){
	var text;
	$.ajax({
        url: "paramConfig/getConnectStatus",
        type: 'post',
        dataType: 'json', 
        success: function (res) {
            if (res.code == '10000') {
            	var result = res.result;
            	if(result){
            		text = "<p style='color:#228B22;'>正在运行</p>";
            		$(".online img").attr("src","static/jy/img/pcImg/duihao.png");
            		$('#communicationServer').html(text);
            		$('#syncServer').html(text);
            		$('#heartBreathServer').html(text);
            		$('#clockSyncServer').html(text);
            		/*$('#syncServer').text($('#syncServer').text() + text);
            		$('#heartBreathServer').text($('#heartBreathServer').text() + text);
            		$('#clockSyncServer').text($('#clockSyncServer').text() + text);*/
            	}else{
            		text = "<p style=\"color:#ff0000;\">中断</p>";
            		$(".online img").attr("src","static/jy/img/pcImg/gantanhao.png");
            		$('#communicationServer').html(text);
            		$('#syncServer').html(text);
            		$('#heartBreathServer').html(text);
            		$('#clockSyncServer').html(text);
            		/*$('#communicationServer').text($('#communicationServer').text() + text);
            		$('#syncServer').text($('#syncServer').text() + text);
            		$('#heartBreathServer').text($('#heartBreathServer').text() + text);
            		$('#clockSyncServer').text($('#clockSyncServer').text() + text);*/
            	}
            }else {
                JRYPopup.Jalert("网络错误");
            }
        }, 
        error: function (res) {
            JRYPopup.Jalert("网络错误");
        }
    });
}
			
function systemCheck(){
	$.ajax({
        method:"POST",
        url:$("#basePath").val() + "systemCheck/systemCheck",
        dataType: 'json',
        success: function(data){
	        if (data.code == '10000') {  
    	        $("#diskDetail .disk").text(data.result);
            }
        },
        error: function (data){ 
    	    JRYPopup.Jalert('网络连接错误!');
        }  
    });
	
}
//获取考试计划
function getExamPlan(){
	var text = $(".exitsPlan").text();
	var trs = $("#table_1").find("tr").find("td");
	$.ajax({
        method:"POST",
        url:$("#basePath").val() + "showExamListData", 
        dataType: 'json',
        success: function(data){
	        if (data.code == '10000') {  
	        	var list = data.result;
	        	for(var i = 0; i < list.length; i++){
	        		var exam = list[i];
	        		if(exam.status == 1){
	        			$(".examPlan img").attr("src","static/jy/img/pcImg/duihao.png");
	        			$(".exitsPlan").css("float","left");
	        			$(".examPlan #examPlanPText").html("<p style=\"color:#228B22;\">有</p>");
	        			//$(".examPlan .exitsPlan").html("<p style=\"float:left\">"+ text +"</p>"+ "<p style=\"color:#228B22;\">有</p>");
	        			//trs[9].innerHTML = "<img src='<%=basePath%>static/jy/img/pcImg/duihao.png' height='25px' width='25px'/>"+"<p style=\"float:left\">"+ text +"</p>"+ '<p style=\"color:#228B22;\">有</p>';
	        		}
	        	}
            }
        },
        error: function (data){ 
    	    JRYPopup.Jalert('网络连接错误!');
        }  
    });
	//没有考试计划或者请求失败,默认给无
	if(!trs[9].innerText.endsWith("有")){
		$(".examPlan img").attr("src","static/jy/img/pcImg/gantanhao.png");
		$(".exitsPlan").css("float","left");
		$(".examPlan #examPlanPText").html("<p style=\"color:#ff0000;\">无</p>");
		//$(".examPlan .exitsPlan").html("<p style=\"float:left\">"+ text +"</p>"+ "<p style=\"color:#ff0000;\">无</p>");
		//trs[9].innerHTML = "<img src='<%=basePath%>static/jy/img/pcImg/gantanhao.png' height='25px' width='25px'/>"+"<p style=\"float:left\">"+ text +"</p>" + '<p style=\"color:#ff0000;\"> 无</p>';
	}
}
			
//获取侦测设备
function getDevice(){
	var data = {pageNum:0,pageSize:0,type:1};
	$.ajax({
        method:"POST",
        url:$("#basePath").val() + "device/queryDevices", 
        data:data,
        dataType: 'json',
        success: function(data){
	        if (data.code == '10000') {  
    	        if(data.result.total > 0){
    	        	var list = data.result.list;
    	        		var device = list[0];
    	        		var status = "未知";
	            		var workStatus = "未知";
	            		if(device.status==1){
	            			status = "在线";
	            		}else if(device.status==2){
	            			status = "离线";
	            		}
	            		if(device.workStatus==1){
	            			workStatus = "无考试计划";
	            		}else if(device.workStatus==2){
	            			workStatus = "考中";
	            		}else if(device.workStatus==3){
	            			workStatus = "考间";
	            		}else if(device.workStatus==4){
	            			workStatus = "空闲";
	            		}
	            		
	        			var tds = $("#table_2").find("tr").find("td");
	        			tds[0].children[0].innerText = "(MAC:"+ device.mac +")";
	        			tds[1].children[1].innerHTML = "<font class=\"red-color\">"+status+"</font>";
	        			tds[2].children[1].innerHTML = "<font class=\"yellow-color\">"+getMyDate(device.updateDate)+"</font>";
	        			tds[3].children[1].innerHTML = "<font color=\"#4169E1\">"+workStatus+"</font>";
	        			tds[4].children[1].innerHTML = "<font class=\"yellow-color\">"+getMyDate(device.updateDate)+"</font>";
	        			tds[5].children[1].innerHTML = '<font color="#228B22"><strong> 同步</strong></font>';
	        			tds[6].children[1].innerHTML = '<font color="#228B22"><strong> 同步</strong></font>';
	        			tds[7].children[1].innerHTML = '<font color="#228B22"><strong> 0次</strong></font>';
	        			if(device.statusAlias=="在线"){
	        				$(".red-color").css("color","#228B22");
	        				$(".table-small-img img").attr("src","static/jy/img/pcImg/duihao.png")
	        			}
    	        }else{
    	        	var trs = $("#table_2").find("tr");
    	        	for(var i = 1;i<trs.length;i++){
    	        		$("#table_2 tr:not(:first)").remove();
    	        	}
    	        	$("#table_2").append("<tr><td><font color='#FFA500' style='margin-left:35px'><strong>目前没有侦测设备</strong></font></td></tr>");
    	        }
            }
        },
        error: function (data){ 
    	    JRYPopup.Jalert('网络连接错误!');
        }  
    });
}
			
//------start 判断js数组是否包含元素--------
Array.prototype.contains = function ( needle ) {
  for (i in this) {
    if (this[i] == needle) return true;
  }
  return false;
}
//-----end-----------
				 
//获取阻断设备
function getDeviceByTypeB(){
	var data = {pageNum:0,pageSize:0,type:2};
	$.ajax({
        method:"POST",
        url:$("#basePath").val() + "device/queryDevices", 
        data:data,
        dataType: 'json',
        success: function(data){
	        if (data.code == '10000') {  
                //JRYPopup.Jalert(data.result);
    	        //var text = $("#diskDetail").text();
    	        //$("#diskDetail").text(text + data.result);
    	        if(data.result.total > 0){
    	        	var list = data.result.list;
    	        	var total = data.result.total;//总数
    	        	var online = 0;//在线数量
    	        	var offline = 0;//离线数量
    	        	var ips = new Array();
    	        	var MACs = new Array();
    	        	var address = new Array();
        			var tds = $("#table_3").find("tr").find("td");
    	        	for(var i = 0; i < list.length; i++){
    	        		var device = list[i];
    	        		if(device.status==1){
    	        			online += 1;
    	        		}else if(device.status==2){
    	        			offline += 1;
    	        		}
	        			//console.log(equipment.workStatusAlias);
	        			tds[1].children[1].innerHTML = total;
	        			tds[1].children[2].innerHTML = "<font color=\"#228B22\">" + online + "</font>";
	        			tds[1].children[3].innerHTML = "<font class=\"red-color\">" + offline + "</font>";
	        			
	        			if(!ips.contains(device.ip)){
	        				ips.push(device.ip);
	        			}
	        			if(!MACs.contains(device.mac)){
	        				MACs.push(device.mac);
	        			}
	        			if(!address.contains(device.address)){
	        				address.push(device.address);
	        			}
	        			
	        			/*tds[0].children[0].innerText = "(MAC:"+ equipment.mac +")";
	        			tds[2].children[1].innerHTML = "<font class=\"yellow-color\">"+getMyDate(equipment.updateTime)+"</font>";
	        			tds[3].children[1].innerHTML = "<font>"+equipment.workStatusAlias+"</font>";
	        			tds[4].children[1].innerHTML = "<font class=\"yellow-color\">"+getMyDate(equipment.syncTimeStamp)+"</font>";
	        			tds[5].children[1].innerHTML = '<font color="#228B22"><strong> 同步</strong></font>';
	        			tds[6].children[1].innerHTML = '<font color="#228B22"><strong> 同步</strong></font>';
	        			tds[7].children[1].innerHTML = '<font color="#228B22"><strong> 0次</strong></font>';
	        			if(equipment.statusAlias=="在线"){
	        				$(".red-color").css("color","#228B22");
	        				$(".table-small-img img").attr("src","<%=basePath%>static/jy/img/pcImg/duihao.png")
	        			}*/
    	        	}
    	        	//赋值
    	        	tds[3].children[1].innerHTML = total - ips.length;
    	        	tds[4].children[1].innerHTML = total - MACs.length;
    	        	tds[5].children[1].innerHTML = total - address.length;
    	        	
    	        }else{
    	        	var trs = $("#table_3").find("tr");
    	        	for(var i = 1;i<trs.length;i++){
    	        		$("#table_3 tr:not(:first)").remove();
    	        	}
    	        	$("#table_3").append("<tr><td><font color='#FFA500' style='margin-left:35px'><strong>目前没有阻断设备</strong></font></td></tr>");
    	        }
            }
        },
        error: function (data){ 
    	    JRYPopup.Jalert('网络连接错误!');
        }  
    });
}
			
//毫秒值日期格式化 
function getMyDate(str){  
    var oDate = new Date(str),  
    oYear = oDate.getFullYear(),  
    oMonth = oDate.getMonth()+1,  
    oDay = oDate.getDate(),  
    oHour = oDate.getHours(),  
    oMin = oDate.getMinutes(),  
    oSen = oDate.getSeconds(),  
    oTime = oYear + '-' + getzf(oMonth) + '-' + getzf(oDay) + ' ' + getzf(oHour) + ':' + getzf(oMin) + ':' + getzf(oSen);//最后拼接时间  
    return oTime;  
};  
//补0操作  
function getzf(num){  
    if(parseInt(num) < 10){  
        num = '0' + num;  
    }
    return num;  
}

//js获取当前日期时间“yyyy-MM-dd HH:mm:ss” 
function getNowFormatDate(){
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    var strHour = date.getHours();
    var strMinute = date.getMinutes();
    var strSecond = date.getSeconds();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    if (strHour >= 0 && strHour <= 9) {
    	strHour = "0" + strHour;
    }
    if (strMinute >= 0 && strMinute <= 9) {
    	strMinute = "0" + strMinute;
    }
    if (strSecond >= 0 && strSecond <= 9) {
    	strSecond = "0" + strSecond;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate + " " 
            		+ strHour + seperator2 + strMinute + seperator2 + strSecond;
    return currentdate;
}