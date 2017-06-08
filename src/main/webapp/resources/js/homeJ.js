//定义全局变量
var size = 0;
var isfirstAutoRotate = false;
var isAutoRotate = true;

$(function(){
	initrotate();
	autoRotate();
	specialArea();
	
})


//专区的特效
function specialArea(){
	$("#homeJ .mainJ .messageShow .middleMS .items").hover(
		function(){
			$(this).find(".insideShadow").fadeIn(300);
		},function(){
			$(".insideShadow").hide();
		}
	)
}

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

	preObj.animate({left:'0px',width:'600px',height:'300px',top:'25px'},400,'linear');
	nexObj.animate({left:'600px',width:'600px',height:'300px',top:'25px'},400,'linear');

	isfirstAutoRotate = true;

	$(".topAD").hover(
		function(){
			isAutoRotate = false;
		},function(){
			isAutoRotate = true;
		}
	);
}

//自动轮换
function autoRotate(){
	if(!isfirstAutoRotate){
		if(isAutoRotate){
			rotateLeft();
		}
	}else{
		isfirstAutoRotate = false;
	}
	setTimeout("autoRotate()",3000);
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

	var yanzhengPre = obj.prev().children().attr("data-rotate");
	var yanzhengNex = obj.next().children().attr("data-rotate");

	if(!yanzhengPre){
		preObj = $(".topAD").find("img[data-rotate='"+size+"']").parent();
	}
	if(!yanzhengNex){
		nexObj = $(".topAD").find("img[data-rotate='1']").parent();
	}

	obj.animate({left:'250px',width:'700px',height:'350px',top:'0px'},300,'linear');
	preObj.animate({left:'0px',width:'600px',height:'300px',top:'25px'},300,'linear');
	nexObj.animate({left:'600px',width:'600px',height:'300px',top:'25px'},300,'linear');

	preObj.addClass("orther");
	nexObj.addClass("orther");
	nexObj.removeClass("choice");
	obj.addClass("choice");

	$(".topAD").children().removeClass("choiceLR");

	if(!preObj.hasClass("choiceLR")){
		preObj.addClass("choiceLR");
	}
	if(!nexObj.hasClass("choiceLR")){
		nexObj.addClass("choiceLR");
	}

	obj.removeClass("orther");
	obj.removeClass("choiceLR");
	

}

//向左轮换
function rotateLeft(){
	var dataR = parseInt($(".topAD .choice img").attr("data-rotate"));
	dataC = dataR+1;
	if(dataC>size){
		dataC = 1;
	}
	// alert(dataC)
	var obj = $(".topAD").find("img[data-rotate='"+dataC+"']").parent();
	
	$(".topAD").find("img[data-rotate='"+dataR+"']").parent().next().removeClass("choiceLR");
	

	if(!obj){
		return;
	}
	//
	var preObj = obj.prev();
	var nexObj = obj.next();

	var yanzhengPre = obj.prev().children().attr("data-rotate");
	var yanzhengNex = obj.next().children().attr("data-rotate");

	if(!yanzhengPre){
		preObj = $(".topAD").find("img[data-rotate='"+size+"']").parent();
	}
	if(!yanzhengNex){
		nexObj = $(".topAD").find("img[data-rotate='1']").parent();
	}

	obj.animate({left:'250px',width:'700px',height:'350px',top:'0px'},300,'linear');
	preObj.animate({left:'0px',width:'600px',height:'300px',top:'25px'},300,'linear');
	nexObj.animate({left:'600px',width:'600px',height:'300px',top:'25px'},300,'linear');

	preObj.addClass("orther");
	nexObj.addClass("orther");
	preObj.removeClass("choice");
	obj.addClass("choice");

	$(".topAD").children().removeClass("choiceLR");

	if(!preObj.hasClass("choiceLR")){
		preObj.addClass("choiceLR");
	}
	if(!nexObj.hasClass("choiceLR")){
		nexObj.addClass("choiceLR");
	}

	obj.removeClass("orther");
	obj.removeClass("choiceLR");

}