<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理平台</title>
    <%@ include file="/WEB-INF/views/header.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/main/mainPage.css"/>
    <script type="text/javascript" src="<%=basePath%>/static/jy/js/main/mainPage.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/page.css"/>
    <script type="text/javascript" src="<%=basePath%>/static/jy/js/common/page.js"></script>
    <script type="text/javascript" src="<%=basePath%>/static/common/js/ztree/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="<%=basePath%>/static/common/js/ztree/jquery.ztree.excheck.js"></script>
    <link rel="stylesheet" href="<%=basePath%>/static/common/css/ztree/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
<input type="hidden" id="basePath" value="<%=basePath%>"/>
<nav class="navbar-default">
    <ul class="nav" id="listAll">
    </ul>
</nav>
<div class="mainContent">
    <div class="topTitle"></div>
    <div class="row content-tabs">
        <button type="button" class="pull-left">
            <span class="glyphicon glyphicon-backward"></span>
        </button>
        <nav class="nav nav-tabs">
            <a href="#" data-id="mainIframe">首页</a>
            <%--<a href="#">首页<span class="glyphicon glyphicon-remove-sign"></span></a>--%>
        </nav>
        <button type="button" class="roll-nav right178">
            <span class="glyphicon glyphicon-forward"></span>
        </button>
        <div class="roll-nav right84">
            <button class="dropdown" data-toggle="dropdown">
                关闭操作<span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right">
                <li class=""><a>关闭全部选项卡</a>
                </li>
                <li class=""><a>关闭其他选项卡</a>
                </li>
            </ul>
        </div>
        <button id="logout" type="button" class="roll-nav right10">
            <span class="glyphicon glyphicon-log-out"></span>
            退出
        </button>
    </div>
    <div id="jspPage" class="iframeHeight">
        <div id="mainIframe">
           
        </div>
    </div>
</div>
</body>
</html>
