var extend = function(d,c){
    for(var p in c){ d[p] = c[p]}
    return d;
}
function jy_creatList(){
	this.configs = {
			building:1,
			floor:1,
			classNo:1,
			dataList:[],
	}
}
jy_creatList.prototype={
	creats:function(configs){
		var jy_configs = extend(this.configs,configs);
		var jy_floorsDemo = ['一','二','三','四','五','六','七','八','九','十','十一','十二','十三','十四','十五','十六','十七','十八','十九','二十','二十一','二十二','二十三','二十四','二十五','二十六','二十七','二十八','二十九','三十'];
		for(var i=0;i<jy_configs.building;i++){
			var builddiv = document.createElement("div");
			builddiv.id="buildDom"+i;
			builddiv.className = "domClass";
			for(var j=0;j<jy_configs.floor;j++){
				var floordiv = document.createElement("div");
				floordiv.id="floorDom"+j;
				floordiv.className = "floorClass";
				builddiv.appendChild(floordiv);
				for(var z=0;z<jy_configs.classNo;z++){
					var classdiv = document.createElement("div");
					var divIdnum = i*jy_configs.floor*jy_configs.classNo+j*jy_configs.classNo+z;
					classdiv.id="classDom"+divIdnum;
					classdiv.className = "classClass";
					//生成框内数据
					var inputClass = document.createElement("div");inputClass.className = "inputClass";
					var spanClass = document.createElement("span");spanClass.innerHTML = "地点：";
					var inputs = document.createElement("span");inputs.className = "swicthinput";
					inputClass.appendChild(spanClass);inputClass.appendChild(inputs);
					
					var inputState = document.createElement("div");inputState.className = "inputState";
					var spanClass0 = document.createElement("span");spanClass0.innerHTML = "设备状态：";
					var spanClass1 = document.createElement("span");spanClass1.className = "swicthinput";
					inputState.appendChild(spanClass0);
					
					var openState = document.createElement("div");openState.className = "openState";
					var spanClass2 = document.createElement("span");spanClass2.innerHTML = "开关状态：";
					openState.appendChild(spanClass2);
					var switchStep = document.createElement("span");switchStep.className = "swicthinput";
//					var switchInside = document.createElement("div");inputClass.className = "isValid-scroll";
//					switchStep.appendChild(switchInside);
					openState.appendChild(switchStep);
					
					var btnState = document.createElement("div");btnState.className = "btnState";
					var spanClass3 = document.createElement("span");spanClass3.innerHTML = "受控状态：";
					var spanClass4 = document.createElement("span");spanClass4.className = "swicthinput";
					btnState.appendChild(spanClass3);btnState.appendChild(spanClass4);
					var btnDiv = document.createElement("div");btnDiv.className = "btnDiv clearfix";
					inputs.innerHTML = '--';spanClass1.innerHTML = "--";switchStep.innerHTML ="--";
					spanClass4.innerHTML ='--';

					inputs.innerHTML = '--';spanClass1.innerHTML = "--";switchStep.innerHTML ="--";
					spanClass4.innerHTML ='--';
					var btnHTML = '<div class="editBtn" name="" onclick="goEdit(this,'+divIdnum+')">编辑</div>\
						   <div class="shieldbtn" name="" style="background-color:rgba(0,0,0,.1)">设备</div>\
						   <div class="delectbtn" >清空</div>';
							btnDiv.innerHTML=btnHTML;
					
					for(var k=0;k<jy_configs.dataList.length;k++){
						if(jy_configs.dataList[k].listOrder!=null&&jy_configs.dataList[k].listOrder==divIdnum){
							if(jy_configs.dataList[k].address==''){
								inputs.innerHTML = '无';
							}
							else{
								inputs.innerHTML = jy_configs.dataList[k].address;
							}
								
							if(jy_configs.dataList[k].status==0)
								spanClass1.innerHTML = "未知";
							if(jy_configs.dataList[k].status==1){
								spanClass1.innerHTML = "在线";
								classdiv.style.backgroundColor = 'rgba(0,255,0,.2)';
							}	
							if(jy_configs.dataList[k].status==2){
								spanClass1.innerHTML = "离线";classdiv.style.backgroundColor = 'rgba(255,0,0,.2)';
							}
							inputState.appendChild(spanClass1);
							if(jy_configs.dataList[k].poweroff==1){
								switchStep.innerHTML = "<div class='isValid' name='"+jy_configs.dataList[k].id+"' onclick='changeSound(this)'><div class='isValid-scroll'>开</div></div>";
								
							}else{
								switchStep.innerHTML = "<div class='isValid current' name='"+jy_configs.dataList[k].id+"' onclick='changeSound(this)'><div class='isValid-scroll'>关</div></div>";
								if(jy_configs.dataList[k].status==1)
								classdiv.style.backgroundColor = 'rgba(0,0,0,.1)';
							}
							if(jy_configs.dataList[k].operationType==''){
								spanClass4.innerHTML = '无状态'
							}
							if(jy_configs.dataList[k].operationType==0){
								spanClass4.innerHTML = '未知'
							}
							if(jy_configs.dataList[k].operationType==1){
								spanClass4.innerHTML = '自动'
							}
							if(jy_configs.dataList[k].operationType==2){
								spanClass4.innerHTML = '手动-全部'
							}
							if(jy_configs.dataList[k].operationType==3){
								spanClass4.innerHTML = '手动-1G'
							}
							if(jy_configs.dataList[k].operationType==4){
								spanClass4.innerHTML = '手动-手动'
							}
							if(jy_configs.dataList[k].operationType==5){
								spanClass4.innerHTML = '手动-未选'
							}
							var btnHTML = '<div class="editBtn" name="'+jy_configs.dataList[k].id+'" onclick="goEdit(this,'+divIdnum+')">编辑</div>\
										   <div class="shieldbtn" name="'+jy_configs.dataList[k].id+'" onclick="editshield(this)">设备</div>\
										   <div class="delectbtn" name="'+jy_configs.dataList[k].id+'" onclick="delectshield(this,'+divIdnum+')">清空</div>';
							btnDiv.innerHTML=btnHTML;
						}else{
							
						}
					}
					classdiv.appendChild(inputClass);classdiv.appendChild(inputState);
					classdiv.appendChild(openState);classdiv.appendChild(btnState);
					classdiv.appendChild(btnDiv);
					floordiv.appendChild(classdiv);
					
					
				}
				var floorON = document.createElement("div");
				floorON.className = "floorON";
				floorON.innerHTML = jy_floorsDemo[j]+'楼';
				floordiv.appendChild(floorON);
			}
			
			
			var topclass = document.createElement("div");
			topclass.className = "topClass";
			topclass.innerHTML = "教室楼栋"+(i+1);
			builddiv.appendChild(topclass);
			document.getElementById('allDom').appendChild(builddiv);
		}
	}	
}