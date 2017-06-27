package com.souky.common.interceptors;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.souky.entity.user.UserInfo;

public class CommonInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		if ("POST".equalsIgnoreCase(request.getMethod())) { 
			return true;
        }  
		request.getSession().setAttribute("v_souky", new Date().getTime());
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("loginUser");
		if(userInfo==null){
			response.sendRedirect("/login");
			//request.getRequestDispatcher("/login").forward(request, response); 
			return false;
		}
		
		return true;
	}
	
	
}
