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
	 level = "country";
	 option = {
			 tooltip: {
	    	        trigger: 'item',
	    	        formatter: '{b}'
	    	 },
	         geo: {
	            	 type: 'map',
	                 map: 'china',
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
							        color :'red',
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
     chart.setOption(option);
     location_time();
     prepareData();
});



chart.on('click', function (params) {
 	if(p_flag){
 		province = params.name; 
 		loadProvinceChart(); 
 	    p_flag = false;
 	    level = "province";
 	}else{
 		if(c_flag){
 			city = params.name; 
 	 		loadCityChart(); 
 	 		c_flag = false;
 	 		level = "city";
 		}else{
 			region = params.name;
 			selectRegionChart(); 
 			level = "area";
 		}
 	}
 	location_time();
 	prepareData();
 });

function loadProvinceChart(){
	var nameNum = jQuery.inArray(province,provincesText); /* 判断数据是否包含数据返回index */
	var name = provinces[nameNum];
	
    //获取省
 	$.get('static/common/echartsMap/provinceCity/' + name + '.json', function (geoJson) {/* 地图Json文件获取 */
 		echarts.registerMap(name, geoJson);/* 地图注册 */
 		optionProvince = {
			tooltip: {
		        trigger: 'item',
		        formatter: '{b}'
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
					        color :'red',
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
    });
}

function loadCityChart(){
	var citySS = mapCity[city];
	$.ajax({/*判断JSON文件是否存在*/
		  	url:'static/common/echartsMap/cityTowns/' + citySS + '.json',
		  	type:'get',
			contentType: "application/x-www-form-urlencoded",
			error: function() {
				/*JSON文件不存在触发*/
			},
	     	success: function(geoJson) {
	     		/*JSON文件存在触发*/
	 	 		echarts.registerMap(names, geoJson);/* 地图注册 */
				optionCity = {
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
								        color :'red',
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

function selectRegionChart(){
	var citySS = mapCity[city];
	$.ajax({/*判断JSON文件是否存在*/
		  	url:'static/common/echartsMap/cityTowns/' + citySS + '.json',
		  	type:'GET',
			contentType: "application/x-www-form-urlencoded",
			error: function() {
				/*JSON文件不存在触发*/
			},
	     	success: function(geoJson) {
 	 	 		echarts.registerMap(city, geoJson);/* 地图注册 */
 	 	 		optionRegion = {
 	 					tooltip: {
 	 				        trigger: 'item',
 	 				        formatter: '{b}'
 	 				    },
 	 				  geo:{		
		                	map: names,
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
									        color :'red',
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
	var m=mydate.getMinutes();     //获取当前分钟数(0-59)
	var s=mydate.getSeconds();  
	var now=h+":"+m+":"+s;
	//console.log(location+now)
	$('#top_city').html("当前地区 ：  "+location +"  "+now);
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


$("#goback").on('click', function () {
	if(!c_flag){
		chart.setOption(option1);
		c_flag = true;
		p_flag = false;
		level = "province";
	}else{
		chart.setOption(option);
		p_flag = true;
		level = "country";
	}
 });

// 	准备数据
function prepareData() {
	
	$.post("/data/countNum?level="+level+"&name=" + locationName(), function (data) {
		
		
	});
	    var cheatedPieChart = echarts.init($('#cheatedPie')[0]);
	    var examinationRoomPieChart = echarts.init($('#examinationRoomPie')[0]);
	    var examPieChart = echarts.init($('#examPie')[0]);
	    var cheatedHzLineChart = echarts.init($('#cheatedHzLine')[0]);
	    var cheatedHzLineChart = echarts.init($('#cheatedHzLine')[0]);
	    var cheatedExamChart = echarts.init($('#cheatedExam')[0]);
	    	
	    //作弊考点占比
	    cheatedExamOption = {
	    	    tooltip: {
	    	        trigger: 'item',
	    	        formatter: "{a} <br/>{b}: {c} ({d}%)"
	    	    },
	    	     color:['#fff', '#32CCFE'],
	    	    series: [
	    	        {
	    	            name:'作弊考点占比',
	    	            type:'pie',
	    	            radius: ['50%', '70%'],
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
	    	                {value:36, name:'作弊考点'},
	    	                {value:80, name:'未作弊考点'},
	    	            ]
	    	        }
	    	    ]
	    };

        // 作弊考点占比图表的配置项和数据
        cheatedPieOption = {
            title: {
                //text: '作弊信号',
                x: 'center',
                textStyle:{
                    fontWeight:'normal',
                    fontSize:16,
                    color:'#32ccfe'
                }
            },
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
                    data: [80, 29]
                }
            ]
        };

        examinationRoomPieOption = {
            title: {
                text: '设备总数',
                x: 'center',
                textStyle:{
                    fontWeight:'normal',
                    fontSize:16,
                    color:'#32ccfe'
                }
            },
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
                    data: [450, 379]
                }
            ]
        };

        // 作弊考试占比图表的配置项和数据
        examPieOption = {
            title: {
                //text: '设备运行占比',
                left: 'center',
                textStyle:{
                    color:'#32ccfe',
                    fontWeight:'normal',
                    fontSize:16,
                }
            },
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
                    // label: {
                    //     normal: {
                    //         show: true,
                    //         position: 'top',
                    //         formatter: '{c} %'
                    //     }
                    // },
                    //设置柱体颜色
                    itemStyle: {
                        normal: {color: '#b6e94a'}
                    },
                    data: [50,50]         //计算后的百分比
                },
                {
                    name: '在线异常',
                    type: 'bar',
                    stack: '在线',
                    barWidth: '20%',
                    // label: {
                    //     normal: {
                    //         show: true,
                    //         position: 'top',
                    //         formatter: '{c} %'
                    //     }
                    // },
                    //设置柱体颜色
                    itemStyle: {
                        normal: {color: '#cd3f67'}
                    },
                    data: [50,50]         //计算后的百分比
                },
                {
                    name: '离线正常',
                    type: 'bar',
                    stack: '离线',
                    barWidth: '20%',
                    // label: {
                    //     normal: {
                    //         show: true,
                    //         position: 'top',
                    //         formatter: '{c} %'
                    //     }
                    // },
                    //设置柱体颜色
                    itemStyle: {
                        normal: {color: '#32ccfe'}
                    },
                    data: [50,50]         //计算后的百分比
                },
                {
                    name: '离线异常',
                    type: 'bar',
                    stack: '离线',
                    barWidth: '20%',
                    // label: {
                    //     normal: {
                    //         show: true,
                    //         position: 'top',
                    //         formatter: '{c} %'
                    //     }
                    // },
                    //设置柱体颜色
                    itemStyle: {
                        normal: {color: '#fbf115'}
                    },
                    data: [50,50]         //计算后的百分比
                }
            ]
        };
      
        cheatedHzLineOption = {

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
            title: {
                text: '作弊频点散点图',
                left: 'center',
                top: 10,
                textStyle:{
                    fontWeight:'normal',
                    fontSize:16,
                    color:'#32ccfe'
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
                max:1300,
                splitNumber: 13
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
                data: []
            }]
        };
        // 使用刚指定的配置项和数据显示图表。
        cheatedPieChart.setOption(cheatedPieOption);
        examinationRoomPieChart.setOption(examinationRoomPieOption);
        examPieChart.setOption(examPieOption);
        cheatedHzLineChart.setOption(cheatedHzLineOption);
        cheatedExamChart.setOption(cheatedExamOption);
}