package com.jy.moudles.userAnswer.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.userAnswer.dao.UserAnswerDao;
import com.jy.moudles.userAnswer.entity.UserAnswer;
import com.jy.moudles.userAnswer.service.UserAnswerService;

/** 
 * UserAnswer业务实现类
 * 创建人：go-3
 * 创建时间：2019-04-18
 */
@Service
public class UserAnswerServiceImpl implements UserAnswerService {

	@Autowired
	private UserAnswerDao UserAnswerDao;
	
	@Override
	public void insertUserAnswer(UserAnswer UserAnswer){
		UserAnswer.setId(UUIDUtil.get32UUID());
		UserAnswerDao.insertUserAnswer(UserAnswer);
	}
	
	@Override
	public void updateUserAnswer(UserAnswer UserAnswer){
		UserAnswerDao.updateUserAnswer(UserAnswer);
	}
	
	
	@Override
	public List<UserAnswer> queryUserAnswersFilter(Map<String, Object> filter){
		return UserAnswerDao.queryUserAnswersFilter(filter);
	}
	
	@Override
	public void deleteUserAnswerById(String id){
		UserAnswerDao.deleteUserAnswerById(id);
	}
	
	@Override
	public void deleteUserAnswers(List<String> ids){
		UserAnswerDao.deleteUserAnswers(ids);
	}

	@Override
	public void insertsUserAnswer(List<UserAnswer> UserAnswers) {
		for(UserAnswer e :UserAnswers) {
			e.setId(UUIDUtil.get32UUID());
		}
		UserAnswerDao.insertsUserAnswer(UserAnswers);
	}

	@Override
	public List<UserAnswer> getUserAnswerByUserId(String userId) {
		List<UserAnswer> list = UserAnswerDao.getUserAnswerByUserId(userId);
		
		return list;
	}
	
}

