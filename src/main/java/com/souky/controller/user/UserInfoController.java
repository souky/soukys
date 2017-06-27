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

import com.souky.common.utils.JsonResult;
import com.souky.common.utils.JsonRsultCode;
import com.souky.common.utils.MD5Util;
import com.souky.entity.user.UserInfo;
import com.souky.entity.user.UserLogin;
import com.souky.service.user.UserInfoService;
import com.souky.service.user.UserLoginService;


@Controller
public class UserInfoController {
	private static final Logger LOGGER = Logger.getLogger(UserInfoController.class);
	
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserLoginService userLoginService;
	
	@RequestMapping("/showInfo")
	public String showUserInfo(){
		return"";
	}
	
	@RequestMapping("/registPage")
	public String registPage(Model model){
		model.addAttribute("testfreemarker", "testfreemarker");
		
		return"/regist";
	}
	
	@RequestMapping("/login")
	public String login(Model model){
		return "/m/login";
	}
	
	@RequestMapping(value="/loginIn",method=RequestMethod.POST)
	@ResponseBody
	public JsonResult loginIn(HttpServletRequest request){
		JsonResult JsonResult = new JsonResult();
		LOGGER.info("进入登陆方法");
		String loginName = request.getParameter("loginName");
		String passWord = request.getParameter("passWord");
		String passWordTrue = MD5Util.MD5(passWord);
		List<UserLogin> list = userLoginService.queryByLoginName(loginName);
		//登陆验证
		if(list!=null && list.size()>0){
			UserLogin userLogin = (UserLogin) list.get(0);
			String passwrod = userLogin.getPassWord();
			if(passWordTrue.equals(passwrod)){
				userLogin.setPassWord("");
				request.getSession().setAttribute("loginUser", userLogin);
				JsonResult.setCode(JsonRsultCode.codeSuccess);
			}else{
				JsonResult.setCode(JsonRsultCode.codeError);
				JsonResult.setMessage("密码错误");
			}
		}else{
			JsonResult.setCode(JsonRsultCode.codeError);
			JsonResult.setMessage("无此用户");
		}
		JsonResult.setSuccess(true);
		return JsonResult;
	}
}
