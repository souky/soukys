package test;

import com.jy.common.config.Global;
import com.jy.common.utils.https.HttpUtils;
import com.jy.common.utils.https.RequestPost;
import com.jy.common.utils.https.ResponsePost;

public class TestSession {

	public static void main(String[] args) {
		RequestPost requestPost = new RequestPost();
		requestPost.setAppid(Global.APPID);
		requestPost.setSecret(Global.SECRET);
		requestPost.setJs_code("071Cn9D51BmgBL18MDE51MQpD51Cn9Dg");
		requestPost.setGrant_type(Global.GRANT_TYPE);
		
		ResponsePost responsePost = HttpUtils.sendPost(Global.CODE_SESSION_URL + requestPost.toString());
		
		System.out.println(responsePost.getSession_key());
		System.out.println(responsePost.getOpenid());
	}
}
