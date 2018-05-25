package com.jy.moudles.login.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.MD5Util;
import com.jy.common.utils.auth.AuthBuilder;
import com.jy.moudles.organization.entity.Organization;
import com.jy.moudles.organization.service.OrganizationService;
import com.jy.moudles.systemConfig.entity.SystemConfig;
import com.jy.moudles.systemConfig.service.SystemConfigService;
import com.jy.moudles.user.entity.User;
import com.jy.moudles.user.service.UserService;


@Controller
@RequestMapping(value="/")
public class LoginController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private UserService userService;
	
	@Autowired
	private OrganizationService organizationService;
	
	@Autowired
	private SystemConfigService systemConfigService;
	
	public static String SYS_ORG_ID = "organization_id";
	
	@RequestMapping(value = "/loginHtml")
	public ModelAndView loginHtml(HttpServletResponse response,HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/loginNew");
		return mv;
	}
	
	@RequestMapping(value = "/login",  method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData login(HttpServletRequest request,HttpServletResponse response, @RequestParam String username, @RequestParam String password) {
		User user = userService.getUserByNameAndPwd(username, MD5Util.MD5(password));
		if (null != user){
			LOGGER.info("用户登录成功");
			//AuthBuilder.setCookie(response, "JY_ANTI_CHEAT", user.getId(), username);
			// 根节点重定向到首页，非根节点到大屏，后续版本维护  重定向更新 加入根结点概念 孙嘉宁 2017年8月28日15:41:24
			String orgId = user.getOrgId();
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			session.setMaxInactiveInterval(0);

			if(StringUtils.isBlank(orgId)) {
				
			}else {
				Map<String, Object> filter = new HashMap<String, Object>();
				filter.put("parentId", orgId);
//				List<Organization> orgList = organizationService.queryOrganizationsFilter(filter);
			}
			
			//首次组织机构判断
			/*SystemConfig systemConfig = systemConfigService.getSystemConfigByKey(SYS_ORG_ID);
			if(null == systemConfig || StringUtils.isBlank(systemConfig.getSysValue())){
				//AuthBuilder.clearCookie(response);
				request.getSession().removeAttribute("authStatistics");
				request.getSession().removeAttribute("user");
				return AsyncResponseData.getSuccess().asParamError("notOrg");
			}*/
			return AsyncResponseData.getSuccess();
		} else {
			LOGGER.info("用户登录失败");
			return AsyncResponseData.getSuccess().asParamError("用户名或密码错误");
		}
	}
	
	
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request,HttpServletResponse response) {
		AuthBuilder.clearCookie(response);
		request.getSession().removeAttribute("authStatistics");
		request.getSession().removeAttribute("user");
		return "redirect:/loginHtml";
	}
	
	
	@RequestMapping(value = "/rememberCookie", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData rememberCookie(HttpServletResponse response, @RequestParam("username") String username, @RequestParam("password") String password) throws UnsupportedEncodingException {
        Cookie nameCookie = new Cookie("username", URLEncoder.encode(username, "utf-8"));
        nameCookie.setMaxAge(60 * 60 * 24 * 30);
        Cookie pwdCookie = new Cookie("password", password);
        pwdCookie.setMaxAge(60 * 60 * 24 * 30);
        
        response.addCookie(nameCookie);
        response.addCookie(pwdCookie);
        
        return AsyncResponseData.getSuccess();
    }
    
    @RequestMapping(value = "/removeCookie", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData removeCookie(HttpServletResponse response) {
        Cookie nameCookie = new Cookie("username", null);
        nameCookie.setMaxAge(0);
        Cookie pwdCookie = new Cookie("password", null);
        pwdCookie.setMaxAge(0);
        
        response.addCookie(nameCookie);
        response.addCookie(pwdCookie);
        
        return AsyncResponseData.getSuccess();
    }
}
