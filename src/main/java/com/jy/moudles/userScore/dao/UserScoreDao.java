package com.jy.moudles.userScore.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.userScore.entity.UserScore;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * userScore数据接口
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@MyBatisDao
public interface UserScoreDao {

	/**
	 * 新增userScore对象
	 *
	 * @param userScore
	 */
	public void insertUserScore(UserScore userScore);
	
	/**
	 * 更新userScore对象
	 *
	 * @param userScore
	 */
	public void updateUserScore(UserScore userScore);
	
	/**
	 * 根据ID获取userScore对象
	 *
	 * @param id
	 */
	public UserScore getUserScoreById(String id);
	
	/**
	 * 根据过滤条件获取userScore列表对象
	 *
	 * @param filter
	 */
	public List<UserScore> queryUserScoresFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除userScore列表对象
	 *
	 * @param id
	 */
	public void deleteUserScoreById(String id);
	
	/**
	 * 根据Id集合批量删除userScore列表对象
	 *
	 * @param ids
	 */
	public void deleteUserScores(List<String> ids);
	
}



