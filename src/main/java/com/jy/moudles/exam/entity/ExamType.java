package com.jy.moudles.exam.entity;
import com.jy.common.entity.BaseEntity;

public class ExamType extends BaseEntity{

	
	private static final long serialVersionUID = -3868997447919519345L;

	/**
	 * 考试类型编号
	 */
	private int examTypeNo;
	
	/**
	 * 类型名称
	 */
	private String examTypeName;
	
	private String orgId;

	/**
	 * @return the examTypeNo
	 */
	public int getExamTypeNo() {
		return examTypeNo;
	}

	/**
	 * @param examTypeNo the examTypeNo to set
	 */
	public void setExamTypeNo(int examTypeNo) {
		this.examTypeNo = examTypeNo;
	}

	/**
	 * @return the examTypeName
	 */
	public String getExamTypeName() {
		return examTypeName;
	}

	/**
	 * @param examTypeName the examTypeName to set
	 */
	public void setExamTypeName(String examTypeName) {
		this.examTypeName = examTypeName;
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



