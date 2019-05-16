package com.jy.moudles.userScore.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
	public AsyncResponseData.ResultData queryUserScores(@RequestBody UserScore userscore) throws Exception{
		logger.info("获取UserScore Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(userscore.getUserName())) {
			filter.put("userName", userscore.getUserName());
		}
		if(StringUtils.isNotBlank(userscore.getUserPhone())) {
			filter.put("userPhone", userscore.getUserPhone());
		}
		
		PageHelper.startPage(userscore.getPageNum(), userscore.getPageSize());
    	PageInfo<UserScore> userscores = new PageInfo<UserScore>(userscoreService.queryUserScoresFilter(filter));
		
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
	public AsyncResponseData.ResultData getUserScoreById(@RequestBody String id) throws Exception{
		logger.info("获取UserScore Start");
		
		UserScore userscore = new UserScore();
		
		userscore = userscoreService.getUserScoreById(id);
		
		logger.info("获取UserScore End");
		
		return AsyncResponseData.getSuccess(userscore);
	}
	
	/**
	 * 根据ID获取userscore对象
	 * 
	 * @param userscore
	 * @throws Exception
	 */
	@RequestMapping(value = "/getUserScoreByIdCount", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getUserScoreByIdCount(@RequestBody String id) throws Exception{
		logger.info("获取UserScore Start");
		
		UserScore userscore = userscoreService.getUserScoreById(id);
		
		Map<String,Object> map = new HashMap<>();
		map.put("times", userscore.getUserTime());
		
		Map<String,Object> queryMap = new HashMap<>();
		queryMap.put("userFlag", 1);
		List<UserScore> list = userscoreService.queryUserScoresFilter(queryMap);
		
		String beyoned = "100%";
		
		if(null != list && list.size() > 0) {
			
			BigDecimal right = new BigDecimal(0);
			for(UserScore e:list) {
				if(userscore.getUserTime() <= e.getUserTime()) {
					right = right.add(new BigDecimal(1));
				}
			}
			
			BigDecimal total = new BigDecimal(list.size());
			BigDecimal value = right.divide(total,2,BigDecimal.ROUND_HALF_UP);
			value = value.multiply(new BigDecimal(100));
			beyoned = value.intValue()+"%";
		}
		
		map.put("beyoned", beyoned);
		
		logger.info("获取UserScore End");
		
		return AsyncResponseData.getSuccess(map);
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
