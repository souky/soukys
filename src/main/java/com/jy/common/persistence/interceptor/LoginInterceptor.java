package com.jy.common.persistence.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.jy.common.utils.auth.AuthBuilder;
import com.jy.common.utils.auth.AuthUser;
import com.jy.moudles.user.entity.User;
import com.jy.moudles.user.service.UserService;
@SuppressWarnings("unused")
public class LoginInterceptor implements HandlerInterceptor {
	
	/**
	 * 忽略url
	 */
	private final static String[] IGNORE_URI = {"/loginHtml","/login"};
	

	private static WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();



	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {

	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object obj) throws Exception {
		boolean flag = false;
		boolean urlFlag = false;
		String url = request.getRequestURL().toString();
		
		// 跨域拦截
        String ref = request.getHeader("Origin");
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("Access-Control-Allow-Origin", ref);

		for (String s : IGNORE_URI) {
			if (url.contains(s)) {
				flag = true;
				urlFlag = true;
				break;
			}
		}
		
		if (!flag) {
			HttpSession session = request.getSession();
			if(session != null){
				User user = (User) session.getAttribute("user");
				if(user != null){
					flag = true;
					urlFlag = true;
				}
			}
		}
		if (!flag || !urlFlag) {
			// TODO
			String returns ="{'code':'20000','message':'no login'}";
			response.getOutputStream().write(returns.getBytes());
		}
		return (flag && urlFlag);
	}
	
}
