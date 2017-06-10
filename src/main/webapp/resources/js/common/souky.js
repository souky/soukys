$(function(){
	initNavImg();
})

function initNavImg(){
	//图片加载
	$("nav img").each(function(){
		var src = "resources/img/mobile/"+$(this).attr("class")+".png";
		$(this).attr("src",src);
		$(this).attr("width","100%");
	})
}