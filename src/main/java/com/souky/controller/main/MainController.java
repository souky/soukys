package com.souky.controller.main;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@SuppressWarnings("rawtypes")
public class MainController {

	
	@RequestMapping("/index")
	public String index(HttpServletRequest request){
		
		Map map = (Map) request.getSession().getAttribute("loginUser");
		System.out.println(map);
		return "/m/index";
	}
}
