package com.jy.moudles.questionBank.entity;

import com.jy.common.entity.BaseEntity;
/**
*
*/
public class QuestionBank extends BaseEntity{
	
	private static final long serialVersionUID = -1L;
	
	
	/**
	 * 
	 */
	private String id;
	
	/**
	 * 
	 */
	private String question;
	
	/**
	 * 
	 */
	private int sort;
	
	/**
	 * 
	 */
	private int score;
	// 1 选择  2 填空  3 自我测评
	private int type;
	
	private String imgUrl;
	
	/**
	 * 
	 */
	private String ablity;
	
	/**
	 * 
	 */
	private String answer;
	
	private int revers;
	
	
	
	
	public int getRevers() {
		return revers;
	}

	public void setRevers(int revers) {
		this.revers = revers;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}
	
	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}
	
	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
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
	
}



