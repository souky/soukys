package com.jy.moudles.userScore.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.userScore.entity.UserScore;
import com.jy.moudles.userScore.service.UserScoreService;

/** 
 * userScore实现类
 *
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@Controller
@CrossOrigin
@RequestMapping(value="/userscore")
public class UserScoreController {
	
	@Autowired
	private UserScoreService userscoreService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserScoreController.class);
	
	/**
	 * 新增userscore对象
	 * 
	 * @param userscore
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveUserScore", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveUserScore(UserScore userscore) throws Exception{
		logger.info("新增UserScore Start");
		
		userscoreService.insertUserScore(userscore);
		
		logger.info("新增UserScore End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 修改userscore对象
	 * 
	 * @param userscore
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateUserScore", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateUserScore(UserScore userscore) throws Exception{
		logger.info("修改UserScore Start");
		
		userscoreService.updateUserScore(userscore);
		
		logger.info("修改UserScore End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除userscore对象
	 * 
	 * @param userscore
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteUserScore", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteUserScore(UserScore userscore) throws Exception{
		logger.info("删除UserScore Start");
		
		userscoreService.deleteUserScoreById(userscore.getId());
		
		logger.info("删除UserScore End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取userscore对象
	 * 
	 * @param userscore
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryUserScores", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryUserScores(UserScore userscore) throws Exception{
		logger.info("获取UserScore Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<UserScore> userscores = userscoreService.queryUserScoresFilter(filter);
		logger.info("获取UserScore End");
		
		return AsyncResponseData.getSuccess(userscores);
	}
	
	
	/**
	 * 根据ID获取userscore对象
	 * 
	 * @param userscore
	 * @throws Exception
	 */
	@RequestMapping(value = "/getUserScoreById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getUserScoreById(String id) throws Exception{
		logger.info("获取UserScore Start");
		
		UserScore userscore = new UserScore();
		
		userscore = userscoreService.getUserScoreById(id);
		
		logger.info("获取UserScore End");
		
		return AsyncResponseData.getSuccess(userscore);
	}
	
	/**
	 * 获取userscore对象
	 * 
	 * @param userscore
	 * @throws Exception
	 */
	@RequestMapping(value = "/getUserScoreByUserPhone", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getUserScoreByUserPhone(@RequestBody UserScore userscore) throws Exception{
		return userscoreService.getUserScoreByUserPhone(userscore);
	}

}
