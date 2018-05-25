<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/version.jsp"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/jry-Plug-in.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/main/mainStatistics.css<%=version %>>" />
<title>首页统计信息</title>

</head>
<body>
	<input type="hidden" id="basePath" value="<%=basePath%>" />

	<div class="Jry_top">
		<div class="top_title">作弊防控系统</div>
		<div class="top_user clearfix" id="top_city">
		</div>
	</div>

	<div id="city_all" class="clearfix">
		<div class="back" id="goback">
			 <
		</div>
		<div class="goToMain" onclick="javascript:window.location.href='<%=basePath%>main'">
			>
		</div>
		<div class="leftPart fl" id="map"></div>
		<div class="rightPart fl clearfix">
			<div class="items fl items_one">
				<div class="title clearfix">
					<div class="fl title_img">
						<img src="<%=basePath%>static/jy/img/pcImg/baseinfo.png">
					</div>
					<div class="fl title_text">考区、考场、考点基本信息</div>

				</div>
				<div class="bottomPart bottomPart_one">
					<ul class="baseinfo">
						<li><span class="info">考点总数：<span class="num" id="pointNum"></span>&nbsp;个
						</span></li>
						<li><span class="info">考场总数：<span class="num" id="screeningNum"></span>&nbsp;个
						</span></li>
					</ul>
				</div>
			</div>
			<div class="items fl items_one">
				<div class="title clearfix">
					<div class="fl title_img">
						<img src="<%=basePath%>static/jy/img/pcImg/hei.png">
					</div>
					<div class="fl title_text">黑白名单配置信息</div>

				</div>
				<div class="bottomPart bottomPart_one">
					<div id="bwList_tab" border="0">
						<div class="clearfix" style="border-bottom: thin dotted #21608B;width:100%;height:30px;line-height:30px;">
							<div class="fl ac" style="width:15%">序号</div>
							<div class="fl ac" style="width:35%">频点(频段)/MHz</div>
							<div class="fl ac" style="width:25%">带宽/KHz</div>
							<div class="fl ac" style="width:25%">属性</div>
						</div>
						<div id="bwList_main">
							
						</div>
					</div>
				</div>
			</div>
			<div class="items fl items_one">
				<div class="title clearfix">
					<div class="fl title_img">
						<img src="<%=basePath%>static/jy/img/pcImg/gao.png">
					</div>
					<div class="fl title_text">高考作弊信号统计</div>

				</div>
				<div class="bottomPart bottomPart_one" id="cheatedSignalPie">
				</div>
			</div>
			<div class="items fl items_two">
				<div class="title clearfix">
					<div class="fl title_img">
						<img src="<%=basePath%>static/jy/img/pcImg/equ.png">
					</div>
					<div class="fl title_text">设备总数</div>

				</div>
				<div class="bottomPart bottomPart_two" id="equipmentNumPie"></div>
			</div> 
			<div class="items fl items_two">
				<div class="title clearfix">
					<div class="fl title_img">
						<img src="<%=basePath%>static/jy/img/pcImg/equ.png">
					</div>
					<div class="fl title_text">设备运行占比</div>

				</div>
				<div class="bottomPart bottomPart_two" id="equOperationRatioPie"></div>
			</div>
			<div class="items fl items_two">
				<div class="title clearfix">
					<div class="fl title_img">
						<img src="<%=basePath%>static/jy/img/pcImg/bi.png">
					</div>
					<div class="fl title_text">作弊考点占比</div>

				</div>
				<div class="bottomPart bottomPart_two clearfix" id="cheatedPointPie">
					<div class="uncheatBlock clearfix fl topPart">
						<div class="block b fl"></div>
						<div class="text fl ac">作弊考点</div>
					</div>
					<div class="cheatBlock clearfix fl topPart">
						<div class="block w fl"></div>
						<div class="text fl ac">非作弊考点</div>
					</div>
					<div class="cheatMain">
						<div class="main_circle">
							<div class="circle">
								<div class="pie_left"><div class="left"></div></div>
								<div class="pie_right"><div class="right"></div></div>
								<div class="mask">
									<div class="text top">作弊考点占比</div>
									<div class="text bottom">50%</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="items fl items_two" style="width: 64%;">
				<div class="title clearfix">
					<div class="fl title_img">
						<img src="<%=basePath%>static/jy/img/pcImg/xin.png">
					</div>
					
					<div class="fl title_text">
						作弊信息
						<%-- 
						 <img class="img_break" src="<%=basePath%>static/jy/img/pcImg/yizu.png">
						已阻断&nbsp;&nbsp; 
						<img class="img_notbreak" src="<%=basePath%>static/jy/img/pcImg/wuzu.png"> 无阻断设备
						 --%>
					</div>

				</div>
				<div class="bottomPart bottomPart_two" style="padding:0 20px;">
					<div id="cheatInfo_tab" class="clearfix" style="font-size:16px;">
						
					</div>
				</div>
			</div>
			<div class="items fl items_two">
				<div class="title clearfix">
					<div class="fl title_img">
						<img src="<%=basePath%>static/jy/img/pcImg/san.png">
					</div>
					<div class="fl title_text">作弊频点散点图</div>

				</div>
				<div class="bottomPart bottomPart_two" id="cheatedScatterDiagram"></div>
			</div>
		</div>
	</div>
	<div class="Jry_popup"></div>
