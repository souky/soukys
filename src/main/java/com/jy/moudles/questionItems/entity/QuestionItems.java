package com.jy.moudles.questionItems.entity;

import com.jy.common.entity.BaseEntity;
/**
*
*/
public class QuestionItems extends BaseEntity{
	
	private static final long serialVersionUID = -1L;
	
	
	/**
	 * 
	 */
	private String id;
	
	/**
	 * 
	 */
	private String questionId;
	
	/**
	 * 
	 */
	private int sort;
	
	/**
	 * 
	 */
	private String answerItem;
	
	/**
	 * 
	 */
	private String answerKey;
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getQuestionId() {
		return questionId;
	}

	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}
	
	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}
	
	public String getAnswerItem() {
		return answerItem;
	}

	public void setAnswerItem(String answerItem) {
		this.answerItem = answerItem;
	}
	
	public String getAnswerKey() {
		return answerKey;
	}

	public void setAnswerKey(String answerKey) {
		this.answerKey = answerKey;
	}
	
}



