package com.souky.entity.user;

import java.io.Serializable;


public class UserInfo implements Serializable{

	private static final long serialVersionUID = -6006612981025466477L;

	private String id;
	private String loginName;
	private String passWord;
	private String tel;
	private String realname;
	private String nickname;
	private String address;
	private String jurisdictionName;
	private String identification;
	private String jurisdictionId;
	
	
	public String getId() {
		return id;
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
	public String getJurisdictionId() {
		return jurisdictionId;
	}
	public void setJurisdictionId(String jurisdictionId) {
		this.jurisdictionId = jurisdictionId;
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
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	

	
}
