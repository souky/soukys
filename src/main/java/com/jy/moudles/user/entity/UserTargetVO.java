package com.jy.moudles.user.entity;

public class UserTargetVO {
	
	private String id;
	
	/**
	 * 用户姓名
	 */
	private String userName;
	
	/**
	 * 真实姓名
	 */
	private String realName;
	
	/**
	 * 用户性别
	 */
	private int userSex;
	
	/**
	 * 用户头像
	 */
	private String userImg;
	
	/**
	 * 目标进度
	 */
	private int rateProgress;
	
	/**
	 * 目标天数
	 */
	private int targetDays;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public int getUserSex() {
		return userSex;
	}

	public void setUserSex(int userSex) {
		this.userSex = userSex;
	}

	public String getUserImg() {
		return userImg;
	}

	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}

	public int getRateProgress() {
		return rateProgress;
	}

	public void setRateProgress(int rateProgress) {
		this.rateProgress = rateProgress;
	}

	public int getTargetDays() {
		return targetDays;
	}

	public void setTargetDays(int targetDays) {
		this.targetDays = targetDays;
	}
	
	
}
