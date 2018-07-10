package com.jy.moudles.user.entity;

import com.jy.common.entity.BaseEntity;

public class User extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2284772003455208937L;

	/**
	 * 用户姓名
	 */
	private String userName;
	
	/**
	 * 真实姓名
	 */
	private String realName;
	
	/**
	 * 用户电话
	 */
	private String userTel;
	
	/**
	 * 用户性别
	 */
	private int userSex;
	
	/**
	 * 登陆名
	 */
	private String loginName;
	
	/**
	 * 密码
	 */
	private String passwrod;
	
	/**
	 * 用户头像
	 */
	private String userImg;
	
	/**
	 * 机构代码
	 */
	private String orgCode;
	
	/**
	 * wx openId
	 */
	private String openId;
	
	//多表联查字段
	private String orgName;
	
	
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getUserTel() {
		return userTel;
	}

	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	
	public int getUserSex() {
		return userSex;
	}

	public void setUserSex(int userSex) {
		this.userSex = userSex;
	}
	
	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	public String getPasswrod() {
		return passwrod;
	}

	public void setPasswrod(String passwrod) {
		this.passwrod = passwrod;
	}
	
	public String getUserImg() {
		return userImg;
	}

	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}
	
	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	
	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
}



