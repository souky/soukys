package com.jy.moudles.exam.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.jy.common.entity.BaseEntity;
import com.jy.common.excelUtil.ExcelField;
import com.jy.moudles.organization.entity.Organization;

public class Exam extends BaseEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4168074752333672286L;

	//考试名称
	@ExcelField(title="考试名称")
	private String examName;
	//考试编号  年份+自动序号（例 2017-001）
	@ExcelField(title="考试编号")
	private String examNo;
	//开始时间
	@ExcelField(title="开始时间")
	private Date startTime;
	//结束时间
	@ExcelField(title="结束时间")
	private Date endTime;
	//类型 --0未知，1启用，2禁用
	private Integer status;
	//考试类型编号
	private String examTypeId;
	
	private String orgId;
	
	private List<ExamSub> examSubList;

	private Organization organization;

	/**
	 * @return the examName
	 */
	public String getExamName() {
		return examName;
	}

	/**
	 * @param examName the examName to set
	 */
	public void setExamName(String examName) {
		this.examName = examName;
	}

	/**
	 * @return the examNo
	 */
	public String getExamNo() {
		return examNo;
	}

	/**
	 * @param examNo the examNo to set
	 */
	public void setExamNo(String examNo) {
		this.examNo = examNo;
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
	 * @return the status
	 */
	public Integer getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}

	/**
	 * @return the examTypeId
	 */
	public String getExamTypeId() {
		return examTypeId;
	}

	/**
	 * @param examTypeId the examTypeId to set
	 */
	public void setExamTypeId(String examTypeId) {
		this.examTypeId = examTypeId;
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

	/**
	 * @return the examSubList
	 */
	public List<ExamSub> getExamSubList() {
		return examSubList;
	}

	/**
	 * @param examSubList the examSubList to set
	 */
	public void setExamSubList(List<ExamSub> examSubList) {
		this.examSubList = examSubList;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}
}