</body>

<script language="javascript" src="<%=basePath%>/static/common/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/common/js/echarts.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/common/js/map/china.js"></script>
<script language="javascript" src="<%=basePath%>/static/jy/js/common/jry-Plug-in.js<%=version%>"></script>
<script language="javascript"
	src="<%=basePath%>/static/common/js/bootstrap.min.js"></script>
<script type="text/javascript">
var basePath = $("#basePath").val();
var chart = echarts.init(document.getElementById('map'));
var p_flag=true;//是否点击入省级地图 (true:全国地图界面；false:省级地图界面)
var c_flag=true;//是否点击入市级地图 (true:省级地图界面；false:市级地图界面)
var province = "";
var city = "";
var region = "";
var provinces = ['shanghai', 'hebei','shanxi','neimenggu','liaoning','jilin','heilongjiang','jiangsu','zhejiang','anhui','fujian','jiangxi','shandong','henan','hubei','hunan','guangdong','guangxi','hainan','sichuan','guizhou','yunnan','xizang','shanxi1','gansu','qinghai','ningxia','xinjiang', 'beijing', 'tianjin', 'chongqing', 'xianggang', 'aomen'];
var provincesText = ['上海', '河北', '山西', '内蒙古', '辽宁', '吉林','黑龙江',  '江苏', '浙江', '安徽', '福建', '江西', '山东','河南', '湖北', '湖南', '广东', '广西', '海南', '四川', '贵州', '云南', '西藏', '陕西', '甘肃', '青海', '宁夏', '新疆', '北京', '天津', '重庆', '香港', '澳门'];
var level = "";
var mapCity = null;

$(function () {  
     initItemsHeight();//初始化高度
     
	 mapCity = ${cityMap};
	 province = '${currentProvince}';
	 city = '${currentCity}';
	 region = '${currentArea}';
	 if(region!=""){
		 loadCountryChart();
		 loadProvinceChart(province);
		 loadCityChart(city);
		 selectRegionChart(region);
	 }else if(city!=""){
		 loadCountryChart();
		 loadProvinceChart(province);
		 loadCityChart(city);
	 }else if(province!=""){
		 loadCountryChart();
		 loadProvinceChart(province);
	 }else{
		 loadCountryChart();
	 }
	 
     location_time();//顶部时间
     prepareData();//初始化数据
	 
	 $(".goToMain").hover(function(){
		 $(this).html("进入主页");
	 },function(){
		 $(this).html(">");
	 });
     
     //页面定时刷新
     setTimeout('pageRefush()',1000*60*5)
     
     //作弊信息动态处理
     var windowHeight = $(window).height()-60;
	 var heightItems_two = (windowHeight-60)*0.36 -40;
     setTimeout('cheatInit('+heightItems_two+')',1000*4)
	 
     
	 var heightItems_one = (windowHeight-60)*0.20 - 71;
     setTimeout('bwInit('+heightItems_one+')',1000*4)
     
});

function bwInit(heightItems_one){
	$("#bwList_main").animate({scrollTop:heightItems_one},600,"swing");
	setTimeout('removeBwOb('+heightItems_one+')',1000);
	setTimeout('bwInit('+heightItems_one+')',1000*4);
}

function removeBwOb(heightItems_one){
	var obj = $("#bwList_main").find(".item:eq(0)");
	if(obj==undefined || obj.html()==undefined){
		return;
	}
	$("#bwList_main").append('<div class="item">'+obj.html()+'</div>');
	obj.remove();
	$("#bwList_main .item").css("height",heightItems_one+"px");
}

