package com.jy.moudles.reductionInfo.entity;
import java.util.Date;

import com.jy.common.entity.BaseEntity;
import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.entity.ExamSub;
import com.jy.moudles.organization.entity.Organization;

public class ReductionInfo extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7259286462987970734L;

	/**
	 * 考试计划id
	 */
	private String examPlanId;
	
	/**
	 * 考试场次id
	 */
	private String examNumberId;
	
	/**
	 * 频点
	 */
	private String frequency;
	
	/**
	 * 强度
	 */
	private String db;
	
	/**
	 * 文件后缀
	 */
	private String suffix;
	
	/**
	 * 信号类型--0未知，1语音，2文本
	 */
	private int signalType;
	
	/**
	 * 识别结果--0未知，1确认作弊，2非作弊
	 */
	private int recognitionResult;
	
	/**
	 * 还原时间
	 */
	private Date reductionTime;
	
	/**
	 * 文件地址
	 */
	private String fileAddr;
	
	/**
	 * 文件名称
	 */
	private String fileName;
	
	/**
	 * 
	 */
	private String orgId;
	
	private Exam exam;
	private ExamSub examSub;
	private Organization organization;


	/**
	 * @return the exam
	 */
	public Exam getExam() {
		return exam;
	}

	/**
	 * @param exam the exam to set
	 */
	public void setExam(Exam exam) {
		this.exam = exam;
	}

	/**
	 * @return the examSub
	 */
	public ExamSub getExamSub() {
		return examSub;
	}

	/**
	 * @param examSub the examSub to set
	 */
	public void setExamSub(ExamSub examSub) {
		this.examSub = examSub;
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
	
	public String getFrequency() {
		return frequency;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	
	public String getDb() {
		return db;
	}

	public void setDb(String db) {
		this.db = db;
	}
	
	public String getSuffix() {
		return suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}
	
	public int getSignalType() {
		return signalType;
	}

	public void setSignalType(int signalType) {
		this.signalType = signalType;
	}
	
	public int getRecognitionResult() {
		return recognitionResult;
	}

	public void setRecognitionResult(int recognitionResult) {
		this.recognitionResult = recognitionResult;
	}
	
	public Date getReductionTime() {
		return reductionTime;
	}

	public void setReductionTime(Date reductionTime) {
		this.reductionTime = reductionTime;
	}
	
	public String getFileAddr() {
		return fileAddr;
	}

	public void setFileAddr(String fileAddr) {
		this.fileAddr = fileAddr;
	}
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}
}



