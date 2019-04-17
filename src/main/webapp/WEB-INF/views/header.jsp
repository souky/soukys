<html>
<head>
    <meta charset="UTF-8">
    <title>audition</title>
	<%
		java.util.Date currentTime = new java.util.Date();
		String version = "?v="+currentTime.getTime();
		String path = request.getContextPath();
	    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	    String listenPath = request.getScheme() + "://" + request.getServerName() + ":" + "100" + "/CollectData";
	%>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/jry-Plug-in.css"/>
    <link rel="stylesheet" href="https://unpkg.com/element-ui@2.6.3/lib/theme-chalk/index.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css<%=version%>"/>
</head>