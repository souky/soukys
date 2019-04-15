var JRYTable = {
    version : '1.0.0',
    $ : window.jQuery
};

//table表单
JRYTable = (function($){
	//定义模板
    TEMPLATE = {
        title : '<tr><td><input type="checkbox" class="" data-select="0"></td><td>全选</td><td class="counts"></td><td onclick="typeJRY()"><div><div class="imgDelete"><img src="img/delete.png"></div><div class="textDelete">删除</div></div></td></tr>'
    }
    /*
		table表初始化参数说明：
		id:要绑定初始化的容器
		type:删除选中方法
		names:全选checkbox的name属性值
		
	*/
	var tableInit = function(id,type,names){
		var counts = $("#"+id).find("tr").first().find("th").length - 3;
    	//$("#"+id).find('table').prepend(TEMPLATE['title'].replace('typeJRY',type));
    	//$("#"+id).find(".counts").attr("colspan",counts);
    	$("#"+id).find(".selectAll").click(function(){
    		var dataSelect = $(this).prop("checked");
    		if(dataSelect){
    			$("input[name='"+names+"']").prop("checked",true);
    			
    			$("input[name='"+names+"']").parent().parent().addClass("checked_back");
    			
    		}else{
    			$("input[name='"+names+"']").prop("checked",false);
    			
    			$("input[name='"+names+"']").parent().parent().removeClass("checked_back");
    			
    		}

    	})
    	$("input[name='"+names+"']").click(function(){
    		var flag = $(this).prop("checked");
    		if(flag){
    			$(this).parent().parent().addClass("checked_back");
    		}else{
    			$(this).parent().parent().removeClass("checked_back");
    		}
    	})
    	$("#"+id).find(".delet_btn").attr("onclick",type+"()");
	}
   
    return {
        tableInit : tableInit
    }
})(JRYTable.$);

var JRYPage = {
    version : '1.0.0',
    $ : window.jQuery
};

//分页插件
JRYPage = (function($){
	/*
		分页初始化参数说明：
		id:要绑定初始化的容器
		pagenow:当前页数
		pagetotal:总页数
		pageshow:分页插件显示的页码数量
		fn_nums:跳转页方法
	*/
	var pageInit = function pageInit(id,pagenow,pagetotal,pageshow,fn_nums){
		var pageObj = $("#"+id);
		//input 绑定onkeyup
		pageObj.find("input").keyup(function(){
			var regNum = /[^\d]/;
			var inputValue = $(this).val();
			if(regNum.test(inputValue)){
				inputValue = inputValue.replace(regNum,''); 
			}
			$(this).val(inputValue);
		});
		refrshPage(id,pagenow,pagetotal,pageshow,fn_nums);

		//绑定方法
		pageObj.find(".jump_button").click(function(){
			var pages = pageObj.find(".jump_page input").val();
			fn_nums(this,pages)
		});

	}

	/*
		分页初始化后跳转页数的刷新方法
	*/
	var refrshPage = function refrshPage(id,pagenow,pagetotal,pageshow,fn_nums){
		//刷新页数
		var html = '';
		var pagehalf = (parseInt(pageshow)+1)/2;
		var pageoffset = pagehalf-2;

		if(pagenow > pagehalf  && (pagenow+pageoffset) < pagetotal ){
			//前后都有...
			html+='<div class="nums_page">...</div>';
			for(var i = (pagenow-pageoffset) ;i < pagenow;i++){
				html+='<div class="nums_page">'+i+'</div>';
			}
			html+='<div class="nums_page active">'+pagenow+'</div>'
			if((pagenow+pageoffset)==pagetotal ){
				for(var i = pagenow;i <= pagetotal;i++ ){
					html+='<div class="nums_page">'+i+'</div>';
				}
			}else{
				for(var i = pagenow+1 ;i <= (pagenow+pageoffset);i++){
					html+='<div class="nums_page">'+i+'</div>';
				}
			}
			html+='<div class="nums_page">...</div>';
			
		}
		if(pagenow <= pagehalf && pagetotal > pageshow){
			//后有...
			for(var i = 1;i<pageshow;i++){
				if(i==pagenow){
					html+='<div class="nums_page active">'+pagenow+'</div>';
				}else{
					html+='<div class="nums_page">'+i+'</div>';
				}
			}
			html+='<div class="nums_page">...</div>';
			
		}
		if(pagetotal<=pageshow){
			//前后都没...
			for(var i = 1;i<=pagetotal;i++){
				if(i==pagenow){
					html+='<div class="nums_page active">'+pagenow+'</div>';
				}else{
					html+='<div class="nums_page">'+i+'</div>';
				}
			}
		}
		if(pagenow+pageoffset+1 > pagetotal && pagetotal > pageshow){
			//前有...
			html+='<div class="nums_page">...</div>';
			for(var i = (pagenow - (pageshow - 2 - pagetotal+pagenow) );i<=pagetotal;i++){
				if(i==pagenow){
					html+='<div class="nums_page active">'+pagenow+'</div>';
				}else{
					html+='<div class="nums_page">'+i+'</div>';
				}
			}	
		}
		$("#"+id).find(".maps_page").html(html);
		$("#"+id).find(".nums_page").click(function(){
			
				fn_nums(this)
			
		});
		var width = $("#"+id).find(".nums_page").length * 25 + 350;
		$("#"+id).css("width",width+"px");
		

	}
   
    return {
        pageInit : pageInit,
        refrshPage :refrshPage
    }
})(JRYPage.$);

