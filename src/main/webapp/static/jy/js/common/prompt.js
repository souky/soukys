//提示框全局js
$(function(){
	var html='<button type="button" id="tosatJ" class="btn btn-primary hide" data-toggle="modal" data-target=".bs-example-modal-sm">Small modal</button><div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel"><div class="modal-dialog modal-sm" role="document"><div class="modal-content"><div class="titleTosat ac" style="height:30px;line-height:30px;font-size:14px;font-weight:500;">提示</div><div id="textTosat" class="ac" style="min-height:100px;line-height:30px;padding:20px 20px;">提示内容</div></div></div></div>'
	if($("#tosatJ").length <= 0){
		$("body").append(html);
	}
})
//alert
function tosatAlert(text){
	$("#textTosat").html(text);
	$("#buttonJ").remove();
	$("#tosatJ").click();
}
//confirm
function tosatConfirm(text,eve,dataId){
	var html = '<div id="buttonJ" class="clearfix" style="margin-bottom:10px;"><div class="col-sm-6 ac"><div class="confirm btn btn-primary">确定</div></div><div class="col-sm-6 ac"><div class="cancel btn btn-default" onclick="cancel()">取消</div></div></div>';
	if($("#buttonJ").length <= 0){
		$("#textTosat").parent().append(html);
	}
	$("#textTosat").html(text);
	$("#buttonJ").find(".confirm").click(function(){
		if(dataId){
			eve(dataId);
		}else{
			eve();
		}
	})
	$("#tosatJ").click();
}

function cancel(){
	$("#tosatJ").click();
}