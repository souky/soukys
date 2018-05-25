<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Page</title>
    <%@ include file="/WEB-INF/views/header.jsp" %>
</head>
<body>
<div class="container">
    <div class="row footer">
        <span>每页显示</span>
        <div class="input-group">
            <input type="text" class="form-control" value="5">
            <div class="input-group-btn">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu pull-right">
                    <li><a href="#">5</a></li>
                    <li><a href="#">10</a></li>
                    <li><a href="#">20</a></li>
                </ul>
            </div>
        </div>
        <span>条记录</span>
        <ul class="pagination">
            <li name="changePage"><a href="#">&laquo;</a></li>
            <li name="changePage"><a href="#">&raquo;</a></li>
        </ul>
        <span>显示第</span>
        <div class="input-group">
            <input type="text" class="form-control" value="1">
            <div class="input-group-btn">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu pull-right">
                </ul>
            </div>
        </div>
        <span>页</span>
    </div>
</div>
</body>
</html>
