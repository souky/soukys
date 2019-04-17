axios.defaults.headers.post['Content-Type'] = 'application/json;charset=UTF-8';
//后台基础地址
var baseUrl = "http://localhost:8888/audition/";

function postHttp(address,data,fn){
	axios.post(baseUrl+address,data).then(response => {
  			fn(response.data);
	})
}
