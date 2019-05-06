package com.jy.moudles.userScore.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.userScore.dao.UserScoreDao;
import com.jy.moudles.userScore.entity.UserScore;
import com.jy.moudles.userScore.service.UserScoreService;

/** 
 * userScore业务实现类
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@Service
public class UserScoreServiceImpl implements UserScoreService {

	@Autowired
	private UserScoreDao userScoreDao;
	
	@Override
	public void insertUserScore(UserScore userScore){
		userScore.setId(UUIDUtil.get32UUID());
		userScoreDao.insertUserScore(userScore);
	}
	
	@Override
	public void updateUserScore(UserScore userScore){
		userScoreDao.updateUserScore(userScore);
	}
	
	@Override
	public UserScore getUserScoreById(String id){
		return userScoreDao.getUserScoreById(id);
	}
	
	@Override
	public List<UserScore> queryUserScoresFilter(Map<String, Object> filter){
		return userScoreDao.queryUserScoresFilter(filter);
	}
	
	@Override
	public void deleteUserScoreById(String id){
		userScoreDao.deleteUserScoreById(id);
	}
	
	@Override
	public void deleteUserScores(List<String> ids){
		userScoreDao.deleteUserScores(ids);
	}

	@Override
	public AsyncResponseData.ResultData getUserScoreByUserPhone(UserScore userScore) {
		
		UserScore userscore = userScoreDao.getUserScoreByUserPhone(userScore.getUserPhone());
		if(null == userscore) {
			userScore.setId(UUIDUtil.get32UUID());
			userScore.setUserFlag(0);
			userScore.setUserScore(0);
			userScore.setUserTime(0);
			insertUserScore(userScore);
		}else {
			userScore = userscore;
		}
		
		return AsyncResponseData.getSuccess(userScore);
	}
	
}

