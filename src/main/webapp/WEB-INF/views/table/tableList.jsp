<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/header.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/table/tableList.css<%=version%>"/>
<body>
	<input type="hidden" id="message" value="${message}">
	<input type="hidden" id="basePath" value="<%=basePath%>">
	
	<div class="title_fixed ac">POWER BY SOUKY</div>
	<div id="tables">
		<div id="autoCode">
			
			
			<div class="main">
	            <div class="titleMain ac">
	                	查看奏折
	            </div>
	
	            <div class="formData clearfix">
	                <div class="items fl">
	                    <input v-model="query.realName" class="fomatInput" type="text" placeholder="姓名" />
	                </div>
	
	                <div class="items fl">
	                    <input v-model="query.phone" class="fomatInput" type="text" placeholder="手机号" />
	                </div>
	
	                <div class="items fl">
	                </div>
	                
	                <div class="items fl clearfix">
	                	<div class="query_btn fr ac CP" @click="loadData">查询</div>
	                </div>
	            </div>
	
	            <div class="titleMain ac">
	                	奏折列表
	            </div>
	            <div class="tableMain">
            		<el-table   :data="tableData"  style="width: 100%" >
			            <el-table-column align="center" prop="reallyName" label="姓名" ></el-table-column>
			            <el-table-column align="center" prop="phone" label="手机号" ></el-table-column>
			            <el-table-column align="center" prop="createDate" label="答题时间"  :formatter="formatDate"></el-table-column>
			            <el-table-column align="center" class-name="operations" label="操作" width="100">
				            <template slot-scope="scope">
				              <el-button type="primary" size="mini" >编辑</el-button>
				            </template>
			            </el-table-column>
	            	</el-table>
	            </div>
        	</div>
        	
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script  src="<%=basePath%>/static/jy/js/table/tableList.js<%=version%>"></script>
</html>
