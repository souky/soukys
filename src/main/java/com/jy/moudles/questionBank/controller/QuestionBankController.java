package com.jy.moudles.questionBank.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.questionBank.entity.QuestionBank;
import com.jy.moudles.questionBank.service.QuestionBankService;

/** 
 * questionBank实现类
 *
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@Controller
@RequestMapping(value="/questionbank")
public class QuestionBankController {
	
	@Autowired
	private QuestionBankService questionbankService;
	
	private static final Logger logger = LoggerFactory.getLogger(QuestionBankController.class);
	
	/**
	 * 新增questionbank对象
	 * 
	 * @param questionbank
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveQuestionBank", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveQuestionBank(QuestionBank questionbank) throws Exception{
		logger.info("新增QuestionBank Start");
		
		questionbankService.insertQuestionBank(questionbank);
		
		logger.info("新增QuestionBank End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 修改questionbank对象
	 * 
	 * @param questionbank
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateQuestionBank", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateQuestionBank(QuestionBank questionbank) throws Exception{
		logger.info("修改QuestionBank Start");
		
		questionbankService.updateQuestionBank(questionbank);
		
		logger.info("修改QuestionBank End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除questionbank对象
	 * 
	 * @param questionbank
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteQuestionBank", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteQuestionBank(QuestionBank questionbank) throws Exception{
		logger.info("删除QuestionBank Start");
		
		questionbankService.deleteQuestionBankById(questionbank.getId());
		
		logger.info("删除QuestionBank End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取questionbank对象
	 * 
	 * @param questionbank
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryQuestionBanks", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryQuestionBanks(QuestionBank questionbank) throws Exception{
		logger.info("获取QuestionBank Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<QuestionBank> questionbanks= questionbankService.queryQuestionBanksFilter(filter);
		logger.info("获取QuestionBank End");
		
		return AsyncResponseData.getSuccess(questionbanks);
	}
	
	/**
	 * 根据ID获取questionbank对象
	 * 
	 * @param questionbank
	 * @throws Exception
	 */
	@RequestMapping(value = "/getQuestionBankById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getQuestionBankById(String id) throws Exception{
		logger.info("获取QuestionBank Start");
		
		QuestionBank questionbank = new QuestionBank();
		
		questionbank = questionbankService.getQuestionBankById(id);
		
		logger.info("获取QuestionBank End");
		
		return AsyncResponseData.getSuccess(questionbank);
	}
	
}
