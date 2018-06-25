package com.jy.moudles.targetInfo.entity;
import java.util.Date;

import com.jy.common.entity.BaseEntity;

public class TargetInfo extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5548350496398846903L;

	/**
	 * 用户id
	 */
	private String userId;
	
	/**
	 * 目标说明
	 */
	private String message;
	
	/**
	 * 开始时间
	 */
	private Date startTime;
	
	/**
	 * 结束时间
	 */
	private Date endTime;
	
	/**
	 * 目标进度
	 */
	private String rateProgress;
	
	/**
	 * 目标状态 1:启用  2:禁用  3:已结束
	 */
	private int status;
	
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
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
	
	public String getRateProgress() {
		return rateProgress;
	}

	public void setRateProgress(String rateProgress) {
		this.rateProgress = rateProgress;
	}
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
}



