package com.jy.moudles.userAnswer.service;

import java.util.List;
import java.util.Map;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.userAnswer.entity.UserAnswer;

/** 
 * UserAnswer业务接口
 * 创建人：go-3
 * 创建时间：2019-04-18
 */
public interface UserAnswerService {

	/**
	 * 新增UserAnswer对象
	 *
	 * @param UserAnswer
	 */
	public void insertUserAnswer(UserAnswer UserAnswer);
	
	/**
	 * 新增UserAnswer对象
	 *
	 * @param UserAnswer
	 */
	public void insertsUserAnswer(List<UserAnswer> UserAnswers);
	
	/**
	 * 更新UserAnswer对象
	 *
	 * @param UserAnswer
	 */
	public void updateUserAnswer(UserAnswer UserAnswer);
	
	/**
	 * 根据ID获取UserAnswer对象
	 *
	 * @param id
	 */
	public List<UserAnswer> getUserAnswerByUserId(String userId);
	
	/**
	 * 根据过滤条件获取UserAnswer列表对象
	 *
	 * @param filter
	 */
	public List<UserAnswer> queryUserAnswersFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除UserAnswer列表对象
	 *
	 * @param id
	 */
	public void deleteUserAnswerById(String id);
	
	/**
	 * 根据Id集合批量删除UserAnswer列表对象
	 *
	 * @param ids
	 */
	public void deleteUserAnswers(List<String> ids);
	
	/**
	 * 根据ID获取UserAnswerVO对象 附带题目
	 *
	 * @param id
	 */
	public AsyncResponseData.ResultData getUserAnswerByUserIdWithData(String userId);
	
}

