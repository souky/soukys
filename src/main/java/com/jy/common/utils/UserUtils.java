package com.jy.common.utils;

import javax.servlet.http.HttpServletRequest;

import com.jy.moudles.user.entity.User;

public class UserUtils {

	public static User getLoginUser(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		return user;
	}
}
