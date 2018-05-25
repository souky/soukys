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
        <div class="col-md-5 column" id="equipmentOnlinePie" style="height: 350px">
        </div>
        <div class="col-md-5 column" id="equipmentTypePie" style="height: 350px">
        </div>
    </div>
</div>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<%--<div id="main" style="width: 600px;height:400px;"></div>--%>
<script type="text/javascript">

// 	准备数据
	$(function prepareData(){
	$.get("statistics/queryEquipmentsNum",function(data){
		
		 // 基于准备好的dom，初始化echarts实例
	    var equipmentOnlinePieChart = echarts.init($('#equipmentOnlinePie')[0]);
	    var equipmentTypePieChart = echarts.init($('#equipmentTypePie')[0]);

	    // 设备在线图表的配置项和数据
	    equipmentOnlinePieOption = {
	        title : {
	            text: '设备在线',
	            x:'center'
	        },
	        tooltip : {
	            trigger: 'item',
	            formatter: "{a} <br/>{b} : {c} ({d}%)"
	        },
	        legend: {
	            orient: 'vertical',
	            left: 'left',
	            data: ['在线','离线']
	        },
	        series : [
	            {
	                name: '设备在线',
	                type: 'pie',
	                radius : '55%',
	                center: ['50%', '50%'],
	                data:[
	                    {value:data.result.onlineNum, name:'在线'},
	                    {value:data.result.offlineNum, name:'离线'}
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

	    // 设备类型图表的配置项和数据
	    equipmentTypePieOption = {
	        title : {
	            text: '设备类型',
	            x:'center'
	        },
	        tooltip : {
	            trigger: 'item',
	            formatter: "{a} <br/>{b} : {c} ({d}%)"
	        },
	        legend: {
	            orient: 'vertical',
	            left: 'left',
	            data: ['阻断设备','侦测设备']
	        },
	        series : [
	            {
	                name: '设备类型',
	                type: 'pie',
	                radius : '55%',
	                center: ['50%', '50%'],
	                data:[
	                    {value:data.result.shieldNum, name:'阻断设备'},
	                    {value:data.result.detectiveNum, name:'侦测设备'}
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
	    // 使用刚指定的配置项和数据显示图表。
	    equipmentOnlinePieChart .setOption(equipmentOnlinePieOption);
	    equipmentTypePieChart .setOption(equipmentTypePieOption);
	})
})
   
</script>
</body>
</html>
