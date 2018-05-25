$(function(){
	loadData()
});
var testData =[];
var building = '';
var floor = '';
var classNo = '';
function loadData(){
	$.ajax({
        async: false,
        url:"classroominfo/queryClassroomInfos",
        data:'',
        type:"POST",
        success: function(data){
           if(data.code=='10000'){
        	   if(data.result==''){
        		   $(".Jry_query").show();
        		   
        	   }else{
        		   $(".Jry_query").hide();
        		   
//        		   new jy_creatList().creats({
//       				building:data.result[0].buildingNo,
//       				floor:data.result[0].floorNo,
//       				classNo:data.result[0].classroomNo,
//       				dataList:data.result[0].devices
//       			});
        		   building = data.result[0].buildingNo;
        		   floor = data.result[0].floorNo;
        		   classNo = data.result[0].classroomNo;
        		   loadshield(building,floor,classNo);
        	   }
           }
        }

    });
}	
function loadshield(a,b,c){
	$("#allDom").html('');
	$.ajax({
        async: false,
        url:"device/queryDevicesByListOrder",
        data:'',
        type:"POST",
        success: function(data){
           if(data.code=='10000'){
        	   new jy_creatList().creats({
  				building:a,
  				floor:b,
  				classNo:c,
  				dataList:data.result.devices
  			});
        	  
           }
        }

    });
}	
	
	
	
	function changeSound(e){
		var id=$(e).attr('name');
		if($(e).hasClass('current')){
 			var poweroff=1;
		    $.ajax({
	            type:"POST",
	            url:"device/updateShieldPoweroff",
	            data:{id:id,poweroff:poweroff},
	            success:function(data){
	                if(data.code=='10000'){
	                	$(e).toggleClass('current');
	        		    $(e).find(".isValid-scroll").html("开");
	        		    if($(e).parents(".openState").prev().find(".swicthinput").text()=="在线")
	        		    $(e).parents(".classClass").css("background-color",'rgba(0,255,0,.2)');
	                 }else{
	                    JRYPopup.Jalert(data.message)
	                 }
	            },
	            error:function(){
	                JRYPopup.Jalert("修改失败！");
	            }
	        })
		   
 		}else{
 			var poweroff=2;
 			$.ajax({
	            type:"POST",
	            url:"device/updateShieldPoweroff",
	            data:{id:id,poweroff:poweroff},
	            success:function(data){
	                if(data.code=='10000'){
	                	$(e).toggleClass('current');
	        		    $(e).find(".isValid-scroll").html("关");                     
	        		    $(e).parents(".classClass").css("background-color",'rgba(0,0,0,.1)');
	                 }else{
	                    JRYPopup.Jalert(data.message)
	                 }
	            },
	            error:function(){
	                JRYPopup.Jalert("修改失败！");
	            }
	        })
 			
		}
		
	}
	function editshield(e){
		var id=$(e).attr('name');
		$("#hiddenId").val(id);
	    $.ajax({
	        async: false,
	        url:"device/queryDeviceById",
	        data:{"id":id},
	        type:"POST",
	        success: function(data){
	            if(data.result!=null){
	                if(data.result.controlled==1){
	                    $("#autoRadio_JRY").attr("checked","checked");
	                    disableModule();
	                }else{
	                    enableModule();
	                    $("#autoRadio_JRY").attr("checked",false);
	                    $("#manualRedio_JRY").attr("checked","checked");
	                }

	                if(data.result.operationType==2){
	                    $("#1g_JRY").attr("checked","checked");
	                    $("#phone_JRY").attr("checked","checked");
	                }else if(data.result.operationType==3){
	                    $("#1g_JRY").attr("checked","checked");
	                    $("#phone_JRY").removeAttr("checked");
	                }else if(data.result.operationType==4){
	                    $("#phone_JRY").attr("checked","checked");
	                    $("#1g_JRY").removeAttr("checked");
	                }else if(data.result.operationType==5){
	                    $("#phone_JRY").removeAttr("checked");
	                    $("#1g_JRY").removeAttr("checked");
	                }
	            }
	        }

	    } );
	    JRYPopup.Jcustom("bootDiv");
	    $("#bootTitle").text("编辑设备信息");
	 }
	 function disableModule(){
		 $(".moduleInput").prop("checked",false);//从手动转为自动时,取消全选
	     $(".moduleInput").prop("disabled",true);
	 }
	 function enableModule(){
	     $(".moduleInput").prop("disabled",false);
	 }
	 //取消弹出框
	 function CancelPop(){
	     JRYPopup.popupClose();
	 }
	function startAll(){
		$.ajax({
            type:"POST",
            url:"classroominfo/saveClassroomInfo",
            data:{
            	buildingNo:$("#buildingSelect").val(),
            	floorNo:$("#floorSelect").val(),
            	classroomNo:$("#classSelect").val()
            },
            success:function(data){
            	
            },
            error:function(){
               
            }
        });
		   building = $("#buildingSelect").val();
		   floor = $("#floorSelect").val();
		   classNo = $("#classSelect").val();
			document.getElementById("allDom").innerHTML='';
			new jy_creatList().creats({
				building:$("#buildingSelect").val(),
				floor:$("#floorSelect").val(),
				classNo:$("#classSelect").val(),
				dataList:testData
			});
	}
	//必填信息验证
	function validateEditForm(){
	    $("#editFormShield").find("font").remove();
	    var flag=true;
	    var inputs=$(".required");
	    inputs.each(function(){
	        if(this.value==''){
	            abscissaRed(this.id,"&nbsp必填");
	            flag=false;

	        }
	    });

	    //ip地址校验
	    var ipVal=$("#ip").val();
	    var re =  /^([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])$/;
	    if(ipVal!=""&&!re.test(ipVal)){
	        //$("#ip").after("<p class='validateMsg' style='color:red'> ip地址格式不正确，请修改</p>");
	        abscissaRed('ip',"&nbspip地址格式不正确，请修改");
	        flag=false;
	    }

	    return flag;
	}
	//弹出编辑窗口
	function goEdit(e,ids){
	    JRYPopup.Jcustom("editDiv");
	    //clearEditForm();
	    $("#titleId").text("编辑");
	    $("#editBtn").attr("onclick","edit()");
	    var id=$(e).attr('name');
	    $("#listOrder").val(ids);
	    $.ajax({
            type:"POST",
            url:"device/queryIPs",
            data:"",
            success:function(data){
            	var options = '';
                for(var a=0;a<data.result.length;a++){
                	options+='<option value="'+data.result[a]+'">'+data.result[a]+'</option>'
                }
                $("#ip").append(options);
            },
            error:function(){
               
            }
        });
	    if(id==''){
	    	$("#ip").attr("disabled",false);
	    }else{
	    	$.get("device/queryDeviceById.do?id="+id,function(data){
		        var device =data.result;
		        $("#ip").attr("disabled",false);
		        $("#id").val(device.id);
		        $("#ip").append('<option value="'+device.ip+'">'+device.ip+'</option>');
		        $("#ip").val(device.ip);
		        $("#address").val(device.address);
		    });
	    }
	    
	    

	}
	//修改
	function edit(){
	    if(validateEditForm()){
	    	var datas = {
	    			ip:$("#ip").val(),
	    			address:$("#address").val(),
	    			listOrder:$("#listOrder").val()
	    	}
	        $.ajax({
	            type:"POST",
	            url:"device/updateShieldListOrder",
	            data:datas,
	            success:function(data){
	                if(data.code=='10000'){
	                    CancelPop();
	                    loadshield(building,floor,classNo);
	                    JRYPopup.Jalert("修改成功！")
	                 }else{
	                    JRYPopup.Jalert(data.message)
	                 }
	            },
	            error:function(){
	                JRYPopup.Jalert("修改失败！");
	            }
	        })
	    }

	}
	function delectshield(e,num){
		var ids = $(e).attr('name');
		JRYPopup.Jconfim('确定要删除已选择的数据吗？', function(){
			$.ajax({
	            type:"POST",
	            url:"device/deleteDevice",
	            data:{id:ids},
	            success:function(data){
	                if(data.code=='10000'){
	                	$(e).parents(".classClass").css("background-color","#fff");
	    				$(e).parents(".classClass").find(".swicthinput").text("--");
	    				loadshield(building,floor,classNo);
	    				JRYPopup.Jalert("清空成功！")
	                 }else{
	                    JRYPopup.Jalert(data.message)
	                 }
	            },
	            error:function(){
	                JRYPopup.Jalert("修改失败！");
	            }
	        })
		});
		
	}
	
	function doBoot(){
	    $.ajax({
	        type:"POST",
	        url:"device/bootDevice",
	        data:$("#bootForm").serialize(),
	        success:function(data){
	            if(data.code == '10000'){
	                CancelPop();
	                loadData(1);
	            }else{
	                JRYPopup.Jalert(data.message);
	            }
	        },
	        error:function(){
	            JRYPopup.Jalert("网络错误");
	        }
	    })

	}