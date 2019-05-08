package com.jy.moudles.questionBank.VO;

import java.util.List;

import com.jy.moudles.questionBank.entity.QuestionBank;
import com.jy.moudles.questionItems.entity.QuestionItems;

public class QuestionBankVO extends QuestionBank{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8359192316633455510L;

	
	private List<QuestionItems> questionItems;


	public List<QuestionItems> getQuestionItems() {
		return questionItems;
	}


	public void setQuestionItems(List<QuestionItems> questionItems) {
		this.questionItems = questionItems;
	}
	
	
}
