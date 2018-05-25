$(function (){
//    var examNum = $("#selectExamName").val();
//    prepareData(examNum);
	getExamList();
})
function getExamList(){
	$.ajax({
		url:"statistics/queryExamList",
		type: "POST",
		dataType :"json",
		success	:function(data){
			var select = document.getElementById('selectExamName');
			$("#selectExamName").empty();
			select.options.add(new Option(" --请选择-- ",null));
		    for(var i = 0; i < data.result.length; i++){
				var exam = data.result[i];
		    	select.options.add(new Option(exam.examName,exam.id));
			}
		},
		error:function(data){
		    alert("加载考试列表失败");
		}
		});
	}

function loadDiagram(){
	var examNum = $("#selectExamName").val();
    prepareData(examNum);
}
    // 	准备数据
    function prepareData(examNum) {
        $.get("statistics/queryNum?examNum="+examNum, function (data) {

            // 基于准备好的dom，初始化echarts实例
            var cheatedPieChart = echarts.init($('#cheatedPie')[0]);
            var examinationRoomPieChart = echarts.init($('#examinationRoomPie')[0]);
            var examPieChart = echarts.init($('#examPie')[0]);
            var cheatedHzLineChart = echarts.init($('#cheatedHzLine')[0]);
            
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

            // 作弊考点占比图表的配置项和数据
            cheatedPieOption = {
                title: {
                    text: '作弊信号',
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
                        data: [data.result.cheatSignalNum, data.result.suspiciousSignalNum]
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
                        data: [data.result.detectiveNum, data.result.shieldNum]
                    }
                ]
            };

            // 作弊考试占比图表的配置项和数据
            examPieOption = {
                title: {
                    text: '设备运行占比',
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
                        data: [onlineNornalNumForDetectiveRate,
                            onlineNornalNumForShieldRate]         //计算后的百分比
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
                        data: [onlineInnornalNumForDetectiveRate,
                            onlineInnornalNumForShieldRate]         //计算后的百分比
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
                        data: [offlineNornalNumForDetectiveRate,
                            offlineNornalNumForShieldRate]         //计算后的百分比
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
                        data: [offlineInnornalNumForDetectiveRate,
                            offlineInnornalNumForShieldRate]         //计算后的百分比
                    }
                ]
            };
            var galdData = [
                []
            ];
            var result = data.result.pointList;
            if(result!=null){
            	for (i = 0; i < result.length; i++) {
                    var tempData = [];
                    tempData.push((result[i].frequencyPoint/1000).toFixed(3));
                    tempData.push(result[i].number);
                    galdData.push(tempData);
                }
            }
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
                    data: galdData
                }]
            };
            // 使用刚指定的配置项和数据显示图表。
            cheatedPieChart.setOption(cheatedPieOption);
            examinationRoomPieChart.setOption(examinationRoomPieOption);
            examPieChart.setOption(examPieOption);
            cheatedHzLineChart.setOption(cheatedHzLineOption);
        })
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