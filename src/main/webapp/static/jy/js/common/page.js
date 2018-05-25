$(function () {
    if ($("#pageTable").length > 0) {
        console.log($("#pageTable").attr("url"));

        $.post($("#basePath").val() + $("#pageTable").attr("url"),
            {
                pageNum: 1,
                pageSize: 10
            },
            function (data) {
                console.log(data);
            });
        $("#pageTable tr:eq(0) td").each(function () {-
            console.log(this);
        });
    }
    //添加一些数据
    for (var num = 1; num <= 98; num++) {
        $('table tbody').append("<tr class='hidden'><td>" + num + "</td><td>Nancy</td><td>12345678</td><td>苏州</td>");
    }
    //分页,第一个参数为每页显示的记录数，第二个参数为总共的页数
    var countNum = $('div.footer .input-group:first-of-type input').val();
    var countAll = 98;
    //初始化页面
    //初始化分页按钮
    btnInitial(countNum, countAll);
    //显示第一页
    displayPage(1, countNum);

    //上一页
    $('div.footer .pagination li:first-child').on('click', function () {
        var currentPage = parseInt($('div.footer .pagination li.active a').text());
        countNum = $('div.footer .input-group:first-of-type input').val();
        $('div.footer .pagination li:nth-child(' + currentPage + ')').addClass('active').siblings('li').removeClass('active');
        displayPage((currentPage - 1), countNum);

        //如果当前按钮为第三显示的按钮，并且前面还有按钮，则多显示一个按钮
        var visibleIndex = $('div.footer .pagination li.active').index('div.footer .pagination li:not(li.hidden)');
        var curIndex = 0;
        var allVisible = 0;
        if (visibleIndex == 3) {
            curIndex = $('div.footer .pagination li.active').index();
            $('div.footer .pagination li:nth-child(' + (curIndex - 2) + ')').removeClass('hidden');
            allVisible = $('div.footer .pagination li:not(li.hidden):not(li[name=changePage])').length;
            if (allVisible > 10) {
                $('div.footer .pagination li:nth-child(' + (curIndex + 8) + ')').addClass('hidden');
            }
        }
    });

    //下一页
    $('div.footer .pagination li:last-child').on('click', function () {
        var currentPage = parseInt($('div.footer .pagination li.active a').text());
        countNum = $('div.footer .input-group:first-of-type input').val();
        $('div.footer .pagination li:nth-child(' + (currentPage + 2) + ')').addClass('active').siblings('li').removeClass('active');
        displayPage((currentPage + 1), countNum);

        //如果当前按钮为倒数第三显示的按钮，并且之后还有按钮，则多显示一个按钮
        var visibleIndex = $('div.footer .pagination li.active').index('div.footer .pagination li:not(li.hidden)');
        var curIndex = 0;
        var allVisible = 0;
        if (visibleIndex == 8) {
            curIndex = $('div.footer .pagination li.active').index();
            $('div.footer .pagination li:nth-child(' + (curIndex + 4) + ')').removeClass('hidden');
            allVisible = $('div.footer .pagination li:not(li.hidden):not(li[name=changePage])').length;
            if (allVisible > 10) {
                $('div.footer .pagination li:nth-child(' + (curIndex - 6) + ')').addClass('hidden');
            }
        }
    });

    //选择当前每页的条数
    $('div.footer .input-group:first-of-type .dropdown-menu li a').on('click', function () {
        var countNum = $(this).text();
        $('div.footer .input-group:first-of-type input').val(countNum);
        btnInitial(countNum, countAll);
        displayPage(1, countNum);
    });
});

//初始化分页按钮
function btnInitial(countNum, countAll) {
    $('div.footer .pagination li:not(li[name=changePage])').remove();
    $('div.footer .input-group:last-of-type .dropdown-menu li').remove();
    var btnNum = Math.ceil(countAll / countNum);
    for (var num = 1; num <= btnNum; num++) {
        if (num <= 10) {
            $('div.footer .pagination li:last-child').before("<li><a href='#'>" + num + "</a></li>");
        } else {
            $('div.footer .pagination li:last-child').before("<li class='hidden'><a href='#'>" + num + "</a></li>");
        }
        $('div.footer .input-group:last-of-type .dropdown-menu').append("<li><a href='#'>" + num + "</a></li>");
    }
    $('div.footer .pagination li:nth-child(2)').addClass('active');
    $('div.footer .input-group:last-of-type input').val(1);

    //显示特定的某一页
    //下拉框里面选择
    $('div.footer .input-group:last-of-type .dropdown-menu li a').on('click', function () {
        displayPageInList(this);
    });
    //分页按钮里面选择
    $('div.footer .pagination li:not(li[name=changePage])').on('click', function () {
        displayCurrent(this);
    });
}

//显示当前页的内容
function displayPage(currentPage, countNum) {
    var startRow = (currentPage - 1) * countNum + 1;
    var endRow = currentPage * countNum;
    var pageNum = $('div.footer .pagination li').length - 2;

    $('div.footer .input-group:last-of-type input').val(currentPage);

    $('table tbody tr').addClass('hidden');
    for (var num = startRow; num <= endRow; num++) {
        $('table tbody tr:nth-child(' + num + ')').removeClass('hidden');
    }
    if (currentPage == 1) {
        $('div.footer .pagination li:first-child').addClass('disabled');
        $('div.footer .pagination li:last-child').removeClass('disabled');

    } else if (currentPage == pageNum) {
        $('div.footer .pagination li:first-child').removeClass('disabled');
        $('div.footer .pagination li:last-child').addClass('disabled');
    } else {
        $('div.footer .pagination li:first-child').removeClass('disabled');
        $('div.footer .pagination li:last-child').removeClass('disabled');
    }
}

//显示当前页 分页按钮选择
function displayCurrent(that) {
    var countNum = $('div.footer .input-group:first-of-type input').val();
    $(that).addClass('active').siblings('li').removeClass('active');
    displayPage($(that).children('a').text(), countNum);
    changeDisplayBtn();
}

//显示当前页 下拉框选择
function displayPageInList(that) {
    var pageNum = parseInt($(that).text());
    var countNum = $('div.footer .input-group:first-of-type input').val();
    $('div.footer .input-group:last-of-type input').val(pageNum);
    $('div.footer .pagination li:nth-child(' + (pageNum + 1) + ')').addClass('active').siblings('li').removeClass('active');
    displayPage(pageNum, countNum);
    changeDisplayBtn();
}
function changeDisplayBtn() {
    var allIndex = $('div.footer .pagination li:not(li[name=changePage])').length;
    var curIndex = 0;
    var endIndex = 0;
    var startIndex = 0;
    if (allIndex <= 10) {
        return;
    } else {
        $('div.footer .pagination li.active').removeClass('hidden').siblings('li:not(li[name=changePage])').addClass('hidden');
    }
    curIndex = $('div.footer .pagination li.active').index();
    if (curIndex < 6) {
        $('div.footer .pagination li:lt(11)').removeClass('hidden');
    } else if (allIndex - curIndex < 4) {
        startIndex = allIndex - 9;
        $('div.footer .pagination li:gt(' + startIndex + ')').removeClass('hidden');
    } else {
        endIndex = curIndex + 5;
        startIndex = curIndex - 6;
        $('div.footer .pagination li:lt(' + endIndex + '):gt(' + startIndex + ')').removeClass('hidden');
    }
}
