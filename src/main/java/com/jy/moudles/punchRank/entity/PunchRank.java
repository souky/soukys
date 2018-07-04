package com.jy.moudles.punchRank.entity;

import com.jy.common.entity.BaseEntity;
import com.jy.moudles.user.entity.User;

public class PunchRank extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4650953002355492895L;

	/**
	 * id
	 */
	private String id;
	
	/**
	 * 机构id
	 */
	private String orgCode;
	
	/**
	 * 用户id
	 */
	private String userId;
	
	/**
	 * 排名时间
	 */
	private String rankTime;
	
	/**
	 * 签到天数
	 */
	private int punchDays;
	
	/**
	 * 目标完成进度
	 */
	private int rateProgress;
	
	/**
	 * 排名名次
	 */
	private int rankNum;
	
	//关联字段
	private User user;
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getRankTime() {
		return rankTime;
	}

	public void setRankTime(String rankTime) {
		this.rankTime = rankTime;
	}
	
	public int getPunchDays() {
		return punchDays;
	}

	public void setPunchDays(int punchDays) {
		this.punchDays = punchDays;
	}
	
	public int getRateProgress() {
		return rateProgress;
	}

	public void setRateProgress(int rateProgress) {
		this.rateProgress = rateProgress;
	}
	
	public int getRankNum() {
		return rankNum;
	}

	public void setRankNum(int rankNum) {
		this.rankNum = rankNum;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
}



