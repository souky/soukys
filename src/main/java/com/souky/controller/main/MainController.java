package com.souky.controller.main;


import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {

	
	@RequestMapping("/")
	public String index(HttpServletRequest request){
		
		return "/main/index";
	}
}
