package com.jy.moudles.punchClock.entity;

import com.jy.common.entity.BaseEntity;

public class PunchClock extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4418046298671652077L;

	/**
	 * 用户id
	 */
	private String userId;
	
	/**
	 * 机构id
	 */
	private String orgId;
	
	/**
	 * 打卡信息
	 */
	private String punchInfo;
	
	/**
	 * 图片信息
	 */
	private String imgBase;
	
	/**
	 * 打卡时间
	 */
	private String timeInfo;
	
	/**
	 * 是否请假
	 */
	private String isLeave;
	
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
	public String getPunchInfo() {
		return punchInfo;
	}

	public void setPunchInfo(String punchInfo) {
		this.punchInfo = punchInfo;
	}
	
	public String getImgBase() {
		return imgBase;
	}

	public void setImgBase(String imgBase) {
		this.imgBase = imgBase;
	}
	
	public String getTimeInfo() {
		return timeInfo;
	}

	public void setTimeInfo(String timeInfo) {
		this.timeInfo = timeInfo;
	}

	public String getIsLeave() {
		return isLeave;
	}

	public void setIsLeave(String isLeave) {
		this.isLeave = isLeave;
	}
	
}



