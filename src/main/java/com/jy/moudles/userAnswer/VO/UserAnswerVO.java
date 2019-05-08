package com.jy.moudles.userAnswer.VO;

import com.jy.moudles.questionBank.VO.QuestionBankVO;
import com.jy.moudles.userAnswer.entity.UserAnswer;

public class UserAnswerVO extends UserAnswer{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7591680544386639845L;

	
	private QuestionBankVO questionBankVO;
	

	public QuestionBankVO getQuestionBankVO() {
		return questionBankVO;
	}


	public void setQuestionBankVO(QuestionBankVO questionBankVO) {
		this.questionBankVO = questionBankVO;
	}
	
	
}
