package com.jy.moudles.answer.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.answer.entity.Answer;
import com.jy.moudles.answer.service.AnswerService;

@Controller
@RequestMapping(value="/answer")
public class AnswerController {
	
	@Autowired
	private AnswerService answerService;
	
	@RequestMapping(value = "/queryAnswersFilter", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryAnswersFilter() throws Exception{
		
		List<Answer> list = answerService.queryAnswersFilter();
		
		return AsyncResponseData.getSuccess(list);
	}
	
	@RequestMapping(value = "/insertsAnswer", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData insertsAnswer(@RequestBody List<Answer> answers) throws Exception{
		
		answerService.insertsAnswer(answers);
		
		return AsyncResponseData.getSuccess();
	}
}
