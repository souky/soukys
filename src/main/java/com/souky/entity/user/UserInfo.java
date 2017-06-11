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
	private Jurisdiction jurisdiction;
	
	
	public UserInfo(String id,String loginName,String passWord,String tel,String realname,String nickname,String address){
		this.id = id;
		this.loginName = loginName;
		this.passWord = passWord;
		this.tel = tel;
		this.realname = realname;
		this.nickname = nickname;
		this.address = address;
	}
	
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

	public Jurisdiction getJurisdiction() {
		return jurisdiction;
	}

	public void setJurisdiction(Jurisdiction jurisdiction) {
		this.jurisdiction = jurisdiction;
	}
	
	

	
}
