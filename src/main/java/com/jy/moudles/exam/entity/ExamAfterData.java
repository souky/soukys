package com.jy.moudles.exam.entity;
import java.util.Date;

import com.jy.common.entity.BaseEntity;

public class ExamAfterData extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3329253806491579044L;

	/**
	 * 文件名称
	 */
	private String fileName;
	
	/**
	 * 考试计划id
	 */
	private String examPlanId;
	
	/**
	 * 考试场次id
	 */
	private String examNumberId;
	
	/**
	 * 开始时间
	 */
	private Date startTime;
	
	/**
	 * 结束时间
	 */
	private Date endTime;
	
	/**
	 * 文件数量
	 */
	private int fileNumbers;
	
	/**
	 * 文件大小
	 */
	private long fileSize;
	
	/**
	 * 文件地址
	 */
	private String fileAddress;
	
	/**
	 * 文件字节流
	 */
	private byte[] fileByte;
	
	/**
	 * 文件类型
	 */
	private String fileType;
	
	/**
	 * 组织机构id
	 */
	private String orgId;

	private String examName;

	private String examSubName;
	
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getExamPlanId() {
		return examPlanId;
	}

	public void setExamPlanId(String examPlanId) {
		this.examPlanId = examPlanId;
	}
	
	public String getExamNumberId() {
		return examNumberId;
	}

	public void setExamNumberId(String examNumberId) {
		this.examNumberId = examNumberId;
	}
	
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	public int getFileNumbers() {
		return fileNumbers;
	}

	public void setFileNumbers(int fileNumbers) {
		this.fileNumbers = fileNumbers;
	}
	
	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	public String getFileAddress() {
		return fileAddress;
	}

	public void setFileAddress(String fileAddress) {
		this.fileAddress = fileAddress;
	}
	
	public byte[] getFileByte() {
		return fileByte;
	}

	public void setFileByte(byte[] fileByte) {
		this.fileByte = fileByte;
	}
	
	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getExamName() {
		return examName;
	}

	public void setExamName(String examName) {
		this.examName = examName;
	}

	public String getExamSubName() {
		return examSubName;
	}

	public void setExamSubName(String examSubName) {
		this.examSubName = examSubName;
	}
}



