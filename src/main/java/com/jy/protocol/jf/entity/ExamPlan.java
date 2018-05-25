package com.jy.protocol.jf.entity;

import java.util.Date;

public class ExamPlan {

	/**
	 * 考试代号
	 */
	private String examCode;
	
	/**
	 * 考试场次
	 */
	private int number;
	
	/**
	 * 开始日期
	 */
	private Date startDate;
	
	/**
	 * 结束日期
	 */
	private Date endDate;
	
	/**
	 * 保留
	 */
	private String reserved;

	public String getExamCode() {
		return examCode;
	}

	public void setExamCode(String examCode) {
		this.examCode = examCode;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getReserved() {
		return reserved;
	}

	public void setReserved(String reserved) {
		this.reserved = reserved;
	}
	
}
