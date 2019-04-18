package com.jy.moudles.userAnswer.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.userAnswer.entity.UserAnswer;
import com.jy.moudles.userAnswer.service.UserAnswerService;

/** 
 * UserAnswer实现类
 *
 * 创建人：go-3
 * 创建时间：2019-04-18
 */
@Controller
@RequestMapping(value="/useranswer")
public class UserAnswerController {
	
	@Autowired
	private UserAnswerService useranswerService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserAnswerController.class);
	
	/**
	 * 新增useranswer对象
	 * 
	 * @param useranswer
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveUserAnswer", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveUserAnswer(UserAnswer useranswer) throws Exception{
		logger.info("新增UserAnswer Start");
		
		useranswerService.insertUserAnswer(useranswer);
		
		logger.info("新增UserAnswer End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 新增useranswer对象
	 * 
	 * @param useranswer
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertsUserAnswer", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData insertsUserAnswer(@RequestBody List<UserAnswer> useranswer) throws Exception{
		logger.info("新增UserAnswer Start");
		
		useranswerService.insertsUserAnswer(useranswer);
		
		logger.info("新增UserAnswer End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 修改useranswer对象
	 * 
	 * @param useranswer
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateUserAnswer", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateUserAnswer(UserAnswer useranswer) throws Exception{
		logger.info("修改UserAnswer Start");
		
		useranswerService.updateUserAnswer(useranswer);
		
		logger.info("修改UserAnswer End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除useranswer对象
	 * 
	 * @param useranswer
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteUserAnswer", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteUserAnswer(UserAnswer useranswer) throws Exception{
		logger.info("删除UserAnswer Start");
		
		useranswerService.deleteUserAnswerById(useranswer.getId());
		
		logger.info("删除UserAnswer End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取useranswer对象
	 * 
	 * @param useranswer
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryUserAnswers", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryUserAnswers(UserAnswer useranswer) throws Exception{
		logger.info("获取UserAnswer Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<UserAnswer> useranswers= useranswerService.queryUserAnswersFilter(filter);
		logger.info("获取UserAnswer End");
		
		return AsyncResponseData.getSuccess(useranswers);
	}
	
	/**
	 * 根据ID获取useranswer对象
	 * 
	 * @param useranswer
	 * @throws Exception
	 */
	@RequestMapping(value = "/getUserAnswerByUserId", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getUserAnswerById(String userId) throws Exception{
		logger.info("获取UserAnswer Start");
		
		
		List<UserAnswer> useranswers = useranswerService.getUserAnswerByUserId(userId);
		
		logger.info("获取UserAnswer End");
		
		return AsyncResponseData.getSuccess(useranswers);
	}
	
}
