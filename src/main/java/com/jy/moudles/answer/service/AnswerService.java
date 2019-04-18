package com.jy.moudles.answer.service;

import java.util.List;

import com.jy.moudles.answer.entity.Answer;

public interface AnswerService {

	public List<Answer> queryAnswersFilter();
	
	public void deletAll();	
	
	public void insertsAnswer(List<Answer> answers);
}
