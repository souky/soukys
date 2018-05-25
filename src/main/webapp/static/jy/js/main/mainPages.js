$(function(){
	var basePath = $("#basePath").val();
	//菜单拉取
	$.post(basePath+"/mainMenuNew",'basePath='+basePath,function(html){
		$(".left_part_context").html(html);
		JRYMenu.menuInit(60,basePath,"/static/jy/img/pcImg");
	})
	var urld = "statistics/statisticsAnalysis";
	var data = {url:urld};
	$.post(basePath + "/gotoMenuJsp",data,function (html) {
	   JRYPopup.Jloading("正在载入");
	   $(".right_part_context").html(html);
	   var htmls = '<div class="queryshows" data-cli="0"><img src="'+basePath+'static/jy/img/pcImg/searchMain.png"></div>';
	   $(".Jry_query").append(htmls);
	   $(".query_part").hide();
	   queryInits(basePath);
	   JRYPopup.popupClose();
	});
	
	$(".goToMain").hover(function(){
		 $(this).html("返回大屏");
	 },function(){
		 $(this).html(">");
	 })
	
})

function queryInits(basePath){
	$(".Jry_query").addClass("indexQuery");
	$(".queryshows").click(function(){
		var cli = $(this).attr("data-cli");
		if(cli=="0"){
			$(this).animate({left:'68%'},400);
			$(".query_part").fadeIn(500);
			$(this).find("img").attr("src",basePath+"static/jy/img/pcImg/closeMain.png");
			$(this).attr("data-cli","1");
		}else{
			$(this).animate({left:'50%'},400);
			$(".query_part").fadeOut(500);
			$(this).find("img").attr("src",basePath+"static/jy/img/pcImg/searchMain.png");
			$(this).attr("data-cli","0");
		}
	});
}