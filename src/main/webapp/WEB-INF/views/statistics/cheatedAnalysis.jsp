<%--
  Created by IntelliJ IDEA.
  User: flm
  Date: 2017/6/6
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>作弊分析图表</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/common/css/bootstrap.css"/>
    <script type="text/javascript" src="<%=basePath%>/static/common/js/echarts.js"></script>
</head>
<body>
<div class="container">
    <div class="row clearfix" style="margin:10px 5px 10px 30px;">
        <div class="col-md-3 column" id="cheatedPie" style="height: 220px">
        </div>
        <div class="col-md-3 column" id="examinationRoomPie" style="height: 220px">
        </div>
        <div class="col-md-3 column" id="examPie" style="height: 220px">
        </div>
    </div>
    <div class="row clearfix" style="margin:10px 150px 10px 30px;">
        <div class="col-md-12 column" id="cheatedHzLine" style="height: 300px">
        </div>
    </div>
</div>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<%--<div id="main" style="width: 600px;height:400px;"></div>--%>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var cheatedPieChart = echarts.init($('#cheatedPie')[0]);
    var examinationRoomPieChart = echarts.init($('#examinationRoomPie')[0]);
    var examPieChart = echarts.init($('#examPie')[0]);
    var cheatedHzLineChart = echarts.init($('#cheatedHzLine')[0]);

    // 作弊占比图表的配置项和数据
    cheatedPieOption = {
        title : {
            text: '作弊占比',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['作弊信号','非作弊信号']
        },
        series : [
            {
                name: '作弊占比',
                type: 'pie',
                radius : '55%',
                center: ['50%', '50%'],
                data:[
                    {value:40, name:'作弊信号'},
                    {value:150, name:'非作弊信号'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    // 作弊考点占比图表的配置项和数据
    examinationRoomPieOption = {
        title : {
            text: '作弊考点占比',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['作弊考点','非作弊考点']
        },
        series : [
            {
                name: '作弊考点占比',
                type: 'pie',
                radius : '55%',
                center: ['50%', '50%'],
                data:[
                    {value:27, name:'作弊考点'},
                    {value:32, name:'非作弊考点'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    // 作弊考试占比图表的配置项和数据
    examPieOption = {
        title : {
            text: '作弊考试占比',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['作弊考试','非作弊考试']
        },
        series : [
            {
                name: '作弊考试占比',
                type: 'pie',
                radius : '55%',
                center: ['50%', '50%'],
                data:[
                    {value:3, name:'作弊考试'},
                    {value:120, name:'非作弊考试'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };
    cheatedHzLineOption = {
        title: {
            text: '作弊频点'
        },
        tooltip: {
            trigger: 'axis'
        },
        toolbox: {
            show: true,
            feature: {
                dataZoom: {
                    yAxisIndex: 'none'
                },
                dataView: {readOnly: false},
                magicType: {type: ['line', 'bar']},
                restore: {},
                saveAsImage: {}
            }
        },
        xAxis:  {
            type: 'category',
            boundaryGap: false,
            data: ['70-100','100-200','200-300','300-400','400-500','500-600','600-700','700-800','800-900','900-1000','1000-1100','1100-1200','1200-1300']
        },
        yAxis: {
            type: 'value',
            axisLabel: {
                formatter: '{value}次'
            }
        },
        series: [
            {
                name:'最高次数',
                type:'line',
                data:[0, 1, 3, 1, 4, 9, 9,8, 9, 4, 1, 0, 1],
                markPoint: {
                    data: [
                        {type: 'max', name: '最大值'},
                        {type: 'min', name: '最小值'}
                    ]
                },
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
    cheatedPieChart .setOption(cheatedPieOption);
    examinationRoomPieChart .setOption(examinationRoomPieOption);
    examPieChart .setOption(examPieOption);
    cheatedHzLineChart .setOption(cheatedHzLineOption);
</script>
</body>
</html>
