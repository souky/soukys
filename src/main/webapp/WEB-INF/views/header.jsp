<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<%=basePath%>/static/common/css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>/static/common/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>/static/common/css/font-awesome.min.css" rel="stylesheet"/>
<link href="<%=basePath%>/static/common/css/bootstrap-tour.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/jy/css/common/common.css"/>
<script language="javascript" src="<%=basePath%>/static/common/js/md5.js"></script>
<script language="javascript" src="<%=basePath%>/static/common/js/jquery-3.1.1.js"></script>
<script language="javascript" src="<%=basePath%>/static/common/js/bootstrap.min.js"></script>
<script language="javascript" src="<%=basePath%>/static/common/js/bootstrap-tour.min.js"></script>
<script language="javascript" src="<%=basePath%>/static/common/js/jquery.tips.js"></script>
