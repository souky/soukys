<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<link href="<%=basePath%>/static/jy/css/common/audioplayer.css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath%>static/jy/js/common/audioplayer.min.js" charset="UTF-8"></script>
<body>
<div id="" style="margin:25% auto;">
	<object id="saftyplay" width="0" height="0" classid="CLSID:93CDB2B5-50BC-42C5-B788-C7BB0D95E79A" codebase="<%=basePath%>/static/common/SafePlay.cab#version=1,0,0,10"></object>
	<input type="hidden" value="${src}" id="srcUrl">
</div>

<div id="wrapper" style="margin:25% auto;">
	<audio preload="auto" controls>
		<source src="${src }">
	</audio>
</div>


</body>

<script>$( function() { $( 'audio' ).audioPlayer(); } );</script>
<script>$( function() {
	//var sp = document.getElementById("saftyplay");
   // sp.SetUrl($("#srcUrl").val());
});</script>
</html>
