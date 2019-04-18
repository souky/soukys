package com.jy.moudles.userAnswer.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.userAnswer.entity.UserAnswer;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * UserAnswer数据接口
 * 创建人：go-3
 * 创建时间：2019-04-18
 */
@MyBatisDao
public interface UserAnswerDao {

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
	
}



