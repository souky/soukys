package com.jy.moudles.login.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.config.Global;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.MD5Util;
import com.jy.common.utils.UserUtils;
import com.jy.common.utils.https.HttpUtils;
import com.jy.common.utils.https.RequestPost;
import com.jy.common.utils.https.ResponsePost;
import com.jy.moudles.login.VO.WxVO;
import com.jy.moudles.user.entity.User;
import com.jy.moudles.user.service.UserService;


@Controller
@RequestMapping(value="/")
public class LoginController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private UserService userService;
	
	
	@RequestMapping(value = "/login",  method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData login(HttpServletRequest request,
			HttpServletResponse response,User user) {
		
		String password = user.getPasswrod();
		user.setPasswrod(MD5Util.MD5(password));
		User users = userService.getUserByNameAndPwd(user);
		if (null != users){
			LOGGER.info("用户登录成功");
			request.getSession().setAttribute("user", users);
			return AsyncResponseData.getSuccess();
		} else {
			LOGGER.info("用户登录失败");
			return AsyncResponseData.getSuccess().asParamError("用户名或密码错误");
		}
	}
	
	
	@RequestMapping(value = "/logout",  method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData logout(HttpServletRequest request,
			HttpServletResponse response) {
		request.getSession().removeAttribute("user");
		return AsyncResponseData.getSuccess();
	}
	
	
	@RequestMapping(value = "/Wxlogin",  method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData Wxlogin(@Param("code")String code,HttpServletRequest request) {
		if(StringUtils.isBlank(code)) {
			return AsyncResponseData.getSuccess().asParamError("code is null");
		}
		RequestPost requestPost = new RequestPost();
		requestPost.setAppid(Global.APPID);
		requestPost.setSecret(Global.SECRET);
		requestPost.setJs_code(code);
		requestPost.setGrant_type(Global.GRANT_TYPE);
		
		ResponsePost responsePost = HttpUtils.sendPost(Global.CODE_SESSION_URL + requestPost.toString());
		if(null == responsePost) {
			responsePost = new ResponsePost();
		}
		responsePost.setSession_id(request.getSession().getId());
		return AsyncResponseData.getSuccess(responsePost);
	}
	
	
	@RequestMapping(value = "/openIdlogin",  method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData openIdlogin(WxVO wxVO,HttpServletRequest request) {
		if(StringUtils.isBlank(wxVO.getOpenId())) {
			return AsyncResponseData.getSuccess().asLogicError("can not find openId");
		}
		User user = userService.getUserById(wxVO.getOpenId());
		if(null == user) {
			User usernew = new User();
			usernew.setId(wxVO.getOpenId());
			usernew.setOpenId(wxVO.getOpenId());
			usernew.setUserImg(getUserImg(wxVO.getAvatarUrl(),wxVO.getOpenId()));
			usernew.setUserName(wxVO.getNickName());
			usernew.setUserSex(Integer.parseInt(wxVO.getGender()));
			usernew.setCreateDate(new Date());
			usernew.setUpdateDate(new Date());
			usernew.setCreateUser("wx");
			usernew.setUpdateUser("wx");
			userService.insertUser(usernew);
			request.getSession().setAttribute("user", usernew);
		}else {
			request.getSession().setAttribute("user", user);
		}
		return AsyncResponseData.getSuccess();
	}
	
	@RequestMapping(value = "/updateImage",  method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateImage(WxVO wxVO,HttpServletRequest request) {
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		getUserImg(wxVO.getAvatarUrl(),user.getId());
		return AsyncResponseData.getSuccess();
	}
	
	
	
	@SuppressWarnings("resource")
	public String getUserImg(String avatarUrl,String openId) {
		String url = "";
		if(StringUtils.isBlank(avatarUrl)) {
			return avatarUrl;
		}
		try {
			HttpURLConnection conn = (HttpURLConnection) new URL(avatarUrl)
	                .openConnection();
	        conn.setReadTimeout(5000);
	        conn.setConnectTimeout(5000);
	        conn.setRequestMethod("GET");

	        if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
	            InputStream inputStream = conn.getInputStream();
	            BufferedInputStream bis = new BufferedInputStream(inputStream);
	            File file = new File(Global.SYS_FILE_PATH + openId);
	            if(!file.exists()) {
	            	file.mkdirs();
	            }
	            File files = new File(file.getPath() + Global.USER_IMG_NAME);
	            if(!files.exists()) {
	            	files.createNewFile();
	            }
	            BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(files));
		        byte[] buffer = new byte[1024];
		        int len = -1;
		        while ((len = bis.read(buffer)) != -1) {
		            bos.write(buffer, 0, len);
		            bos.flush();
		        }
	        }
		}catch(Exception e) {
			url = avatarUrl;
		}
		url = Global.IMG_PATH + openId + Global.USER_IMG_NAME;
		return url;
	}
	
}