function cheatInit(heightItems_two){
	
	$("#cheatInfo_tab").animate({scrollTop:heightItems_two},600,"swing");
	setTimeout('removeCheatOb('+heightItems_two+')',1000);
	setTimeout('cheatInit('+heightItems_two+')',1000*4)
}

function removeCheatOb(heightItems_two){
	var obj = $("#cheatInfo_tab").find(".item:eq(0)");
	if(obj==undefined || obj.html()==undefined){
		return;
	}
	$("#cheatInfo_tab").append('<div class="item">'+obj.html()+'</div>');
	obj.remove();
	$("#cheatInfo_tab .item").css("height",heightItems_two+"px");
}

function pageRefush(){
	window.location.href = window.location.href;
	setTimeout('pageRefush()',1000*60*5)
}

function initItemsHeight(){
	
	//获取屏幕高度
	var windowHeight = $(window).height()-60;
	//下方高度
	$("#city_all").css("height",windowHeight+"px");
	//右边高度
	$("#city_all").find(".rightPart").css("height",(windowHeight-60)+ "px");
	
	var heightItems_one = (windowHeight-60)*0.20;
	var heightItems_two = (windowHeight-60)*0.36;
	
	$("#city_all").find(".rightPart .items_one").css("height",heightItems_one+"px");
	$("#city_all").find(".rightPart .items_two").css("height",heightItems_two+"px");
	$("#city_all").find(".rightPart .bottomPart_one").css("height",(heightItems_one-40)+"px");
	$("#city_all").find(".rightPart .bottomPart_two").css("height",(heightItems_two-40)+"px");
	
}

chart.on('click', function (params) {
 	if(p_flag){
 	   	loadProvinceChart(params.name); 
 	}else{
 		if(c_flag){
 	 		loadCityChart(params.name); 
 		}else{
 			
 			selectRegionChart(params.name); 
 			
 		}
 	}
    location_time();//顶部时间
    prepareData();//初始化数据
 });
 
$("#goback").on('click', function () {
	if(!c_flag){
		chart.setOption(optionProvince);
		c_flag = true;
		p_flag = false;
		level = "province";
		city = "";
		region = "";
	}else{
		chart.setOption(option);
		p_flag = true;
		level = "country";
		city = "";
		region = "";
		province = "";
	}
	location_time();
    prepareData();
 });
 
function loadCountryChart(){
	level = "country";
	option = {
			 tooltip: {
	   	        trigger: 'item',
	   	        formatter: '{b}',
	   	 },
	        geo: {
	           	 type: 'map',
	                map: 'china',
	                roam: false,
	                label: {
	                    normal: {
	                        show: true,
	                        textStyle:{
	                       	 color:"#32CCFE",
	                        }
	                    },
	                    emphasis: {
	                        show: true,
	                        textStyle:{
	                       	 color:"#FFFFFF",
	                       	 fontWeight:"bold",
	                       	 fontSize:"16"
	                        }
	                    }
	                },
	                itemStyle:{
							normal:{
								    areaColor: '#0C1B2D',
							        borderColor: '#4F5D6F',
							        borderWidth: 1,
							},
							emphasis:{
								    areaColor: '#1799D9',
							}
	                }
	        },
	        series: [
		          
		     ]
	};
	
    window.onresize = chart.resize;
    chart.setOption(option);//地图控件
}

function loadProvinceChart(param){
	province = param; 
	var nameNum = jQuery.inArray(province,provincesText); /* 判断数据是否包含数据返回index */
	var name = provinces[nameNum];
	
	//获取省
	$.ajax({
		url:basePath+'static/common/echartsMap/provinceCity/' + name + '.json',
		type:'get',
		async: false,  
		success:function (geoJson){
			
	 	    p_flag = false;
	 	    level = "province";
	 	    
			echarts.registerMap(name, geoJson);/* 地图注册 */
	 		optionProvince = {
				tooltip: {
			        trigger: 'item',
			        formatter: '{b}',
			    },
				geo:{		
	        	map: name,
	        	roam: false,
	        	label: {
	                 normal: {
	                     show: true,
	                     textStyle:{color:"#32CCFE"}
	                 },
	                 emphasis: {
	                     show: true,
	                     textStyle:{color:"#FFFFFF"}
	                 }
	             },
	             itemStyle:{
						normal:{
							    areaColor: '#0C1B2D',
						        borderColor: '#4F5D6F',
						        borderWidth: 1,
						},
						emphasis:{
							    areaColor: '#1799D9',
						}
	             }
	        },
	            series: [
	          
	            ]
	        };
	 		
		    chart.setOption(optionProvince);
		    window.onresize = chart.resize;
		},
		error:function (res){
			province = "";
			JRYPopup.Jalert("地图资源完善中");
		}
	})
	
}

