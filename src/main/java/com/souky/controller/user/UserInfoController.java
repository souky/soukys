package com.souky.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.souky.common.utils.CheckMobile;
import com.souky.common.utils.EmailUtil;
import com.souky.common.utils.JsonResult;
import com.souky.common.utils.JsonRsultCode;
import com.souky.common.utils.MD5Util;
import com.souky.entity.common.EmailMessage;
import com.souky.entity.user.UserLogin;
import com.souky.service.user.UserLoginService;

/**
 * 用户基础
 * */
@Controller
public class UserInfoController {
	private static final Logger LOGGER = Logger.getLogger(UserInfoController.class);
	
	@Autowired
	private UserLoginService userLoginService;
	
	/**
	 * 用户信息页面
	 * */
	@RequestMapping("/showInfo")
	public String showUserInfo(){
		return"";
	}
	
	/**
	 * 用户注册页面
	 * */
	@RequestMapping("/regist")
	public String registPage(Model model,HttpServletRequest request){
		if(CheckMobile.check(request)) {
			return "/m/regist";
		}else {
			return "";
		}
	}
	/**
	 * 发送注册邮件
	 * */
	@RequestMapping(value = "/regist",method=RequestMethod.POST)
	@ResponseBody
	public JsonResult sendRegistEmail(Model model,HttpServletRequest request){
		JsonResult jsonResult = new JsonResult();
		EmailMessage emailMessage = new EmailMessage();
		emailMessage.setSubject("test");
		model.addAttribute("message", emailMessage);
		String html = EmailUtil.getEmailModel(model, "mail",request);
		jsonResult.setSuccess(true);
		EmailUtil.doSendHtmlEmail("注册验证码", html,"136069803@qq.com");
		return jsonResult;
	}
	
	/**
	 * 用户登陆页面
	 * */
	@RequestMapping("/login")
	public String login(Model model,HttpServletRequest request){
		if(CheckMobile.check(request)) {
			return "/m/login";
		}else {
			return "";
		}
		
	}
	
	/**
	 * 用户登陆方法
	 * */
	@RequestMapping(value="/loginIn",method=RequestMethod.POST)
	@ResponseBody
	public JsonResult loginIn(UserLogin userLogin,HttpServletRequest request){
		JsonResult jsonResult = new JsonResult();
		LOGGER.info("进入登陆方法");
		String loginName = userLogin.getLoginName();
		String passWord = userLogin.getPassWord();
		String passWordTrue = MD5Util.MD5(passWord);
		List<UserLogin> list = userLoginService.queryByLoginName(loginName);
		//登陆验证
		if(list!=null && list.size()>0){
			UserLogin userLogins = (UserLogin) list.get(0);
			String passwrod = userLogin.getPassWord();
			if(passWordTrue.equals(passwrod)){
				userLogins.setPassWord("");
				request.getSession().setAttribute("loginUser", userLogin);
				jsonResult.setCode(JsonRsultCode.codeSuccess);
				jsonResult.setMessage("登陆成功");
				//放入登陆时间
				
			}else{
				jsonResult.setCode(JsonRsultCode.codeError);
				jsonResult.setMessage("密码错误");
			}
		}else{
			jsonResult.setCode(JsonRsultCode.codeError);
			jsonResult.setMessage("无此用户");
		}
		jsonResult.setSuccess(true);
		return jsonResult;
	}
}
