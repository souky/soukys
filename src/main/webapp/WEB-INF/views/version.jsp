<%
	java.util.Date currentTime = new java.util.Date();
	String version = "?v="+currentTime.getTime();
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String listenPath = request.getScheme() + "://" + request.getServerName() + ":" + "100" + "/CollectData";
%>