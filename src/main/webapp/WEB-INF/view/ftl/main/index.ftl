<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
    <meta name="author" content="Souky" />
    <meta name="copyright" content="Souky" />
    <meta name="keywords" content="Souky"/>
    <link rel="stylesheet" href="resources/css/base.css">
<style type="text/css">
#homeJ{font-family: "微软雅黑";}

/*头部*/
#homeJ .headJ{width: 100%;min-height: 200px;}
#homeJ .headJ .topH{width: 100%;background: #FF5985;color: #fff;}
#homeJ .headJ .topH .inset{height: 30px;line-height: 30px;}
#homeJ .headJ .topH .inset .loginJ{width: 200px;margin-left: 50px;color: #fff;font-size: 14px;}
#homeJ .headJ .topH .inset .loginJ:hover{color:#FFEB3B;}

#homeJ .headJ .topAD{width: 1200px;height: 350px;position: relative;margin: auto;margin-top: 20px;}
/*
#homeJ .headJ .topAD .left{width: 600px;height: 300px;z-index: 22;left: 0px;top: 25px;-webkit-filter: grayscale(100%); position: absolute;}
#homeJ .headJ .topAD .middle{width: 700px;height: 350px;z-index: 33;left: 250px;top: 0px;-webkit-filter: grayscale(0%); position: absolute;box-shadow: 1px 1px 20px #000;}
#homeJ .headJ .topAD .right{width: 600px;height: 300px;z-index: 22;right: 0px;top: 25px;-webkit-filter: grayscale(100%); position: absolute;}
*/
#homeJ .headJ .topAD {}
#homeJ .headJ .topAD .middle{width: 700px;height: 350px;left: 250px;top: 0px; position: absolute;box-shadow: 1px 1px 20px #000;}
#homeJ .headJ .topAD .orther{-webkit-filter: grayscale(100%);}
#homeJ .headJ .topAD .choice{z-index: 999;}
#homeJ .headJ .topAD .choiceLR{z-index: 22;}

#homeJ .headJ .bottomShadow{margin:0px auto 20px auto;width: 1200px;height:40px;border-radius: 1500px/50px;
	background: radial-gradient(#000,#fff,#fff);z-index: 11;}
</style>
</head>


<body style="position:relative;">
	<div id="homeJ">
		<div class="headJ">
			<!-- 最顶部功能栏 start -->
			<div class="topH">
				<div class="inset w">
					 <div class="loginJ fl CP">小婊杂点这儿登录</div>
					 <div class="fl CP "></div>
				</div>
			</div>
			<!-- 最顶部功能栏 end -->

			<!-- 头部广告轮播 start -->
			<div class="topAD">
				<div class="middle">
					<img data-rotate="1" src="resources/img/HOMEJ/1.jpg" style="width:100%;">
				</div>
				<div class="middle">
					<img data-rotate="2" src="resources/img/HOMEJ/2.jpg" style="width:100%;">
				</div>
				<div class="middle">
					<img data-rotate="3" src="resources/img/HOMEJ/3.jpg" style="width:100%;">
				</div>
				<div class="middle">
					<img data-rotate="4" src="resources/img/HOMEJ/4.jpg" style="width:100%;">
				</div>
				
			</div>
			<div class="bottomShadow"></div>
			<!-- 头部广告轮播 end -->
		</div>
	</div>
	
	<div style="margin-top:200px;"> 
		<div style="width:200px;margin:auto;background:#f40;color:#fff;" onclick="rotateRight()">
			向右
		</div>
	</div>
</body>


<script type="text/javascript" src="resources/js/jquery.min.js"></script>
<script>
//定义全局变量
var size = 0;

$(function(){
	initrotate();


})

//初始化轮播  必须要超过3张图才可使用此轮播
function initrotate(){
	size = $(".topAD").find("img").size();
	if(size<3){
		return;
	}
	var obj = $(".topAD").find("img[data-rotate='2']").parent();
	if(!obj){
		return;
	}
	obj.addClass("choice");
	var preObj = obj.prev();
	var nexObj = obj.next();
	if(preObj=='undefined' || nexObj=='undefined'){
		return;
	}
	//颜色调灰
	preObj.addClass("orther");
	nexObj.addClass("orther");
	
	preObj.addClass("choiceLR");
	nexObj.addClass("choiceLR");

	preObj.animate({left:'0px',width:'600px',height:'300px',top:'25px'},400,'swing');
	nexObj.animate({left:'600px',width:'600px',height:'300px',top:'25px'},400,'swing');
}

//向右轮换
function rotateRight(){
	var dataR = parseInt($(".topAD .choice img").attr("data-rotate"));
	dataC = dataR-1;
	if(dataC==0){
		dataC = size;
	}
	var obj = $(".topAD").find("img[data-rotate='"+dataC+"']").parent();
	
	$(".topAD").find("img[data-rotate='"+dataR+"']").parent().next().removeClass("choiceLR");
	

	if(!obj){
		return;
	}
	//
	var preObj = obj.prev();
	var nexObj = obj.next();

	var yanzheng = obj.prev().children().attr("data-rotate");

	if(!yanzheng){
		
		preObj = $(".topAD").find("img[data-rotate='"+size+"']").parent();
	}
	
	preObj.addClass("orther");
	nexObj.addClass("orther");
	nexObj.removeClass("choice");
	obj.addClass("choice");

	preObj.addClass("choiceLR");
	nexObj.addClass("choiceLR");

	obj.removeClass("orther");
	obj.removeClass("choiceLR");
	
	obj.animate({left:'250px',width:'700px',height:'300px',top:'0px'},400,'swing');
	preObj.animate({left:'0px',width:'600px',height:'300px',top:'25px'},400,'swing');
	nexObj.animate({left:'600px',width:'600px',height:'300px',top:'25px'},400,'swing');

}

//向左轮换
function rotateLeft(){
	var dataR = $(".topAD .choice").attr("data-rotate");

}

</script>

</html>