var JRYMenu = {
    version : '1.0.0',
    $ : window.jQuery
};

//菜单
JRYMenu = (function($){
    /*
		菜单初始化参数说明
		topheight:头部高度
		url:项目地址
		urlSecond:静态资源后缀地址
	*/
	var menuInit = function(topheight,url,urlSecond){
		//获取屏幕高度 初始化高度
		var height = document.body.clientHeight - topheight;
		$(".left_part_context").css("height",height+"px");
		$(".right_part_context").css("min-height",height+"px");
    	//绑定事件
    	$(".menu_level_one").click(function(){
    		var menuOne = $(this);
    		if(menuOne.parent().hasClass("active_menu")){
    			return;
    		}
    		$(".menu_level_one").parent().removeClass("active_menu");
    		menuOne.parent().addClass("active_menu");
    		$(".menu_level_two").slideUp(300);
    		var menuTwo = menuOne.parent().find(".menu_level_two");
    		menuTwo.slideDown(300);
    		//文件路径可能需要更改
    		
    		$(".menu_level_one").find(".showimg_level_one img").attr("src",url+urlSecond+"/downArrow.png");
    		
    		menuOne.find(".showimg_level_one img").attr("src",url+urlSecond+"/upArrow.png");
    	});
    	$(".items_level_two").click(function(){
    		var menuTwo = $(this);
    		if(menuTwo.hasClass("active_level_two")){
    			return;
    		}
    		$(".items_level_two").removeClass("active_level_two");
    		menuTwo.addClass("active_level_two");
    		$(".items_level_two").find(".img_level_two img").attr("src",url+urlSecond+"/rightArrow.png");
    		menuTwo.find(".img_level_two img").attr("src",url+urlSecond+"/rightArrowLight.png");
    		
    		var urld = menuTwo.attr("data-url");
			var data = {url:urld};
			 $.post(url + "/gotoMenuJsp",data,function (html) {
			   $(".right_part_context").html(html);
			});
    		
    	})
	}
	
   
    return {
        menuInit : menuInit
    }
})(JRYMenu.$);


var JRYPopup = {
    version : '1.0.0',
    $ : window.jQuery
};

