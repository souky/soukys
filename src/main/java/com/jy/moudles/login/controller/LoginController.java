package com.jy.moudles.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.MD5Util;
import com.jy.moudles.user.entity.User;
import com.jy.moudles.user.service.UserService;


@Controller
@RequestMapping(value="/")
public class LoginController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private UserService userService;
	
	
	public static String SYS_ORG_ID = "organization_id";
	
	
	@RequestMapping(value = "/login",  method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData login(HttpServletRequest request,
			HttpServletResponse response,User user) {
		
		String password = user.getPasswrod();
		user.setPasswrod(MD5Util.MD5(password));
		User users = userService.getUserByNameAndPwd(user);
		if (null != users){
			LOGGER.info("用户登录成功");
			return AsyncResponseData.getSuccess();
		} else {
			LOGGER.info("用户登录失败");
			return AsyncResponseData.getSuccess().asParamError("用户名或密码错误");
		}
	}
	
	
	@RequestMapping(value = "/logout")
	@ResponseBody
	public AsyncResponseData.ResultData logout(HttpServletRequest request,HttpServletResponse response) {
		request.getSession().removeAttribute("user");
		return AsyncResponseData.getSuccess();
	}
	
	
	@RequestMapping(value = "/Wxlogin")
	@ResponseBody
	public AsyncResponseData.ResultData Wxlogin(String code) {
		if(StringUtils.isBlank(code)) {
			return AsyncResponseData.getSuccess().asParamError("code is null");
		}
		
		return AsyncResponseData.getSuccess();
	}
	
	
}
