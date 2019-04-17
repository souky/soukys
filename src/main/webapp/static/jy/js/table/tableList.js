$(function(){
	inputPlaceHolderInit();
})


var tables = new Vue({
  el: '#tables',
  data: {
	  query:{
		  reallyName:'',
		  phone:'',
	  },
	  tableData:[],
  },
  methods:{
	  loadData(){
		  postHttp("auditionform/queryAuditionForms",this.query,res=>{
			  console.log(res);
		  })
	  },
	  formatDate(row,value){
		  
	  }
  }
})

function queryAll(){
}

function inputPlaceHolderInit(){
    $("#autoCode .formData .items .fomatInput").each(function(){
        var placeholders = $(this).attr("placeholder");
        $(this).attr("placeholder",null);
        var html = '<div class="placeholder" data-click="0">'+placeholders+'</div>';
        $(this).parent().append(html);

        //复写placeholder属性
        $("#autoCode .formData .items .placeholder").click(function(){
            var clicks = $(this).attr("data-click");
            if (clicks == '0') {
                $(this).parent().find("input").focus();
                $(this).attr("data-click","1");
                $(this).css("color","#ca2450");
                $(this).animate(
                {
                    top:'-7px',
                    height:'15px',
                    lineHeight:'15px',
                    fontSize:'12px',
                    left:'1%'
                },
                200,
                'swing'
                );
            }
        });

        //复写焦点离开
        $(".formData .items .fomatInput").focusout(function(){
            
            var value = $(this).val();
            var objc = $(this).parent().find(".placeholder");
            
            if(value == ""){
                objc.attr("data-click","0");
                objc.css("color","#666");
                objc.animate(
                {
                    top:'0px',
                    height:'40px',
                    lineHeight:'40px',
                    fontSize:'16px',
                    left:'3%'
                },
                200,
                'swing'
                );
            }else{
                objc.css("color","#666");
            }
        });

        //复写焦点进入
        $("#autoCode .formData .items .fomatInput").focus(function(){
            
            $(this).parent().find(".placeholder").css("color","#ca2450");
            
        });


    })
}