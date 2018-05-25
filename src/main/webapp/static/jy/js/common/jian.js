//弹出提示框，并在3s后消失
	function disappearText(divId,str){
		$("#"+divId+" "+"strong").text(str);
		if(!$('#'+divId).is(':visible')){
			$('#'+divId).css({display:'block', top:'-10%'}).animate({top: '+30%'}, 500, function(){ 
	            setTimeout(function(){
	            	 $('#'+divId).animate({top:'0'}, 500, function(){ 
	                     $(this).css({display:'none', top:'-10%'}); 
	                 }); 
	            	 location.reload();
	            }, 3000); 
	        }); 
		}
	}

	$(function(){
		$("#updatePsSub").click(function(){
			$('.form-control').popover('destroy');
			$('#error2').remove();
			$('#error1').remove();
			if($("#oldPassWord").val()==""||$("#oldPassWord").val()==null||$("#newPassWord").val()==""||$("#newPassWord").val()==null||$("#newPassWords").val()==""||$("#newPassWords").val()==null){
				$("#sub").after("<span id='error2' style='color:red;'>请完善表单信息</span>");
			}else{
				$('#error4').remove();
				$('#error3').remove();
				var newPassWord=$("#newPassWord").val();
				var regExp=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,21}$/;
				if(newPassWord.length>5&&newPassWord.length<23&&!regExp.test(newPassWord)){
					if($("#newPassWord").val()==$("#newPassWords").val()){
						$("#updatePsSub").attr("disabled", "disabled");
						$.ajax({
			                cache: true,
			                type: "POST",
			                url:"updatePsw.do",
			                data:$("#myForm").serialize(),// 你的formid
			                async: true,
			                success : function(result) {
			                	if(result.code=="30000"){
			                		//原密码输入错误
			                		$('#oldPassWord').popover('show');
			                		$("#updatePsSub").attr("disabled", false);
			                	}else if(result.code=="10000"){
			                		//修改成功
			                		disappearText("noteAlert-success","密码修改成功 ");
			                	}else if(result.code=="60000"){
			                		//密码相同,请重新设置
			                		disappearText("noteAlert-warning","更改密码与原始密码相同，请重新设置");
			                	}else{
			                		//未知错误提示
			                		disappearText("noteAlert-warning","密码修改失败，请重新输入");
			                	}
	                           },
			            });
					}else{
						$('#newPassWords').popover('show');
					}
				}else{
					$('#newPassWord').popover('show');
				}
			}
		});
	});