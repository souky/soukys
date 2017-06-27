package com.souky.entity.user;

import java.io.Serializable;


public class UserInfo implements Serializable{

	private static final long serialVersionUID = 2080231183851270164L;
	
	private String id;
	private String realname;
	private String telephone;
	private String email;
	private String wx_open_id;
	private String status;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWx_open_id() {
		return wx_open_id;
	}
	public void setWx_open_id(String wx_open_id) {
		this.wx_open_id = wx_open_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
