package com.jy.moudles.device.entity;

import com.jy.common.entity.BaseEntity;

import java.util.Date;

public class DeviceGroup extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7707076415521137850L;

	/**
	 * 
	 */
	private String groupName;
	
	/**
	 * 
	 */
	private int groupNo;

	private Date startTime;

	private Date endTime;

	/**
	 * 是否激活
	 * 1:激活,0:禁用
	 */
	private int isActive;

	/**
	 * 控制模块
	 * 0:全部,1:1g,2:手机
	 */
	private int controlModule;
	
	/**
	 * 
	 */
	private String orgId;
	
	/**
	 * 
	 */
	private String remark;
	
	private String userName;

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public int getControlModule() {
		return controlModule;
	}

	public void setControlModule(int controlModule) {
		this.controlModule = controlModule;
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

    /**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}



