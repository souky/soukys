<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>400</title>
    <script language="javascript" src="<%=basePath%>/static/common/js/jquery-3.1.1.js"></script>
    <script language="javascript" src="<%=basePath%>/static/jy/js/test/test.js"></script>
</head>
<body>
    <div class="container-fluid">
        <div class="page-header"><h1>400</h1></div>
        <a id="add"><span>aaaaaa</span></a>
    </div>
</body>
</html>