package com.souky.common.utils;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CommonInterceptor extends HandlerInterceptorAdapter{

	@SuppressWarnings("rawtypes")
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		if ("POST".equalsIgnoreCase(request.getMethod())) { 
			return true;
        }  
		request.getSession().setAttribute("v_souky", new Date().getTime());
		Map map = (Map)request.getSession().getAttribute("loginUser");
		if(map==null || map.keySet().size()<0){
			request.getRequestDispatcher("/login").forward(request, response); 
			return false;
		}
		
		return true;
	}
	
	
}
