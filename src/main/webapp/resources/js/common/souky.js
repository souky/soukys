$(function(){
	initNavImg();
	initAfterNav();
})

var Souky = S = {
    version : '1.0.0',
    $ : window.jQuery
};

function initNavImg(){
	//图片加载
	$("nav img").each(function(){
		var src = "resources/img/mobile/"+$(this).attr("class")+".png";
		$(this).attr("src",src);
		$(this).attr("width","100%");
	})
}

//初始化下方div高度
function initAfterNav(){
	var afterNav = $(".afterNav");
	if(afterNav.length>0){
		var clientHeight = window.screen.height-40;
		afterNav.css("min-height",clientHeight+"px");
	}
	
}

//全局消息提示
S.Toast = (function($){
	//定义模板
    TEMPLATE = {
        success : '<div class="toast success">TEXTS</div>',
        error : '<div class="toast error">TEXTS</div>',
        info : '<div class="toast info">TEXTS</div>'
    }
	var show = function(type,message,times){
    	var html = TEMPLATE[type];
		$("#S_Toast").html(html.replace('TEXTS',message)).fadeIn(300);
		if(times!="" && times!=0){
			setTimeout(function(){
				hide();
			},times);
		}
	}
    var hide = function(){
    	$("#S_Toast").fadeOut(300);
    }
    var initToast = function(){
    	$("body").append('<div id="S_Toast"></div>');
    }
    initToast();
    return {
        show : show,
        hide : hide
    }
})(S.$);


//loading框 
S.Loading = (function($){
	//定义模板
    TEMPLATE = {
        hasClose : '<div class="loading"><div class="close"><img src="resources/img/mobile/close.png" width="100%"/></div><div class="img_loading" id="loadingMove"><img src="resources/img/mobile/loading.png" width="100%"/></div><div class="text_loading">TEXTS</div></div>',
        noClose : '<div class="loading"><div class="close"></div><div class="img_loading" id="loadingMove"><img src="resources/img/mobile/loading.png" width="100%"/></div><div class="text_loading">TEXTS</div></div>'
    }
	var start = function(type,message){
    	var html = TEMPLATE[type].replace("TEXTS",message);
    	$("#S_Loading").html(html);
    	$("#S_Loading .close").click(function(){
    		close();
    	})
	}
    var close = function(){
    	$("#S_Loading").hide();
    	$("#S_Loading").html("");
    }
    var initLoding = function(){
    	$("body").append('<div id="S_Loading"></div>');
    	var clientHeight = window.screen.height;
    	$("#S_Loading").css("height",clientHeight+"px");
    }
    initLoding();
    return {
        start : start,
        close : close
    }
})(S.$);