function loadCityChart(param){
	city = param;
	var citySS = mapCity[city];
	$.ajax({/*判断JSON文件是否存在*/
		  	url:basePath+'static/common/echartsMap/cityTowns/' + citySS + '.json',
		  	type:'GET',
		  	async: false,  
			contentType: "application/x-www-form-urlencoded",
			error: function() {
				/*JSON文件不存在触发*/
				city = "";
				JRYPopup.Jalert("地图资源完善中");
				return;
			},
	     	success: function(geoJson) {
	     		/*JSON文件存在触发*/
	 			c_flag = false;
	 	 		level = "city";
	 	 		echarts.registerMap(city, geoJson);/* 地图注册 */
				optionCity = {
					tooltip: {
						trigger: 'item',
						formatter: '{b}',
					},
					geo:{		
	                	map: city,
	                	roam: false,
	                	label: {
		                     normal: {
		                         show: true,
		                         textStyle:{color:"#32CCFE"}
		                     },
		                     emphasis: {
		                         show: true,
		                         textStyle:{color:"#FFFFFF"}
		                     }
		                 },
		                 itemStyle:{
								normal:{
									    areaColor: '#0C1B2D',
								        borderColor: '#4F5D6F',
								        borderWidth: 1,
								},
								emphasis:{
									    areaColor: '#1799D9',
								}
		                 }
	                },
					series: [
					
					]
				};
	 	 		
	            chart.setOption(optionCity);
	            window.onresize = chart.resize;
	    	}
	});
}

function selectRegionChart(param){
	region = param;
	var citySS = mapCity[city];
	$.ajax({/*判断JSON文件是否存在*/
		  	url:basePath+'static/common/echartsMap/cityTowns/' + citySS + '.json',
		  	type:'GET',
		  	async: false,  
			contentType: "application/x-www-form-urlencoded",
			error: function() {
				/*JSON文件不存在触发*/
				region = '';
				JRYPopup.Jalert("地图资源完善中");
				return;
			},
	     	success: function(geoJson) {
	     		level = "area";
 	 	 		echarts.registerMap(city, geoJson);/* 地图注册 */
 	 	 		optionRegion = {
 	 					tooltip: {
 	 				        trigger: 'item',
 	 				        formatter: '{b}'
 	 				    },
 	 				  geo:{		
		                	map: city,
		                	roam: false,
		                	label: {
			                     normal: {
			                         show: true,
			                         textStyle:{color:"#32CCFE"}
			                     },
			                     emphasis: {
			                         show: true,
			                         textStyle:{color:"#FFFFFF"}
			                     }
			                 },
			                 itemStyle:{
									normal:{
										    areaColor: '#0C1B2D',
									        borderColor: '#4F5D6F',
									        borderWidth: 1,
									},
									emphasis:{
										    areaColor: '#1799D9',
									}
			                 },
			                 selectedMode : 'single',
	 	                     data:[
	 	                            {name:region, selected:true}
	 	                     ]
		                },
 	 	                series: [
 	 	                    
 	 	                ]
 	 	        };
 	 	        chart.setOption(optionRegion);
 	 	        window.onresize = chart.resize;
	    }
	});
}


function location_time(){
	var location = "";
	if(region != ""){
		location =  region;
	}else if(city != ""){
		location = city;
	}else if(province != ""){
		location = province;
	}else{
		location = "全国";
	}
	
	var mydate = new Date();
	var h=mydate.getHours();       //获取当前小时数(0-23)
	var m=mydate.getMinutes()<10?"0"+mydate.getMinutes():mydate.getMinutes();     //获取当前分钟数(0-59)
	var s=mydate.getSeconds()<10?"0"+mydate.getSeconds():mydate.getSeconds();
	var now=h+":"+m+":"+s;
	
	$('#top_city').html("当前地区 ：  "+location +"  "+now);
	
 	setTimeout(function(){
 		location_time(); 
 	},1000);
}

function locationName(){
	var location = "";
	if(region != ""){
		location =  region;
	}else if(city != ""){
		location = city;
	}else if(province != ""){
		location = province;
	}else{
		location = "中国";
	}
	return location;
}

