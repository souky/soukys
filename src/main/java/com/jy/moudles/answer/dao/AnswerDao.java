package com.jy.moudles.answer.dao;

import java.util.List;

import com.jy.common.persistence.annotation.MyBatisDao;
import com.jy.moudles.answer.entity.Answer;

@MyBatisDao
public interface AnswerDao {

	public List<Answer> queryAnswersFilter();
	
	public void deletAll();
	
	public void insertsAnswer(List<Answer> answers);
}
