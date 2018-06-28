package com.jy.moudles.org.entity;

import java.util.List;

import com.jy.common.entity.BaseEntity;
import com.jy.moudles.user.entity.User;

public class Org extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6897391537558080877L;

	/**
	 * 上级机构id
	 */
	private String pId;
	
	/**
	 * 机构名称
	 */
	private String orgName;
	
	//关联字段
	private String memberCount;
	
	private List<User> userList;
	
	
	public String getPId() {
		return pId;
	}

	public void setPId(String pId) {
		this.pId = pId;
	}
	
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getMemberCount() {
		return memberCount;
	}

	public void setMemberCount(String memberCount) {
		this.memberCount = memberCount;
	}

	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
		this.userList = userList;
	}
	
}



