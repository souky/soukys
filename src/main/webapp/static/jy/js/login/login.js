$(function() {
	cssInit();
	var message = $("#message").val();
	if (null != message && '' != message) {
		JRYPopup.Jalert(message);
		$("#message").val("");
		message = "";
	}
});

function cssInit() {
	var height = $(window).height();
	var top = (height - 400) / 2 + "px"
	$(".mainLogin").css("margin-top", top);
}

function login_in() {
	var username = $("#username").val();
	var password = $("#password").val();

	if (username == "") {
		JRYPopup.Jalert("请填写用户名");
		return;
	}

	if (password == "") {
		JRYPopup.Jalert("请填写密码");
		return;
	}

	$.ajax({
		url : $("#basePath").val() + "login",
		data : $("#loginForm").serialize(),
		type : 'post',
		success : function(res) {
			var code = res.code;
			if (code == '10000') {
				window.location.href = "main"
			} else {
				if (res.message == 'notOrg') {
					JRYPopup.Jcustom("addOrg");
					// 初始化省数据
					getProvince("000000", "province");
				} else {
					JRYPopup.Jalert(res.message);
				}
			}

		},
		error : function() {
			JRYPopup.Jalert("网络错误");
		}
	});

}

// 初始化省/市/区数据
function changeCity(code) {
	if (code != "") {
		getProvince(code, "city")
	} else {
		$('#city').empty();
		document.getElementById('city').options.add(new Option("--请选择--", ''));
		$('#area').empty();
		document.getElementById('area').options.add(new Option("--请选择--", ''));
	}
}

function changeArea(code) {
	if (code != "") {
		getProvince(code, "area")
	} else {
		$('#area').empty();
		document.getElementById('area').options.add(new Option("--请选择--", ''));
	}
}

// code父id,id为数据所存放容器id
function getProvince(code, id) {
	$.ajax({
		url : $("#basePath").val() + "region/queryRegions",
		data : {regionPId : code},
		type : 'post',
		dataType : "json",
		success : function(res) {
			var code = res.code;
			if (code == '10000') {
				var regions = res.result;
				var select = document.getElementById(id);
				$('#' + id).empty();
				select.options.add(new Option("--请选择--", ''));
				for (var i = 0; i < regions.length; i++) {
					select.options.add(new Option(regions[i].regionName,
							regions[i].regionCode));
				}
			} else {
				JRYPopup.Jalert("初始化数据失败");
			}
		},
		error : function() {
			JRYPopup.Jalert("网络错误");
		}
	});
}

function orgSave() {
//	var province = $('#province').val();
//	var city = $('#city').val();
//	var area = $('#area').val();
	var isExamSpot = $("input[type='radio']:checked").val();
	var orgName = $('#orgName').val();
	var orgIP = $('#orgIP').val();
	if (tipMessage('province')) {
		return;
	}
	if(isExamSpot != "Y" && isExamSpot != "N")  {
		$('#isExamSpot').parent().find(".error_text").html('请选择当前是否为考点');
		$('#isExamSpot').focus(
				function() {
					$('#isExamSpot').parent().find(".error_text").html("");
					$('#isExamSpot').closest(".Jcustom_content_items").removeClass("haserror");
				});
		return;
	}
	
	if("Y" == isExamSpot){
		if (tipMessage('city')) {
			return;
		}
		if (tipMessage('area')) {
			return;
		}
		if (tipMessage('orgName')) {
			return;
		}
		if (tipMessage('orgIP')) {
			return;
		}
		
		//判断是否为中文
		var reg = new RegExp("[\\u4E00-\\u9FFF]+","g");
		if(!reg.test(orgName)){
			$('#orgName').parent().find(".error_text").html('只能输入汉字');
			$('#orgName').focus(
					function() {
						$('#orgName').parent().find(".error_text").html("");
						$('#orgName').closest(".Jcustom_content_items").removeClass("haserror");
					});
			return;
		}
		//正则校验orgIP
		if(!isValidIP(orgIP)){
			$('#orgIP').parent().find(".error_text").html('ip不合法,请重新输入');
			$('#orgIP').focus(
					function() {
						$('#orgIP').parent().find(".error_text").html("");
						$('#orgIP').closest(".Jcustom_content_items").removeClass("haserror");
					});
			return;
		}
	}
	
	var data = $(".saveAndEdit").serialize();
	console.log($("#basePath").val() + "systemconfig/insertOrgConfig");
	$.ajax({
		url : $("#basePath").val() + "systemconfig/insertOrgConfig",
		data : data,
		type : 'post',
		dataType : "json",
		success : function(res) {
			if (res.code == '10000') {
				
				window.location.href = "main";
			} else {
				JRYPopup.Jalert("初始化省数据失败");
			}
		},
		error : function() {
			JRYPopup.Jalert("网络错误");
		}
	});
	
}

function isValidIP(ip) {
    var reg = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
    return reg.test(ip);
}

function tipMessage(id) {
	var text = $('#' + id).val();
	if(text == ''){
		$("#" + id).closest(".Jcustom_content_items").addClass("haserror");
		var message = "";
		if(id == "province"){
			message = "请选择省市";
		}
		if(id == "city"){
			message = "请选择城市";
		}
		if(id == "area"){
			message = "请选择区县";
		}
		if(id == "orgName"){
			message = "组织机构名称不能为空";
		}
		if(id == "orgIP"){
			message = "组织机构ip不能为空";
		}
		$("#" + id).parent().find(".error_text").html(message);
		$("#" + id).focus(
				function() {
					$("#" + id).parent().find(".error_text").html("");
					$("#" + id).closest(".Jcustom_content_items").removeClass("haserror");
				});
		return true;
	}else{
		return false;
	}
}

function orgCancel() {
	JRYPopup.popupClose();
}