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
import com.souky.common.utils.MD5Util;
import com.souky.service.user.UserInfoService;


@Controller
public class UserInfoController {
	private static final Logger LOGGER = Logger.getLogger(UserInfoController.class);
	
	@Autowired
	private UserInfoService userInfoService;
	
	@RequestMapping("/showInfo.html")
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
		return"/m/login";
	}
	
	@RequestMapping(value="/loginIn",method=RequestMethod.POST)
	@ResponseBody
	public JsonResult loginIn(HttpServletRequest request){
		JsonResult JsonResult = new JsonResult();
		LOGGER.info("进入登陆方法");
		String loginName = request.getParameter("loginName");
		String passWord = request.getParameter("passWord");
		String passWordTrue = MD5Util.MD5(passWord);
		System.out.println(passWordTrue);
		List<Object> list = userInfoService.queryByLoginName(loginName);
		System.out.println(list);
		JsonResult.setSuccess(true);
		return JsonResult;
	}
}