//弹出框
JRYPopup = (function($){
	
	//定义模板
    TEMPLATE = {
		Jalert : '<div class="Jalert"><div class="Jalert_text">TEXT_JRY</div><div class="Jalert_btn" onclick="JRYPopup.JalertClose()">确定</div></div>',
		Jconfim : '<div class="Jconfim"><div class="Jconfim_title">提　示</div><div class="Jconfim_text">TEXT_JRY</div><div class="Jconfim_btns"><div class="Jconfim_btns_btn Jconfim_btns_btn_ok">确定</div><div class="Jconfim_btns_btn Jconfim_btns_btn_cancle">取消</div></div></div>',
		Jcustom : '<div class="Jcustom"></div>',
		Jloading : '<div class="Jloading"><div class="loadingImg"><img src="static/jy/img/pcImg/loading.png"></div><div class="loadingText">TEXT_JRY</div></div>'
    }
	
    /*
		菜单初始化参数说明
	*/
	var popupInit = function(){
		//获取屏幕高度 初始化高度
		var height = document.body.scrollHeight;
		$(".Jry_popup").css("height",height+"px");
		$(".Jry_popup").attr("onclick","JRYPopup.popupClose()");
	}
    /*
		弹出框参数说明
	*/
	var Jalert = function(text){
		var width = document.body.scrollWidth;
		var widthOffer = (width-340)/2;
		
		var html = TEMPLATE['Jalert'].replace("TEXT_JRY",text);
		var Jpo = $(".Jry_popup").find(".Jcustom");
		if(Jpo.length>0){
			$(".Jry_popup").append(html);
			$(".Jalert").css("left",widthOffer+"px");
			$(".Jalert").fadeIn(200);
		}else{
			$(".Jry_popup").html(html);
			$(".Jalert").css("left",widthOffer+"px");
			popupShow();
			$(".Jalert").fadeIn(200);
		}
		$(".Jalert").mouseenter(function(){
			$(".Jry_popup").attr("onclick",null);
		})
		$(".Jalert").mouseleave(function(){
			$(".Jry_popup").attr("onclick","JRYPopup.popupClose()");
		})
	}
	var JalertClose = function(){
		var Jpo = $(".Jry_popup .Jcustom");
		if(Jpo.length>0){
			$(".Jalert").fadeOut(200);
		}else{
			$(".Jalert").fadeOut(200);
			setTimeout(function(){
				popupClose();
			},200);
		}
	}
	
	/*
		确认框参数说明
		text:内容
		eve:回调删除方法
		dataId:方法调用参数,可以为""
	*/
	var Jconfim = function(text,eve,dataId){
		var html = TEMPLATE['Jconfim'].replace("TEXT_JRY",text);
		$(".Jry_popup").html(html);
		$(".Jconfim_btns_btn_ok").click(function(){
			if(dataId){
				eve(dataId);
			}else{
				eve();
			}
		});
		$(".Jconfim_btns_btn_cancle").click(function(){
			popupClose();
		});
		popupShow();
		$(".Jconfim").mouseenter(function(){
			$(".Jry_popup").attr("onclick",null);
		})
		$(".Jconfim").mouseleave(function(){
			$(".Jry_popup").attr("onclick","JRYPopup.popupClose()");
		})
	}
	
	/*
		自定义框参数说明
		container:容器id
	*/
	var Jcustom = function(container,eve){
		var html = TEMPLATE['Jcustom'];
		$(".Jry_popup").html(html);
		var htmlInner = $("#"+container).html().replace(/_JRY/g,"");
		$(".Jry_popup .Jcustom").html(htmlInner);
		popupShow();
		$(".Jcustom").mouseenter(function(){
			$(".Jry_popup").attr("onclick",null);
		})
		$(".Jcustom").mouseleave(function(){
			$(".Jry_popup").attr("onclick","JRYPopup.popupClose()");
		})
		if(eve){
			eve();
		}
	}
	
	var Jloading = function(text){
		var html = TEMPLATE['Jloading'].replace("TEXT_JRY",text);
		$(".Jry_popup").html(html);
		var height = (document.body.scrollHeight - 120)/2;
		$(".Jry_popup .Jloading").css("margin-top",height+"px");
		$(".Jry_popup").attr("onclick",null);
		popupShow();
	}
	
	var popupClose = function(){
		$(".Jry_popup").hide();
		$(".Jry_popup").html("");
		$(".Jry_popup").attr("onclick","JRYPopup.popupClose()");
	}
	var popupShow = function(){
		$(".Jry_popup").show();
	}
	popupInit();
    return {
    	Jalert : Jalert,
    	JalertClose : JalertClose,
    	Jconfim : Jconfim,
    	Jcustom : Jcustom,
    	popupClose : popupClose,
    	Jloading : Jloading
    }
})(JRYPopup.$);





