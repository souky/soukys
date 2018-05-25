<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>数据统计分析</title>
    <%@ include file="/WEB-INF/views/version.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/common/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/common/css/bootstrap-datetimepicker.min.css"/>
    <style>
        .right_part_context {
            background: rgba(17, 28, 52, 1) !important;
        }
        .col-md-3{width:30%;}
        #cheatedHzLine{width:90%;margin:auto;}
        .query_items label{color:#fff;}
        .Jry_query{
            border-bottom: none;
        }
        .Jry_query .query_btn {
            float: left;
        }
    </style>
</head>
<body>
<div style="overflow-x: hidden;">
	<div class="Jry_query">
		<div class="query_part">
			<div class="query_items">
			</div>
			
			<div class="query_items">
				<label>考试名称:</label>
				<div class="inputDivOne">
					<select name="examNum" id="selectExamName">
						<option value=""> --请选择-- </option>
					</select>
				</div>
			</div>
			
			<div class="query_items">
				<div class="query_btn" onclick="loadDiagram()">
					查　询
				</div>
			</div>
			
		</div>
	</div>
	<div class="querysS">
	    <div class="row clearfix" style="margin:30px 5px 10px 30px;">
	        <div class="col-md-3 column" id="examinationRoomPie" style="height: 220px">
	        </div>
	        <div class="col-md-3 column" id="examPie" style="height: 220px">
	        </div>
	        <div class="col-md-3 column" id="cheatedPie" style="height: 220px">
	        </div>
	    </div>
	    <div class="row clearfix" style="margin:20px 5px 10px 30px;">
	        <div class="" id="cheatedHzLine" style="height: 300px">
	        </div>
	    </div>
    </div>
</div>
<script type="text/javascript" src="<%=basePath%>/static/common/js/echarts.js"></script>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<%--<div id="main" style="width: 600px;height:400px;"></div>--%>
<script type="text/javascript" src="static/jy/js/statistics/statisticsAnalysis.js<%=version%>"></script>
</body>
</html>
