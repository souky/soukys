package com.jy.moudles.systemLog.entity;
import java.util.Date;

import com.jy.common.entity.BaseEntity;
import com.jy.moudles.user.entity.User;

public class SystemLog extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6831939116129559149L;

	/**
	 * 操作事件
	 */
	private String operationEvent;
	
	/**
	 * 操作用户id
	 */
	private String operationUser;
	
	/**
	 * 操作用户ip
	 */
	private String operationIp;
	
	/**
	 * 操作时间
	 */
	private Date operationTime;
	
	/**
	 * 操作类型--0增、1删、2改、3：授权
	 */
	private int operationType;
	
	/**
	 * 组织机构id
	 */
	private String orgId;
	
	private User user;
	
	
	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}

	public String getOperationEvent() {
		return operationEvent;
	}

	public void setOperationEvent(String operationEvent) {
		this.operationEvent = operationEvent;
	}
	
	public String getOperationUser() {
		return operationUser;
	}

	public void setOperationUser(String operationUser) {
		this.operationUser = operationUser;
	}
	
	public String getOperationIp() {
		return operationIp;
	}

	public void setOperationIp(String operationIp) {
		this.operationIp = operationIp;
	}
	
	public Date getOperationTime() {
		return operationTime;
	}

	public void setOperationTime(Date operationTime) {
		this.operationTime = operationTime;
	}
	
	public int getOperationType() {
		return operationType;
	}

	public void setOperationType(int operationType) {
		this.operationType = operationType;
	}
	
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
}



