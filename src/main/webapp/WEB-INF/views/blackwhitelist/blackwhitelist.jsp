<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <head>
        <%--<%@ include file="/WEB-INF/views/header.jsp" %>--%>
        <%@ include file="/WEB-INF/views/version.jsp" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>黑白名单列表</title>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
        <link rel="stylesheet" href="<%=basePath%>/static/jy/css/blackwhite/popover.css<%=version%>"/>
        <style type="text/css">
            td {vertical-align:middle;}
            .assistantStrsTd{position:relative;cursor:pointer;}
            .assistantStrs{position:absolute;top:-50%;right:-100px;width:100px;line-height:30px;background:#fff;color:#333;border-radius:3px;box-shadow:1px 1px 10px #000;}
        </style>
    </head>
</head>
<body>
<input type="hidden" id="basePath" value="<%=basePath%>"/>
<div class="Jry_query">
    <div class="query_part">
        <form id="findForm">
            <div class="query_items">
                <label>频类：</label>
                <div class="inputDivOne">
                    <select id="frequencyType" name="frequencyType">
                        <option disabled selected>----请选择频类----</option>
                        <option value=-1>全部</option>
                        <option value=0>未知</option>
                        <option value=1>频点</option>
                        <option value=2>频段</option>
                    </select>
                </div>
            </div>
            <div class="query_items">
                <label>类型：</label>
                <div class="inputDivOne">
                    <select id="type" name="type">
                        <option disabled selected>----请选择类型----</option>
                        <option value=-1>全部</option>
                        <option value=0>未知</option>
                        <option value=1>黑名单</option>
                        <option value=2>高可疑</option>
                        <option value=3>中可疑</option>
                        <option value=4>低可疑</option>
                        <option value=5>白名单</option>
                    </select>
                </div>
            </div>
            <div class="query_items">
                <label>来源：</label>
                <div class="inputDivOne">
                    <select id="source" name="source">
                        <option disabled selected>----请选择来源----</option>
                        <option value=-1>全部</option>
                        <option value=0>未知</option>
                        <option value=1>本地</option>
                        <option value=2>平台</option>
                    </select>
                </div>
            </div>
            <div class="query_items">
            	<div class="query_btns">
		                <div class="query_btn" onclick="exportList()">导  出</div>
		              	<div class="query_btn" onclick="loadData(1,10)"> 查　询</div>
	            </div>
            </div>
        </form>
    </div>
    
<%--     <div class="query_part">
	        <form action="<%=basePath%>blackwhitelist/importBlackWhiteList" name="importExcel" id="importExcel" method="post" enctype="multipart/form-data">
	            <div class="query_items">
	                <label>上传文件：</label>
	                <div class="inputDivOne">
	                    <input type="file" name="file" id="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
	                </div>
	            </div>
	            <div class="query_items">
	            	<div class="query_btns">
		              <!--   <button type="submit" onclick="submitExcel();">导入</button>   -->
		                <button type="submit" onclick="document.importExcel.submit();">导入</button>  
		            </div>
	            </div>
	        </form>
	</div>  --%>
	
	<div class="query_part">
	        <form action="" name="importExcel" id="importExcel" method="post" enctype="multipart/form-data">
	        	<div class="query_items"></div>
	        	<div class="query_items"></div>
	            <div class="query_items">
	                <label>上传文件：</label>
	                <div class="inputDivOne">
		                <a href="javascript:;" class="a-upload">
						    <input type="file" name="file" id="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
						    <span class="text_file">点击上传文件</span>
						</a>
	                </div>
	            </div>
	            <div class="query_items">
	            	<div class="query_btns">
		                <!-- <button type="submit" onclick="submitExcel();">导入</button>   -->
		                <div class="query_btn" onclick="submitExcel()">
		               		 导 入
		                </div>
		                <div class="query_btn" onclick="window.location.href='<%=basePath%>blackwhitelist/downloadBWListTemplate'">
                                                      下载模板
                        </div>
		            </div>
	            </div>
	        </form>
	</div>
    
</div>

<div id="showBlackwhitelist">
    <input type="hidden" id="isUpperOrg" value="${isUpperOrg}">
    <div class="Jry_table" id="blackwhitelistTables">
        <div class="buttons">
            <div class="btns addnew_btn">
            <div class="imgButton">
            <img src="<%=basePath%>/static/jy/img/pcImg/add.png">
            </div>
            <div class="textButton" onclick="doCreated()">新增</div>
            </div>
            <div class="btns delet_btn">
            <div class="imgButton">
            <img src="<%=basePath%>/static/jy/img/pcImg/delete.png">
            </div>
            <div class="textButton">删除</div>
            </div>
        </div>
        <div class="table_body">
            <table>
            	<tbody id="tbody">
                </tbody>
            </table>
        </div>
    </div>
    <%--分页--%>
    <div class="Jry_page" id="pageCss">
        <input type="hidden" class="pageNow" />
        <input type="hidden" class="pageTotal"/>
        <div class="page_body">
            <div class="prev_page" onclick="proPage()">上一页</div>
            <div class="maps_page"></div>
            <div class="next_page" onclick="nextPage()">下一页</div>
            <div class="jump_page">
                跳转到<input type="text" maxlength="3">页
            </div>
            <div class="jump_button">GO</div>
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
<div id="editBlackwhitelist" class="hide">
<div class="Jcustom_title">编辑黑白名单</div>
<div class="Jcustom_content">
    <form class="saveAndEdit_JRY" id="editForm_JRY" style="overflow: auto">
        <input type="hidden" name="id" id="id_JRY"/>
        <div class="Jcustom_content_items ">
            <label>频类:</label>
            <select name="frequencyType" id="frequencyType2_JRY" onchange="changeSectionValue(this)">
                <option disabled selected>----请选择频类----</option>
                <option value=1>频点</option>
                <option value=2>频段</option>
            </select>
            <div class="error_text"></div>
        </div>
        <div class="Jcustom_content_items ">
            <label>类型:</label>
            <select  name="type" id="type2_JRY">
                <option disabled selected>----请选择类型----</option>
                <option value=1>黑名单</option>
                <option value=2>高可疑</option>
                <option value=3>中可疑</option>
                <option value=4>低可疑</option>
                <option value=5>白名单</option>
            </select>
            <div class="error_text"></div>
        </div>
        <div class="Jcustom_content_items ">
            <label class="sectionLabel">主频点:</label>
            <input type="text" name="marjorFrequency" id="marjorFrequency_JRY" class="edit  " placeholder="请输入主频点"/>
            <div class="error_text"></div>
        </div>
        <div class="section" >
            <div class="Jcustom_content_items ">
                <label id="assintPoint_JRY">副频点:</label>
                <input type="text" name="secondFrequency" id="secondFrequency_JRY" class="edit  "placeholder="请输入副频点"/>
                <div class="error_text"></div>
            </div>
        </div>
        <div class="Jcustom_content_items ">
            <label>来源:</label>
            <input type="text" name="source" id="source2_JRY" value="本地" readonly style="cursor: no-drop"/>
            <%--<select  name="source" id="source2_JRY">
                <option disabled selected>----请选择来源----</option>
                <option value=1>本地</option>
                <option value=2>平台</option>
            </select>--%>
            <div class="error_text"></div>
        </div>
    </form>
    <div class="Jcustom_content_btns">
        <div class="okBtn btns" onclick="doSave()">确定</div>
        <div class="cancelBtn btns" onclick="doCancel()">取消</div>
    </div>
</div>
</div>
</body>
<script language="javascript" src="<%=basePath%>/static/common/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/jy/js/blackwhitelist/blackwhitelist.js<%=version%>"></script>
<script type="text/javascript" src="<%=basePath%>/static/jy/js/user/ajaxfileupload.js"></script>
</html>