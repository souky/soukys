//工具类---返回验证结束时间>开始时间--验证通过并返回相差时间
	function overDate(begin,over) {
		$(".clean").remove();
		var beginDate= $("#"+begin).val();
		var overDate=$("#"+over).val();
		var startDate = new Date(beginDate.replace(/-/g,"/")).getTime();
		var endDate = new Date(overDate.replace(/-/g,"/")).getTime();
		var days =(endDate-startDate)/(1000 * 60 * 60 * 24);
		var hours = ((endDate-startDate)/(1000 * 60 * 60))%24;
		var mins = (endDate-startDate)/(1000 * 60)%60;
		var seconds = (endDate-startDate)/1000%60;
		if(days<0){
			$("#"+over).val("");
			$("#"+over).after("<font class='clean' color='red'><b>结束日期应大于开始日期</b></font>")
		}else if(days==0){
			$("#"+over).val("");
			$("#"+over).after("<font class='clean' color='red'><b>请选择不同日期</b></font>")
		}else{
			return days+"天"+hours+"时"+mins+"分"+seconds+"秒";
		}
	}
	//工具类-----横标提示（红色）----(id:需要显示的id，str：需要显示的提示文字)
	function abscissaRed(id,str){
		$(".warns"+id).remove();
		var a=$("#"+id).after("<font class='warns"+id+"' color='red'><b>"+str+"</b></font>");
	}
	//工具类-----横标提示（绿色）----(id:需要显示的id，str：需要显示的提示文字)
	function abscissaGreen(id,str){
		$(".warns"+id).remove();
		var a=$("#"+id).after("<font class='warns"+id+"' color='green'><b>"+str+"</b></font>");
	}
	//工具类----下标提示（红色）----(id:需要显示的id，str：需要显示的提示文字)
	function subscriptRed(id,str){
		$(".warns"+id).remove();
		var a=$("#"+id).after("<br><font class='warns"+id+"' color='red'><b>"+str+"</b></font>");
	}
	//工具类----下标提示（绿色）----(id:需要显示的id，str：需要显示的提示文字)
	function subscriptGreen(id,str){
		$(".warns"+id).remove();
		var a=$("#"+id).after("<br><font class='warns"+id+"' color='green'><b>"+str+"</b></font>");
	}
	//工具类----电话号码验证
	function telValidate(id){
		var tel=$("#"+id).val();
		if(""==tel){
			abscissaRed(""+id,"请输入手机号");
		}else{
			if(!(/^1[34578]\d{9}$/.test(tel))){
				abscissaRed(""+id,"手机号码有误，请重填");
			}else{
				abscissaGreen(""+id,"格式输入正确");
			}
		}
	}
	
	//电话实时验证(方法放在onkeyup里)
	  function telValidates(id) { 
		  var tt=$("#"+id).val();
			$("#"+id).val(tt.replace(/\D/g,""));
			var tel=$("#"+id).val();
			if(""==tel){
				abscissaRed(""+id,"请输入手机号");
			}else{
				if(!(/^1[34578]\d{9}$/.test(tel))){
					abscissaRed(""+id,"手机号码有误，请重填");
				}else{
					abscissaGreen(""+id,"格式输入正确");
				}
			}
     }    
	
	//1. 邮箱校验不能为空，格式正确
	//使用此方法校验邮箱时，标签中得有一个class属性值为email。
	function checkEmail(){
		//将原来的移除掉
		$(".emailMess").remove();
		var htmls="";
		//判断不能为空
		if($(".email").val()=="")
		  {
			htmls+="<div class='emailMess' style='color:red;'>邮箱不能为空</div>";
		   	$(htmls).insertAfter(".email");
		   	return false;
		  }
		  var email=$(".email").val();
		  //校验格式是否正确
		  if(!email.match(/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/))
		  {
		   	htmls+="<span class='emailMess' style='color:red;'>邮箱格式不正确</span>";
		   	$(htmls).insertAfter(".email");
		   	return false;
		  }
	}

	/**
	 *校验字符长度 
	 */
	//(1)固定长度校验
	//param:被校验的值；fixedLength:固定的字符长度。
	function fixedLength(param,fixedLength){
		if(param.length!=fixedLength){
			return false;
		}
	}
	//(2)最大长度校验
	//param:被校验的值；maxLength:字符最大长度。
	function maxLength(param,maxLength){
		if(param.length>maxLength){
			return false;
		}
	}
	//(3)介于最小值和最大值之间（包含最大值和最小值）
	//param:被校验的值；minLength:字符最小长度；maxLength:字符最大长度。
	function betweenLength(param,minLength,maxLength){
		if(param.length<minLength || param.length>maxLength){
			return false;
		}
	} 
	
	/**
	 * 校验是否为空
	 */
	function paramIsNull(param){
		if(param=="" || param==null){
			return false;
		}
	}
	
	//3.字符类型校验（纯数字和纯字母）
	//纯字母校验：utils.regRule.pureLetter("被校验的值")
	//纯数字校验：utils.regRule.pureDigital("被校验的值")
	//如果校验不通过就会返回false
	;
	(function(window, document, $) {
		  window.utils = {
			regRule: {
				pureLetter:function(str){
					var reg=/^[A-Za-z]+$/;
					return reg.test(str);
				},
				pureDigital:function(str){
					var reg=/^[0-9]*$/;
					return reg.test(str);
				}
			}    
		}
	})(window, document, $);
	//纯数字校验
	//标签中得有一个class属性值为pureDigital
	function pureDigital(){
		var result=true;
		result=utils.regRule.pureDigital($(".pureDigital").val());
		if(result==false){
			alert("你输入的不是纯数字");
			return false;
		}
	}
	//纯字母校验
	//标签中得有一个class属性值为pureLetter
	function pureLetter(){
		var result=true;
		result=utils.regRule.pureLetter($(".pureLetter").val());
		if(result==false){
			alert("你输入的不是纯字母");
			return false;
		}
	}

	//4. 弹出框校验
	//(1)提示框
	//txt:提示信息
	function txtInfo(txt){
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
	}
	//(2)确认框
	//txt:提示信息
	function txtConfirm(txt){
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.confirm);
	}
	//(3)警告框
	//txt:提示信息
	function txtWarning(txt){
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.warning);
	}
	//(4)错误框
	//txt:提示信息
	function txtError(txt){
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.error);
	}
	//(5)成功框
	//txt:提示信息
	function txtSuccess(txt){
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.success);
	}
	//(6)输入框
	//txt:提示信息
	function txtInput(txt){
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.input,{
			onOk:function(v){
				console.log(v);
			}
		});
	}
	//(7)自定义框
	//definedTxt:自定义内容；definedTitle：自定义标题。
	function definedTxtAndTitle(definedTxt,definedTitle){
		var txt=  definedTxt;
		var option = {
			title: definedTitle,
			btn: parseInt("0011",2),
			onOk: function(){
				console.log("确认啦");
			}
		}
		window.wxc.xcConfirm(txt, "custom", option);
	}

	//(8)默认框
	//txt:提示信息
	function defaultBox(txt){
		window.wxc.xcConfirm(txt);
	}

	  
	  
	  
	//弹出框----str:显示文字;funA、funB:调用的方法
    function selectFun(str,funA,funB){
		 if(confirm(str)){
			 funA();
		 }else{
			 funB();
		 }
	}
    