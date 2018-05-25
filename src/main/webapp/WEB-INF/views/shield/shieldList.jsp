<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Equipment Page</title>
    <%@ include file="/WEB-INF/views/version.jsp"%>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/equipment/equipment.css<%=version%>"/>
</head>
<body>

    <input type="hidden" id="basePath" value="<%=basePath%>"/>
    <form id="tbForm">
        <div class="Jry_table" id="testTable">
            <div class="buttons">
                <div class="btns delet_btn" onclick="delAll()">
                    <div class="imgButton">
                        <img src="<%=basePath%>/static/jy/img/pcImg/delete.png">
                    </div>
                    <div class="textButton">删除</div>
                </div>
            </div>
            <div class="table_body">
                <input type="hidden" id="isUpperOrg" value="${isUpperOrg}">
                <table id="table">
                    <tbody id="deviceList">
                    <tr>
                        <td><input id="delAll" type="checkbox" onclick="toggleSelectAll(this)"/></td>
                        <td>序号</td>
                        <td>类型</td>
                        <td>IP地址</td>
                        <td>MAC地址</td>
                        <td>版本号</td>
                        <td>状态</td>
                        <td>受控状态</td>
                        <td>开启模块</td>
                        <td>操作</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </form>

    <div class="navi">
        <form id="naviForm">
            <div class="Jry_page" id="pageCss">
                <input type="hidden" class="pageNow"  id="pageNum" />
                <input type="hidden" class="pageTotal" id="pages" />
                <input type="hidden" name="pageNum" id="pageNum1"/>
                <input type="hidden" name="pageSize" value="10"/>
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
        </form>
    </div>

    <div class="hide" id="bootDiv" style="width:350px">
        <form id="bootForm_JRY">
            <div class="Jcustom_title" id="bootTitle_JRY"></div>
            <input id="hiddenId" type="hidden" name="id"/>
            <div class="Jcustom_content">
                <br/>
                <div class="row clearfix">
                    <div class="fl">选择控制方式：</div>
                    <div class="fl inputRadio">
                        <input id="manualRedio_JRY" type="radio" name="controlled" value=2 onclick="enableModule()" />
                    </div>
                    <div class="fl inputText">手动</div>
                    <div class="fl inputRadio">
                        <input id="autoRadio_JRY" type="radio" name="controlled" value=1 onclick="disableModule()"/>
                    </div>
                    <div class="fl inputText">自动</div>
                    <div class="fl rightpart"><font color="red">注</font>："手动"可选模块,"自动"清除手控命令</div>
                </div>
                <br/>
                <div class="row" id="moduleDiv">
                    <div class="fl">选择打开模块：</div>
                    <div class="fl inputRadio">
                        <input id="1g_JRY" type="checkbox" class="moduleInput" name="operationType1G" value=3 />
                    </div>
                    <div class="fl inputText">1G模块</div>
                    <div class="fl inputRadio">
                        <input id="phone_JRY" type="checkbox" class="moduleInput" name="operationTypePhone" value=4 />
                    </div>
                    <div class="fl inputText">手机模块</div>
                    <div class="fl rightpart"><font color="red">注</font>：全不选两个模块休眠 </div>
                </div>
                <br/>
                <div class="Jcustom_content_btns">
                    <div class="okBtn btns"  onclick="doBoot()">确定</div>
                    <div class="cancelBtn btns" onclick="CancelPop()">取消</div>
                </div>
            </div>

        </form>
    </div>

