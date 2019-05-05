package com.jy.moudles.userAnswer.entity;

import com.jy.common.entity.BaseEntity;
/**
*
*/
public class UserAnswer extends BaseEntity{
	
	private static final long serialVersionUID = -1L;
	
	
	/**
	 * 
	 */
	private String id;
	
	/**
	 * 
	 */
	private String userId;
	
	private String questionId;
	
	/**
	 * 
	 */
	private int sort;
	
	/**
	 * 
	 */
	private int time;
	
	/**
	 * 
	 */
	private String userAnswer;
	
	private String ablity;
	private String answer;
	private int score;
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}
	
	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	public String getUserAnswer() {
		return userAnswer;
	}

	public void setUserAnswer(String userAnswer) {
		this.userAnswer = userAnswer;
	}

	public String getAblity() {
		return ablity;
	}

	public void setAblity(String ablity) {
		this.ablity = ablity;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getQuestionId() {
		return questionId;
	}

	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}
	
	
	
}



