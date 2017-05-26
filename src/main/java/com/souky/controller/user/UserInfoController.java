package com.souky.controller.user;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserInfoController {
	private static final Logger LOGGER = Logger.getLogger(UserInfoController.class);
	
	@RequestMapping("/showInfo")
	public String showUserInfo(){
		return"";
	}
	
	@RequestMapping("/registPage")
	public String registPage(){
		return"/regist";
	}
}
