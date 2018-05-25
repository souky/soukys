package com.jy.moudles.org.entity;

import com.jy.common.entity.BaseEntity;

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
	
}



