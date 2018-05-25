//考后数据整理
var basepaths = $("#basePath").val();
$(function () {
    queryPackage(1, 10);

    $.ajax({
        url: basepaths + 'showExamListData',
        data: '',
        type: 'post',
        success: function (res) {
            var list = res.result;
            var html = '<option value="">请选择考试名称</option>';
            for (var i = 0; i < list.length; i++) {
                html += '<option value="' + list[i].id + '">' + list[i].examName + '</option>';
            }
            $("#examPlanId").html(html);
        }, error: function (res) {
            JRYPopup.Jalert("初始化查询条件失败");
        }
    });


    $("#examPlanId").change(function () {
        var examPlanId = $("#examPlanId").val();
        if (examPlanId == "" || examPlanId == null) {
            var html = '<option value="">全部场次</option>';
            $("#examNumberId").html(html);
            return;
        }
        var data = {examPlanId: examPlanId}
        $.ajax({
            url: basepaths + 'exsub/queryExsubs',
            data: data,
            type: 'post',
            success: function (res) {
                var list = res.result;
                var html = '<option value="">全部场次</option>';
                for (var i = 0; i < list.length; i++) {
                    html += '<option value="' + list[i].id + '">' + list[i].name + '</option>';
                }
                $("#examNumberId").html(html);
            }, error: function (res) {
                JRYPopup.Jalert("未查询到场次信息");
            }
        });
    });
})

function deletePackage(id) {
    var data = {id: id};
    $.ajax({
        url: basepaths + 'examAfterData/deletePackageInfo',
        data: data,
        type: 'post',
        success: function (res) {
            JRYPopup.Jalert("删除成功");
            queryPackage(1, 10);
        }, error: function (res) {
            JRYPopup.Jalert("网络错误");
        }
    });
}

function savePackage() {
    var examPlanId = $("#examPlanId").val();
    var examNumberId = $("#examNumberId").val();
    if (examPlanId == "") {
        JRYPopup.Jalert("请选择打包考试名称");
        return;
    }

    var data = $("#packForm").serialize();
    JRYPopup.Jloading("正在打包");
    $.ajax({
        url: basepaths + 'examAfterData/savePackageInfo',
        data: data,
        type: 'post',
        success: function (res) {
            if(res.code == 10000){
                JRYPopup.popupClose();
                queryPackage(1, 10);
            }else{
                JRYPopup.Jalert(res.message);
            }
        }, error: function (res) {
            JRYPopup.popupClose();
            JRYPopup.Jalert("网络错误");
        }
    });
}

function queryPackage(pageNums, pageSize) {
    if(isNaN(pageNums)){
        JRYPopup.Jalert("请输入正确的页码");
        return;
    }
    if(pageNums < 1){
        JRYPopup.Jalert("页码应从1开始");
        return;
    }
    var data = {pageNum: pageNums, pageSize: pageSize};
    $.post(basepaths + 'examAfterData/packageInfoPost', data, function (html) {
        $("#packageInfoList .packageTable").html(html);
        JRYTable.tableInit('packageInfo', '', 'choiceNum');
        var pageTotal = $("#pageCss").find(".pageTotal").val();
        JRYPage.pageInit('pageCss', pageNums, pageTotal, 11, changePageCheate);
    });
}

function downloadPackage(obj) {
    var id = $(obj).attr("data-url");
    //var path = $("#listen").val();
    //window.open(path+'/'+url);
    location.href = basepaths + "examAfterData/downloadPackage.do?id=" + id;
}

function changePageCheate(obj, pages) {
    var pageNums = 1;
    if (pages) {
        pageNums = pages;
    } else {
        pageNums = $(obj).text();
    }
    var pageTotal = $("#pageCss").find(".pageTotal").val();
    if (pageNums != '...') {
        pageNums = parseInt(pageNums);
        pageTotal = parseInt(pageTotal);
        if (pageNums > pageTotal) {
            JRYPopup.Jalert("输入的页码超出最大范围");
            return;
        }
        queryPackage(pageNums, pageSize);
    }

}

//上一页
function proPageCheate() {
    var pageNow = $("#pageCss").find(".pageNow").val();
    var pageNums = parseInt(pageNow) - 1;
    if (pageNums < 1) {
        return;
    } else {
        queryPackage(pageNums, pageSize);
    }
}

//下一页
function nextPageCheate() {
    var pageNow = $("#pageCss").find(".pageNow").val();
    var pageTotal = $("#pageCss").find(".pageTotal").val();
    var pageNums = parseInt(pageNow) + 1;
    if (pageNums > pageTotal) {
        return;
    } else {
        queryPackage(pageNums, pageSize);
    }
}