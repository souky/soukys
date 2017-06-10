package com.souky.controller.member;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController {

	@RequestMapping("/center")
	public String center(Model model){
		model.addAttribute("fuck", "fuck you!");
		return "m/member/center";
	}
}
