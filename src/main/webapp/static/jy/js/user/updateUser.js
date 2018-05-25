$(document).ready(function(){
	/*
	设值
	*/
	queryUserById();
	
	//姓名校验(字符不能为空和字符长度)
	//得到焦点的时候
	$(".name").focus(function(){
		var name=$(this).val();//获取文本框中的值
		var nameId=$(this).attr("id");//获取文本框的id属性值
		if($(".warns"+nameId)!=null){
			$(".warns"+nameId).remove();
		}
	});
	//失去焦点的时候
	$(".name").blur(function(){
		var name=$(this).val();//获取文本框中的值
		var nameId=$(this).attr("id");//获取文本框的id属性值
		//校验是否为空
		if(paramIsNull(name)==false){
			abscissaRed(nameId,"姓名不能为空！");
			return;
		}
		//校验是否在2到20个字符（包括2到20）
		if(betweenLength(name,2,20)==false){
			abscissaRed(nameId,"姓名字符要在2到20个之间(包括2和20)！");
			return;
		}
		//姓名正则表达式校验
		var pattern=/^[\u4e00-\u9fa5_a-zA-Z_]{2,20}$/; //只能输入中文或者字母，长度2到20.
		if(pattern.test(name)==false){
			abscissaRed(nameId,"姓名不合法(只能输入中文或者字母，长度2到20)！");
			return;
		}
		
	});
	//年龄校验
	$(".age").focus(function(){
		var age=$(this).val();
		var ageId=$(this).attr("id");
		if($(".warns"+ageId)!=null){
			$(".warns"+ageId).remove();
		}
	})
	$(".age").blur(function(){
		var age=$(this).val();
		var ageId=$(this).attr("id");
		if(paramIsNull(age)==false){
			abscissaRed(ageId,"年龄不能为空！");
			return;
		}
		if(betweenLength(age,1,3)==false){
			abscissaRed(ageId,"年龄字符长度要在1到3个之间(包括1和3)！");
			return;
		}
		//年龄正则表达式校验
		var pattern=/^\d{1,3}$/;
		if(pattern.test(age)==false){
			abscissaRed(ageId,"年龄不合法！");
			return;
		}
		if(age<=0 || age>150){
			abscissaRed(ageId,"年龄大小范围在1到150之间！");
			return;
		}
		$(".warns"+ageId).remove();
	});
	//邮箱校验
	$(".email").focus(function(){
		var email=$(this).val();
		var emailId=$(this).attr("id");
		if($(".warns"+emailId)!=null){
			$(".warns"+emailId).remove();
		}
	});
	$(".email").blur(function(){
		setTimeout(function(){
			var email=$(this).val();
			var emailId=$(this).attr("id");
			var pattern=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
			if(pattern.test(email)==false){
				abscissaRed(emailId,"邮箱不合法！");
				return;
			}
			$(".warns"+emailId).remove();
		},0);
	});
	//电话号码校验
	$(".phone").focus(function(){
		var phone=$(this).val();
		var phoneId=$(this).attr("id");
		if($(".warns"+phoneId)!=null){
			$(".warns"+phoneId).remove();
		}
	});
	$(".phone").blur(function(){
		var phone=$(this).val();
		var phoneId=$(this).attr("id");
		if(paramIsNull(phone)==false){
			abscissaRed(phoneId,"电话号码不能为空！");
			return;
		}
		if(fixedLength(phone,11)==false){
			abscissaRed(phoneId,"电话号码必须是11位！");
			return;
		}
		var pattern=/^1[34578]\d{9}$/;
		if(pattern.test(phone)==false){
			abscissaRed(phoneId,"电话号码不合法！");
			return;
		}
		$(".warns"+phoneId).remove();
	});
	//地址校验
	$(".address").blur(function(){
		var address=$(this).val();
		var addressId=$(this).attr("id");
		if($(".warns"+addressId)!=null){
			$(".warns"+addressId).remove();
		}
	});
	$(".address").blur(function(){
		var address=$(this).val();
		var addressId=$(this).attr("id");
		if(paramIsNull(address)==false){
			abscissaRed(addressId,"地址不能为空！");
			return;
		}
		if(maxLength(address,50)==false){
			abscissaRed(addressId,"地址字符不能大于50个字符！");
			return;
		}
		$(".warns"+addressId).remove();
	});
});
/*
点击保存按钮后进行form表单的提交
*/
function saveUser(){
	
	//姓名校验(字符不能为空和字符长度)
	//失去焦点的时候
	var name = $(".name").val();//获取文本框中的值
	var nameId = $(".name").attr("id");//获取文本框的id属性值
	//校验是否为空
	if(paramIsNull(name) == false){
		abscissaRed(nameId,"姓名不能为空！");
		return;
	}
	//校验是否在2到20个字符（包括2到20）
	if(betweenLength(name,2,20) == false){
		abscissaRed(nameId,"姓名字符要在2到20个之间(包括2和20)！");
		return;
	}
	//姓名正则表达式校验
	var pattern = /^[\u4e00-\u9fa5_a-zA-Z_]{2,20}$/; //只能输入中文或者字母，长度2到20.
	if(pattern.test(name) == false){
		abscissaRed(nameId,"姓名不合法(只能输入中文或者字母，长度2到20)！");
		return;
	}
	//年龄校验
	var age = $(".age").val();
	var ageId = $(".age").attr("id");
	if(paramIsNull(age) == false){
		abscissaRed(ageId,"年龄不能为空！");
		return;
	}
	if(betweenLength(age,1,3) == false){
		abscissaRed(ageId,"年龄字符长度要在1到3个之间(包括1和3)！");
		return;
	}
	//年龄正则表达式校验
	var pattern=/^\d{1,3}$/;
	if(pattern.test(age) == false){
		abscissaRed(ageId,"年龄不合法！");
		return;
	}
	if(age <= 0 || age > 150){
		abscissaRed(ageId,"年龄大小范围在1到150之间！");
		return;
	}
	//邮箱校验
	var email = $(".email").val();
	var emailId = $(".email").attr("id");
	var pattern = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
	if(pattern.test(email) == false){
		abscissaRed(emailId,"邮箱不合法！");
		return;
	}
	$(".warns"+emailId).remove();
	//手机号码校验
	var phone = $(".phone").val();
	var phoneId = $(".phone").attr("id");
	if(paramIsNull(phone) == false){
		abscissaRed(phoneId,"电话号码不能为空！");
		return;
	}
	if(fixedLength(phone,11) == false){
		abscissaRed(phoneId,"电话号码必须是11位！");
		return;
	}
	var pattern = /^1[34578]\d{9}$/;
	if(pattern.test(phone) == false){
		abscissaRed(phoneId,"电话号码不合法！");
		return;
	}
	//地址校验
	var address = $(".address").val();
	var addressId = $(".address").attr("id");
	if(paramIsNull(address) == false){
		abscissaRed(addressId,"地址不能为空！");
		return;
	}
	if(maxLength(address,50) == false){
		abscissaRed(addressId,"地址字符不能大于50个字符！");
		return;
	}
	//提交表单
	$.ajax({
		type:"post",
		url:$("#basePath").val() + "user/updateUser",
		data:$("#commentForm").serialize(),//提交整个form表单
		dataType:"json",
		success:function(data){
			if(data.code == '10000'){
				JRYPopup.Jalert("保存成功！");
			}else{
				JRYPopup.Jalert(data.message);
			}
		},
		error:function(){
			txtError("网络错误");
		}
	});
}

/**
 * ajax请求-设值
 	之前放在session里面，可以通过el表达式$来获取，现在没有放在session里面，所以不能通过el表达式$来获取了。
 	此处是通过ajax来进行获取数据，并将数据放在对应的控件中去。
 */
function queryUserById(){
	$.ajax({
		type:"post",
		url:$("#basePath").val() + "user/queryUserById",
		dataType:"json",
		success:function(data){
			if(data.code=10000){
				var userId=data.result.id;
				var userName=data.result.userName;
				var name=data.result.name;
				var sex=data.result.sex;
				var age=data.result.age;
				var email=data.result.email;
				var phone=data.result.phone;
				var address=data.result.address;
				//机构名称获取
				var orgName=data.result.orgName;
				$(".userId").val(userId);
				$(".name").val(name);
				$(".userName").val(userName);
				//0和1映射：男和女
				if(sex==0){
					$(".sex").val("0");
				}else{
					$(".sex").val("1"); 
				}
				$(".age").val(age);
				$(".email").val(email);
				$(".phone").val(phone);
				$(".address").val(address);
				$(".orgName").val(orgName);
			}
		},
		error:function(XMLHttpRequest,textStatus,errorThrown){
			
		}
	});
}