// 	准备数据
function prepareData() {
	var location = locationName();
	var data = {level:level,name:location};
	$.post(basePath+"data/countNum",data, function (data) {
		if(data.code=="60000" || data.code=="50000"){
			return;
		}
		$("#pointNum").text(data.result.examPointNum);//考点总数
		$("#screeningNum").text(data.result.detectiveNum);//考场总数[一个考场有一台侦测设备]
		var bwList = data.result.blackwhitelists;
		var html = "";
		var countb = 0;
		if(bwList!=null && bwList.length>0){
			for(var i=0;i<bwList.length;i++){
				var count = "0" + (i + 1);
				var frequencyPoint = (bwList[i].centerOrBeginFre / 1000).toFixed(3)
				var bandwidth = 0;
				var property = "";
				if(bwList[i].isSection==1){//频类
					bandwidth = numDiv(numAdd(bwList[i].centerOrBeginFre,bwList[i].assistantOrEndFre),2);
				}
				if(bwList[i].signalProperty == "B"){
					property = "黑名单";//属性 
				}else if(bwList[i].signalProperty == "W"){
					property = "白名单";
				}else if(bwList[i].signalProperty == "L"){
					property = "低可疑信号";
				}else{
					property = "高可疑信号"; 
				}
				if(countb % 3 == 0){
					html += '<div class="item">';
				}
				html+='<div class="items_bw clearfix"><div class="fl ac" style="width:15%">'+count+'</div><div class="fl ac" style="width:35%">'+frequencyPoint+'</div><div class="fl ac">'+bandwidth+'</div><div class="fl ac">'+property+'</div></div>';
				if(countb!= 0 && ((countb+1)/3) == Math.ceil((countb+1) / 3)){
					html += '</div>';
				}
				if(countb == (bwList.length - 1)){
					html += '</div>';
				}
				countb++;
			}
			var windowHeight = $(window).height()-60;
			var heightItems_one = (windowHeight-60)*0.20 - 71;
			$("#bwList_main").css("height",heightItems_one+"px");
			$("#bwList_main .items_bw").css("height",heightItems_one+"px");
		}
		$("#bwList_main").html(html);
		var cheatInfoList = data.result.cheatList;
		var htmls = "";
		var counts = 0;
		for(var i=0;i<(cheatInfoList.length);i++){
			var dateA = new Date(cheatInfoList[i].createTime);
			var frequencyPoint = (cheatInfoList[i].frequencyPoint / 1000).toFixed(3)
			var times = dateA.getHours()+":"+dateA.getMinutes()+":"+(dateA.getSeconds()<10?('0'+dateA.getSeconds()):dateA.getSeconds());
			if(counts % 6 == 0){
				htmls += '<div class="item">';
			}
			htmls+="<div class='clearfix items_cheat'><div class='tl fl' title='"+cheatInfoList[i].orgName+"'>"+cheatInfoList[i].orgName+"</div><div class='fl'>"+frequencyPoint+"</div><div class='fl'>"+cheatInfoList[i].signalType+"</div><div class='fl'>"+times+"</div></div>"
			if(counts!= 0 && ((counts+1)/6) == Math.ceil((counts+1) / 6)){
				htmls += '</div>';
			}
			if(counts == (cheatInfoList.length - 1)){
				htmls += '</div>';
			}
			counts++;
		}
		$("#cheatInfo_tab").html(htmls);
		var windowHeight = $(window).height()-60;
		var heightItems_two = (windowHeight-60)*0.36 -40;
		$("#cheatInfo_tab").css("height",heightItems_two+"px");
		$("#cheatInfo_tab .item").css("height",heightItems_two+"px");
		
		var cheatedSignalChart = echarts.init($('#cheatedSignalPie')[0]);//高考作弊信号统计
	    var equipmentNumChart = echarts.init($('#equipmentNumPie')[0]);//设备总数
	    var equOperationRatioChart = echarts.init($('#equOperationRatioPie')[0]);//设备运行占比
	    var cheatedScatterChart = echarts.init($('#cheatedScatterDiagram')[0]);//作弊频点散点图
	    //var cheatedPointChart = echarts.init($('#cheatedPointPie')[0]);//作弊考点占比
	    
	    //作弊考点占比
	    var cheatExamPointNum = parseInt(data.result.cheatExamPointNum);
	    var examPointNum = parseInt(data.result.examPointNum);
	    var pe = 0;
	    if(examPointNum!=0){
	    	pe = cheatExamPointNum / examPointNum;
	    }
	   	var num = pe * 360;
		if (num<=180) {
			$("#cheatedPointPie").find('.right').css('transform', "rotate(" + num + "deg)");
		} else {
			$("#cheatedPointPie").find('.right').css('transform', "rotate(180deg)");
			$("#cheatedPointPie").find('.left').css('transform', "rotate(" + (num - 180) + "deg)");
		};
		var s_pe = pe.toFixed(3) * 100 +"%";
		$("#cheatedPointPie .bottom").html(s_pe);
		
	    
	    
	    var CheatedPointNum = data.result.cheatExamPointNum;
	    var unCheatedPointNum = numSub(data.result.examPointNum,data.result.cheatExamPointNum);
	    var persent = 0
	    var persent_s = 100
	    if(data.result.examPointNum!=0){
	    	persent = parseInt(parseFloat(CheatedPointNum / data.result.examPointNum) * 10000)/100;
	    	if(persent>100){
	    		persent = 100;
	    	}
	    	persent_s = numSub(100,persent);
	    }else{
	    	CheatedPointNum = 0;
	    	unCheatedPointNum = 1;
	    }
	  //作弊考点占比
	    cheatedPointOption = {
	    		tooltip: {
	    	        trigger: 'item',
	    	        //formatter: "{a} <br/>{b}: {c} ({d}%)"
	    	        formatter: "{a} <br/>{b}: ({d}%)"
	    	    },
	    	    legend: {
	    	    	orient: 'vertical',
	    	        x: 'left',
	    	    	top:24,
	    	    	left:3,
	    	        data:['作弊考点','非作弊考点'],
	    	        textStyle:{
                        color:'#fff'
                    }
	    	    },
	    	    color:['#32CCFE','#fff'],
	    	    series: [
	    	        {
	    	            name:'考点占比',
	    	            type:'pie',
	    	            radius: ['58%', '73%'],
	    	            avoidLabelOverlap: false,
	    	            label: {
	    	                normal: {
	    	                    show: false,
	    	                    position: 'center'
	    	                },
	    	                emphasis: {
	    	                    show: true,
	    	                    textStyle: {
	    	                        fontSize: '30',
	    	                        fontWeight: 'bold'
	    	                    }
	    	                }
	    	            },
	    	            labelLine: {
	    	                normal: {
	    	                    show: false
	    	                }
	    	            },
	    	            data:[
	    	                {value:CheatedPointNum, name:'作弊考点'},
	    	                {value:unCheatedPointNum, name:'非作弊考点'},
	    	            ]
	    	        }
	    	    ]
	    };

        // 高考作弊信号的配置项和数据
        cheatedSignalOption = {
            color: ['#32ccfe'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                top:'15%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: ['作弊信号', '可疑信号'],
                    axisLine:{
                        lineStyle:{
                            color:'#fff'
                        }
                    },
                    axisTick: {
                        alignWithLabel: true
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLine:{
                        lineStyle:{
                            color:'#fff'
                        }
                    },
                    min:0,
                    minInterval: 1,
                    splitLine: {
                        lineStyle: {
                            type: 'dashed'
                        }
                    },
                }
            ],
            series: [
                {
                    name: '信号数',
                    type: 'bar',
                    barWidth: '24%',
                    label: {
                        normal: {
                            show: true,
                            position: 'top'
                        }
                    },
                    //设置柱体颜色
                    itemStyle: {
                        normal: {color: '#32ccfe'}
                    },
                    data: [data.result.cheatSignalNum, data.result.suspiciousSignalNum]
                }
            ]
        };

        //设备总数
        equipmentNumOption = {
            color: ['#32ccfe'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: ['侦测', '屏蔽'],
                    axisLine:{
                        lineStyle:{
                            color:'#fff'
                        }
                    },
                    axisTick: {
                        alignWithLabel: true
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLine:{
                        lineStyle:{
                            color:'#fff'
                        }
                    },
                    min:0,
                    minInterval: 1,
                    splitLine: {
                        lineStyle: {
                            type: 'dashed'
                        }
                    },
                }
            ],
            series: [
                {
                    name: '设备数量',
                    type: 'bar',
                    barWidth: '24%',
                    label: {
                        normal: {
                            show: true,
                            position: 'top'
                        }
                    },
                    data: [data.result.detectiveNum, data.result.shieldNum]
                }
            ]
        };

        var onlineNornalNumForDetectiveRate;//侦测在线正常占比
        var onlineInnornalNumForDetectiveRate;//侦测在线异常占比
        var offlineNornalNumForDetectiveRate;//侦测离线正常占比
        var offlineInnornalNumForDetectiveRate;//侦测离线异常占比
        var onlineNornalNumForShieldRate;//屏蔽在线正常占比
        var onlineInnornalNumForShieldRate;//屏蔽在线异常占比
        var offlineNornalNumForShieldRate;//屏蔽离线正常占比
        var offlineInnornalNumForShieldRate;//屏蔽离线异常占比
        if(data.result.detectiveNum!=0){
            onlineNornalNumForDetectiveRate = numMulti(numDiv(data.result.normalOnlineDetective , data.result.detectiveNum).toFixed(4) , 100);
            onlineInnornalNumForDetectiveRate = numMulti(numDiv(data.result.innormalOnlineDetective , data.result.detectiveNum).toFixed(4) , 100);
            offlineNornalNumForDetectiveRate = numMulti(numDiv(data.result.normalOfflineDetective , data.result.detectiveNum).toFixed(4) , 100);
            offlineInnornalNumForDetectiveRate = numSub(numSub(numSub(100,onlineNornalNumForDetectiveRate),onlineInnornalNumForDetectiveRate),offlineNornalNumForDetectiveRate);

        }
        else{
            onlineNornalNumForDetectiveRate = 0;
            onlineInnornalNumForDetectiveRate   = 0;
            offlineNornalNumForDetectiveRate    = 0;
            offlineInnornalNumForDetectiveRate  = 0;
        }
        if(data.result.shieldNum!=0){
            onlineNornalNumForShieldRate = numMulti(numDiv(data.result.normalOnlineShield , data.result.shieldNum).toFixed(4) , 100);
            onlineInnornalNumForShieldRate = numMulti(numDiv(data.result.innormalOnlineShield , data.result.shieldNum).toFixed(4) , 100);
            offlineNornalNumForShieldRate = numMulti(numDiv(data.result.normalOfflineShield , data.result.shieldNum).toFixed(4) , 100);
            offlineInnornalNumForShieldRate = numSub(numSub(numSub(100,onlineNornalNumForShieldRate),onlineInnornalNumForShieldRate),offlineNornalNumForShieldRate);

        }
        else{
            onlineNornalNumForShieldRate = 0;
            onlineInnornalNumForShieldRate   = 0;
            offlineNornalNumForShieldRate    = 0;
            offlineInnornalNumForShieldRate  = 0;
        }
        
        // 设备运行占比图表的配置项和数据
        equOperationRatioOption = {
        		tooltip: {
                    trigger: 'axis',
                    axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                legend: {
                    data: ['在线正常', '在线异常','离线正常','离线异常'],
                    top: 24,
                    itemWidth:10,
                    itemHeight:10,
                    textStyle:{
                        color:'#fff'
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [
                    {
                        type: 'category',
                        axisLine:{
                            lineStyle:{
                                color:'#fff'
                            }
                        },
                        data: ['侦测', '屏蔽']
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        axisLabel: {
                            formatter: '{value} %'
                        },
                        min:0,
                        axisLine:{
                            lineStyle:{
                                color:'#fff'
                            }
                        },
                        splitLine: {
                            lineStyle: {
                                type: 'dashed'
                            }
                        },
                        max: 100
                    }
                ],
                series: [
                    {
                        name: '在线正常',
                        type: 'bar',
                        stack: '在线',
                        barWidth: '20%',
                        //设置柱体颜色
                        itemStyle: {
                            normal: {color: '#b6e94a'}
                        },
                        data: [onlineNornalNumForDetectiveRate,
                            onlineNornalNumForShieldRate]         //计算后的百分比
                    },
                    {
                        name: '在线异常',
                        type: 'bar',
                        stack: '在线',
                        barWidth: '20%',
                        //设置柱体颜色
                        itemStyle: {
                            normal: {color: '#cd3f67'}
                        },
                        data: [onlineInnornalNumForDetectiveRate,
                            onlineInnornalNumForShieldRate]         //计算后的百分比
                    },
                    {
                        name: '离线正常',
                        type: 'bar',
                        stack: '离线',
                        barWidth: '20%',
                        //设置柱体颜色
                        itemStyle: {
                            normal: {color: '#32ccfe'}
                        },
                        data: [offlineNornalNumForDetectiveRate,
                            offlineNornalNumForShieldRate]         //计算后的百分比
                    },
                    {
                        name: '离线异常',
                        type: 'bar',
                        stack: '离线',
                        barWidth: '20%',
                        //设置柱体颜色
                        itemStyle: {
                            normal: {color: '#fbf115'}
                        },
                        data: [offlineInnornalNumForDetectiveRate,
                            offlineInnornalNumForShieldRate]         //计算后的百分比
                    }
                ]
        };
        
        var galdData = [
            []
        ];
        var result = data.result.pointList;
        for (i = 0; i < result.length; i++) {
            var tempData = [];
            tempData.push((result[i].frequencyPoint/1000).toFixed(3));
            tempData.push(result[i].number);
            galdData.push(tempData);
        }
      
        //作弊频点散点图
        cheatedScatterOption = {

            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross'
                }
            },
            color: ['#fbf115'],
            toolbox: {
                feature: {
                    dataZoom: {
                        yAxisIndex: 'none'
                    },
                    restore: {}
                }
            },
            xAxis: {
                type: 'value',
                axisLine:{
                    lineStyle:{
                        color:'#fff'
                    }
                },
                splitLine: {
                    lineStyle: {
                        type: 'dashed'
                    }
                },
                min:0,
                max:1400,
                splitNumber: 7
            },
            yAxis: {
                type: 'value',
                min: 0,
                minInterval: 1,
                axisLine:{
                    lineStyle:{
                        color:'#fff'
                    }
                },
                splitLine: {
                    lineStyle: {
                        type: 'dashed'
                    }
                }
            },
            grid: {
                top: 60
            },
            series: [{
                name: 'scatter',
                type: 'scatter',
                label: {
                    emphasis: {
                        show: true,
                        position: 'right',
                        textStyle: {
                            color: 'blue',
                            fontSize: 16
                        }
                    }
                },
                data: galdData
            }]
        };
        // 使用刚指定的配置项和数据显示图表。
        cheatedSignalChart.setOption(cheatedSignalOption);
        equipmentNumChart.setOption(equipmentNumOption);
        equOperationRatioChart.setOption(equOperationRatioOption);
        cheatedScatterChart.setOption(cheatedScatterOption);
        //cheatedPointChart.setOption(cheatedPointOption);
	});	    
}

/**
 * 加法运算，避免数据相加小数点后产生多位数和计算精度损失。
 *
 * @param num1加数1 | num2加数2
 */
function numAdd(num1, num2) {
    var baseNum, baseNum1, baseNum2;
    try {
        baseNum1 = num1.toString().split(".")[1].length;
    } catch (e) {
        baseNum1 = 0;
    }
    try {
        baseNum2 = num2.toString().split(".")[1].length;
    } catch (e) {
        baseNum2 = 0;
    }
    baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
    return (num1 * baseNum + num2 * baseNum) / baseNum;
};
/**
 * 加法运算，避免数据相减小数点后产生多位数和计算精度损失。
 *
 * @param num1被减数  |  num2减数
 */
function numSub(num1, num2) {
    var baseNum, baseNum1, baseNum2;
    var precision;// 精度
    try {
        baseNum1 = num1.toString().split(".")[1].length;
    } catch (e) {
        baseNum1 = 0;
    }
    try {
        baseNum2 = num2.toString().split(".")[1].length;
    } catch (e) {
        baseNum2 = 0;
    }
    baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
    precision = (baseNum1 >= baseNum2) ? baseNum1 : baseNum2;
    return ((num1 * baseNum - num2 * baseNum) / baseNum).toFixed(precision);
};
/**
 * 乘法运算，避免数据相乘小数点后产生多位数和计算精度损失。
 *
 * @param num1被乘数 | num2乘数
 */
function numMulti(num1, num2) {
    var baseNum = 0;
    try {
        baseNum += num1.toString().split(".")[1].length;
    } catch (e) {
    }
    try {
        baseNum += num2.toString().split(".")[1].length;
    } catch (e) {
    }
    return Number(num1.toString().replace(".", "")) * Number(num2.toString().replace(".", "")) / Math.pow(10, baseNum);
};
/**
 * 除法运算，避免数据相除小数点后产生多位数和计算精度损失。
 *
 * @param num1被除数 | num2除数
 */
function numDiv(num1, num2) {
    var baseNum1 = 0, baseNum2 = 0;
    var baseNum3, baseNum4;
    try {
        baseNum1 = num1.toString().split(".")[1].length;
    } catch (e) {
        baseNum1 = 0;
    }
    try {
        baseNum2 = num2.toString().split(".")[1].length;
    } catch (e) {
        baseNum2 = 0;
    }
    with (Math) {
        baseNum3 = Number(num1.toString().replace(".", ""));
        baseNum4 = Number(num2.toString().replace(".", ""));
        return (baseNum3 / baseNum4) * pow(10, baseNum2 - baseNum1);
    }
};
</script>
</html>