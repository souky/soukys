package com.jy.common.utils;

import javax.servlet.http.HttpServletRequest;

import com.jy.moudles.user.entity.User;
import com.jy.moudles.user.service.UserService;

public class UserUtils {
	
	public static User getLoginUser(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		return user;
	}
	
	public static void resetUser(HttpServletRequest request,UserService userService) {
		
		User user = (User) request.getSession().getAttribute("user");
		user = userService.getUserById(user.getId());
		request.getSession().setAttribute("user",user);
	}
}
