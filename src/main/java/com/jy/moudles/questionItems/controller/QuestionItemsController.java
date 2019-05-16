package com.jy.moudles.questionItems.controller;

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
import com.jy.moudles.questionItems.entity.QuestionItems;
import com.jy.moudles.questionItems.service.QuestionItemsService;

/** 
 * questionItems实现类
 *
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@Controller
@RequestMapping(value="/questionitems")
public class QuestionItemsController {
	
	@Autowired
	private QuestionItemsService questionitemsService;
	
	private static final Logger logger = LoggerFactory.getLogger(QuestionItemsController.class);
	
	/**
	 * 新增questionitems对象
	 * 
	 * @param questionitems
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveQuestionItems", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveQuestionItems(QuestionItems questionitems) throws Exception{
		logger.info("新增QuestionItems Start");
		
		questionitemsService.insertQuestionItems(questionitems);
		
		logger.info("新增QuestionItems End");
		return AsyncResponseData.getSuccess();
	}
	
//	@RequestMapping(value = "/test", method = RequestMethod.GET)
//	@ResponseBody
//	public AsyncResponseData.ResultData test() throws Exception{
//		logger.info("新增QuestionItems Start");
//		
//		questionitemsService.test();
//		
//		logger.info("新增QuestionItems End");
//		return AsyncResponseData.getSuccess();
//	}
	
	/**
	 * 修改questionitems对象
	 * 
	 * @param questionitems
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateQuestionItems", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateQuestionItems(QuestionItems questionitems) throws Exception{
		logger.info("修改QuestionItems Start");
		
		questionitemsService.updateQuestionItems(questionitems);
		
		logger.info("修改QuestionItems End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除questionitems对象
	 * 
	 * @param questionitems
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteQuestionItems", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteQuestionItems(QuestionItems questionitems) throws Exception{
		logger.info("删除QuestionItems Start");
		
		questionitemsService.deleteQuestionItemsById(questionitems.getId());
		
		logger.info("删除QuestionItems End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取questionitems对象
	 * 
	 * @param questionitems
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryQuestionItemss", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryQuestionItemss(QuestionItems questionitems) throws Exception{
		logger.info("获取QuestionItems Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<QuestionItems> questionitemss= questionitemsService.queryQuestionItemssFilter(filter);
		logger.info("获取QuestionItems End");
		
		return AsyncResponseData.getSuccess(questionitemss);
	}
	
	/**
	 * 根据ID获取questionitems对象
	 * 
	 * @param questionitems
	 * @throws Exception
	 */
	@RequestMapping(value = "/getQuestionItemsById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getQuestionItemsById(String id) throws Exception{
		logger.info("获取QuestionItems Start");
		
		QuestionItems questionitems = new QuestionItems();
		
		questionitems = questionitemsService.getQuestionItemsById(id);
		
		logger.info("获取QuestionItems End");
		
		return AsyncResponseData.getSuccess(questionitems);
	}
	
}
