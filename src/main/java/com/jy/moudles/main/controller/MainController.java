package com.jy.moudles.main.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.moudles.main.entity.Menu;
import com.jy.moudles.main.service.MenuService;
import com.jy.moudles.user.entity.User;


@Controller
@RequestMapping(value="/")
public class MainController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MainController.class);
	
	//超级管理员id
	private static final String ADMIN_ID = "1";
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(value = "/main")
	public ModelAndView gotoMainJsp(HttpServletRequest request) {
		LOGGER.info("首页面打开");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("main/mainPages");
		return mv;
	}
	
	@RequestMapping(value = "/gotoMenuJsp",  method = RequestMethod.POST)
	public ModelAndView gotoMenuJsp(@RequestParam(value = "url", required = false)String url,HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName(url);
		return mv;
	}
	
	//重写menu
	@RequestMapping(value = "/mainMenuNew", method = RequestMethod.POST)
	public ModelAndView getMenuNew(@RequestParam(value = "basePath", required = false)String basePath){
		ModelAndView mv = new ModelAndView();
		User user = LoginInterceptor.getCurrentUser();
		if(user == null){
			mv.setViewName("login/login");
			return mv;
		}
		List<Menu> menus = null;
		//超级管理员查所有菜单
		if(ADMIN_ID.equals(user.getId())){
			menus = menuService.queryAllMenus();
		}else {
			Map<String, Object> filter = new HashMap<String, Object>();
			filter.put("userId", user.getId());
			menus = menuService.queryMenus(filter);
		}
		mv.setViewName("main/post/menu");
		mv.addObject("meuns", menus);
		mv.addObject("basePath", basePath);
		return mv;
	}
	
	
	@RequestMapping(value = "/mainMenu", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getMenu(){
		// 后期获取菜单方法需重构
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("menuLevel", 1);
		List<Menu> menus = menuService.queryMenus(filter);
//		UserInfo userInfo = LoginInterceptor.getCurrentUserInfo();
		List<Menu> firstLevelMenus = new ArrayList<Menu>();
		for (Menu menu : menus) {
//			List<String> menuIds = userInfo.getMenus();
//			if (menuIds.contains(menu.getId())) {
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("bsid", menu.getBsid());
				params.put("level", menu.getMenuLevel());
				List<Menu> sonMenus = menuService.querySonMenusByBsid(params);
				List<Menu> setSonMenus = new ArrayList<Menu>();
				for (Menu sonMenu : sonMenus){
//					if (menuIds.contains(sonMenu.getId())){
						setSonMenus.add(sonMenu);
//					}
				}
				menu.setSonMenus(setSonMenus);
				firstLevelMenus.add(menu);
//			}
		}
		return AsyncResponseData.getSuccess(firstLevelMenus);
	}
}
