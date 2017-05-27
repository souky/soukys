<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
    <title>叔叔</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
    <meta name="author" content="Souky" />
    <meta name="copyright" content="Souky" />
    <meta name="keywords" content="Souky"/>
    <link rel="stylesheet" href="resources/css/base.css">
<style type="text/css">
#indexMain{width: 1200px;margin: auto;}
#indexMain .topPart{background: #f40;width: 100%;height: 200px;line-height: 200px;font-size: 30px;color: #fff;}
#indexMain .middlePart{width: 100%;margin-top: 20px;}
#indexMain .middlePart .leftPart{width: 200px;min-height: 400px;}
#indexMain .middlePart .leftPart .menuBox{width: 200px;}
#indexMain .middlePart .leftPart .menuBox .items{height: 50px;line-height: 50px;width: 100%;margin-top:2px;}
#indexMain .middlePart .leftPart .menuBox .items .leftIcon{width:10px;height: 50px;background: #c7c7c7;}
#indexMain .middlePart .leftPart .menuBox .items .textR{font-size: 18px;width: 100px;margin-left:10px;}

#indexMain .middlePart .rightPart{width: 1000px;min-height: 400px;}

</style>
</head>
<body>
	<div id="indexMain">
        <div class="topPart ac YH" data-say="">
            ${(testfreemarker)!}
        </div>
        <div class="middlePart clearfix">
            <div class="leftPart fl">
                <div class="menuBox">
                    <div class="items clearfix CP">
                        <div class="leftIcon fl"></div>
                        <div class="textR YH fl ac">测试单元1</div>
                    </div>
                    <div class="items clearfix CP">
                        <div class="leftIcon fl"></div>
                        <div class="textR YH fl ac">测试单元2</div>
                    </div>
                    <div class="items clearfix CP">
                        <div class="leftIcon fl"></div>
                        <div class="textR YH fl ac">测试单元3</div>
                    </div>
                </div>
            </div>
            <div class="rightPart fr">
                这是你的右边
            </div>
        </div>
       

    </div>
</body>


<script type="text/javascript" src="resources/js/jquery.min.js"></script>
<script>
	$(function(){
        $(".items").hover(
            function(){
                $(this).find(".leftIcon").css("background","#f40");
                $(this).find(".textR").animate({marginLeft:'20px'},200,"linear");
            },function(){
                $(this).find(".leftIcon").css("background","#c7c7c7");
                $(this).find(".textR").css("margin-left","10px");
        })

    })
</script>

</html>