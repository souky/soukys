package com.jy.moudles.answer.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.answer.dao.AnswerDao;
import com.jy.moudles.answer.entity.Answer;
import com.jy.moudles.answer.service.AnswerService;

@Service
public class AnswerServiceImpl implements AnswerService{

	@Autowired
	private AnswerDao answerDao;
	
	@Override
	public List<Answer> queryAnswersFilter() {
		return answerDao.queryAnswersFilter();
	}

	@Override
	public void deletAll() {
		answerDao.deletAll();
	}

	@Override
	public void insertsAnswer(List<Answer> answers) {
		answerDao.deletAll();
		for(Answer e : answers) {
			e.setId(UUIDUtil.get32UUID());
		}
		answerDao.insertsAnswer(answers);
	}

}
