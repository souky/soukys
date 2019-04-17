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
	            <div class="tables">
            		<el-table   :data="tableData"  style="width: 100%" >
			            <el-table-column align="center" prop="reallyName" label="姓名" ></el-table-column>
			            <el-table-column align="center" prop="phone" label="手机号" ></el-table-column>
			            <el-table-column align="center" prop="createDate" label="答题时间" ></el-table-column>
			            <el-table-column align="center" class-name="operations" label="操作" width="90">
				            <template slot-scope="scope">
				             	<div class="op_items">
			    					<el-button size="mini" @click="show(scope.row.id)">查看</el-button>
			    				</div>
				            </template>
			            </el-table-column>
	            	</el-table>
	            </div>
	            <div class="pages_so">
	            	<el-pagination @size-change="pageSizeChange" @current-change="pageChange" :current-page.sync="page.pageNum"
				      :page-sizes="[10, 20, 30, 40]"
				      :page-size="page.pageSize"
				      layout="sizes,prev, pager, next,jumper" :total="page.total">
				    </el-pagination>
	            </div>
	            
        	</div>
        	
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script  src="<%=basePath%>/static/jy/js/table/tableList.js<%=version%>"></script>
</html>
