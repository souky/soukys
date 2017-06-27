package com.souky.entity.user;

import java.io.Serializable;
import java.util.Date;

public class UserLogin implements Serializable{
	
	private static final long serialVersionUID = 2184305122805546897L;
	
	private String id;
	private String loginName;
	private String passWord;
	private String infoId;
	private String jurisdictionId;
	private String nickname;
	private Date loginTime;
	private Date registerTime;
	private String enabled;
	
	private String jurisdictionName;
	private String identification;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getInfoId() {
		return infoId;
	}
	public void setInfoId(String infoId) {
		this.infoId = infoId;
	}
	public String getJurisdictionId() {
		return jurisdictionId;
	}
	public void setJurisdictionId(String jurisdictionId) {
		this.jurisdictionId = jurisdictionId;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Date getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}
	public Date getRegisterTime() {
		return registerTime;
	}
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
	public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
	public String getJurisdictionName() {
		return jurisdictionName;
	}
	public void setJurisdictionName(String jurisdictionName) {
		this.jurisdictionName = jurisdictionName;
	}
	public String getIdentification() {
		return identification;
	}
	public void setIdentification(String identification) {
		this.identification = identification;
	}
	
	
}
