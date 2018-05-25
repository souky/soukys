package com.jy.moudles.exam.entity;
import java.io.Serializable;
import java.util.Date;

import com.jy.common.entity.BaseEntity;

public class ExamSub extends BaseEntity implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5666794307963698738L;

	
	/**
	 * 考试计划编号
	 */
	private String examPlanId;
	
	/**
	 * 序号
	 */
	private int no;
	
	/**
	 * 名称
	 */
	private String name;
	
	/**
	 * 开始时间
	 */
	private Date startTime;
	
	/**
	 * 结束时间
	 */
	private Date endTime;
	
	private String orgId;

	/**
	 * @return the examPlanId
	 */
	public String getExamPlanId() {
		return examPlanId;
	}

	/**
	 * @param examPlanId the examPlanId to set
	 */
	public void setExamPlanId(String examPlanId) {
		this.examPlanId = examPlanId;
	}

	/**
	 * @return the no
	 */
	public int getNo() {
		return no;
	}

	/**
	 * @param no the no to set
	 */
	public void setNo(int no) {
		this.no = no;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the startTime
	 */
	public Date getStartTime() {
		return startTime;
	}

	/**
	 * @param startTime the startTime to set
	 */
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	/**
	 * @return the endTime
	 */
	public Date getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the orgId
	 */
	public String getOrgId() {
		return orgId;
	}

	/**
	 * @param orgId the orgId to set
	 */
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
}