</body>

    <script type="text/javascript" src="static/jy/js/common/validate.js"></script>
    <%--<script type="text/javascript" src="static/jy/js/device/device.js<%=version%>"></script>--%>
    <script type="text/javascript">
        var basePath = $("#basePath").val();
        $(function(){
            loadData(1);
        });

        //加载table list数据
        function loadData(pageNums){
            if(isNaN(pageNums)){
                JRYPopup.Jalert("请输入正确的页码");
                return;
            }
            if(pageNums < 1){
                JRYPopup.Jalert("页码应从1开始");
                return;
            }
            var isUpperOrg = $("#isUpperOrg").val();
            $("#pageNum1").val(pageNums);
            var url="device/queryDevices.do";
            $.ajax({
                cache: true,
                type: "POST",
                url: url,
                dataType: "json",
                data:{pageNum:pageNums,type:2},
                success:function(data){

                    var html = "";
                    //isUpperOrg==true 为上级,显示数据的组织机构
                    if(isUpperOrg){
                        html += "<tr><th><input id='delAll' type='checkbox' onclick='toggleSelectAll(this)'/></th>"
                            + "<th>序号</th><th>组织机构</th><th>类型</th><th>IP地址</th><th>MAC地址</th><th>地点</th><th>版本号</th>"
                            + "<th>状态</th><th>受控状态</th><th>开启模块</th><th>操作</th></tr>";
                    }else{
                        html += "<tr><th><input id='delAll' type='checkbox' onclick='toggleSelectAll(this)'/></th>"
                            + "<th>序号</th><th>类型</th><th>IP地址</th><th>MAC地址</th><th>地点</th><th>版本号</th>"
                            + "<th>状态</th><th>受控状态</th><th>开启模块</th><th>操作</th></tr>";
                    }


                    if(data.result.total == 0){
                        html += "<tr><td colspan='10' class='text-danger text-center'>没有相关数据</td></tr>";
                    }else{
                        var result=data.result.list;
                        for(var i=0;i<result.length;i++){
                            var index = i+1;
                            var type = "未知";
                            var status = "未知";
                            var controlled = "未知";
                            var operationType = "未知";

                            if(result[i].type==1){
                                type = "侦测";
                            }else if(result[i].type==2){
                                type = "阻断";
                            }

                            if(result[i].status==1){
                                status = "在线";
                            }else if(result[i].status==2){
                                status = "离线";
                            }

                            if(result[i].controlled==1){
                                controlled = "自动";
                            }else if(result[i].controlled==2){
                                controlled = "手动";
                            }

                            if(result[i].operationType==1){
                                operationType = "自动";
                            }else if(result[i].operationType==2){
                                operationType = "手动-全部";
                            }else if(result[i].operationType==3){
                                operationType = "手动-1G";
                            }else if(result[i].operationType==4){
                                operationType = "手动-手机";
                            }else if(result[i].operationType==5){
                                operationType = "手动-未选";
                            }

                            html += "<tr><td>";
                            if(result[i].type!=1){//这侧设备不允许删除
                                html += "<input name='ids' type='checkbox' value='"+result[i].id+" ' />"
                            }
                            html += "</td><td>" + index + "</td>";
                            if(isUpperOrg){
                                html += "<td>" + result[i].organization.name + "</td>";
                            }
                            html += "<td >"+type+"</td>"
                                +"<td >"+result[i].ip+"</td>"
                                +"<td >"+result[i].mac+"</td>";
                            if(result[i].address == null){
                                html += "<td></td>";
                            }else{
                                html += "<td >"+result[i].address+"</td>";
                            }

                            html +=	"<td >"+result[i].version+"</td>"
                                +"<td >"+status+"</td>";

                            if(result[i].type==1){
                                html += "<td >"+ '---' +"</td>"
                                    +"<td >"+ '---' +"</td>";
                            }else if(result[i].type==2){
                                html += "<td >"+controlled+"</td>"
                                    +"<td >"+operationType+"</td>";
                            }
                            html+= "<td >"
                                +"<img title='编辑' onclick='goEdit(this)' class='tdImg' name='"
                                +result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/edit.png'>"
                                +"<img title='删除' onclick='del(this)' class='tdImg' name='"
                                +result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/deleteT.png'>"

                            if(result[i].type=="2" && result[i].status==1 ){//在线的阻断设备可开机
                                html += "<img title='开机' style='border-width:0px;visibility:visible;' onclick='boot(this)' class='tdImg' name='"
                                    +result[i].id+"' src='"+basePath+"/static/jy/img/pcImg/boot.png'>";
                            }
                            html += "</td></tr>";

                        }
                    }
                    var tbody = $("#deviceList");
                    tbody.html(html);

                    $("#pageNum").val(data.result.pageNum);
                    $("#pages").val(data.result.pages);

                    var pageTotal = $("#pageCss").find(".pageTotal").val();
                    JRYPage.pageInit('pageCss',pageNums,pageTotal,11,changePage);
                },
                error: function (msg) {
                    JRYPopup.Jalert("数据加载失败!");
                }
            })

        }


        //上一页
        function proPage(){
            var pageNow = $("#pageCss").find(".pageNow").val();
            var pageNums = parseInt(pageNow)-1;
            if(pageNums<1){
                return;
            }else{
                loadData(pageNums);
            }
        }
        //下一页
        function nextPage(){
            var pageNow = $("#pageCss").find(".pageNow").val();
            var pageTotal = $("#pageCss").find(".pageTotal").val();
            var pageNums = parseInt(pageNow)+1;
            if(pageNums > pageTotal){
                return;
            }else{
                loadData(pageNums);
            }
        }
        //分页
        function changePage(obj,pages){
            if(pages==""){
                JRYPopup.Jalert("请输入页码！");
            }else{
                var pageNums = 1;
                if(pages){
                    pageNums = pages;
                }else{
                    pageNums = $(obj).text();
                }
                var pageTotal = $("#pageCss").find(".pageTotal").val();
                if(pageNums!='...'){
                    pageNums = parseInt(pageNums);
                    pageTotal = parseInt(pageTotal);
                    if (pageNums>pageTotal) {
                        JRYPopup.Jalert("输入的页码超出最大范围");
                        return;
                    }
                    loadData(pageNums);
                }
            }
        }

    </script>
</html>