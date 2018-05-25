package com.jy.moudles.organization.entity;

import com.jy.common.entity.BaseEntity;

public class Organization extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8081510049894776578L;

	/**
	 * 机构BSID
	 */
	private String bsid;
	
	/**
	 * 机构名称
	 */
	private String name;
	
	/**
	 * 父机构ID
	 */
	private String parentId;
	
	/**
	 * ip
	 * @return
	 */
	private String ip;
	
	/**
	 * 区域代码
	 */
	private String code;
	

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getBsid() {
		return bsid;
	}

	public void setBsid(String bsid) {
		this.bsid = bsid;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	/**
	 * @return the ip
	 */
	public String getIp() {
		return ip;
	}

	/**
	 * @param ip the ip to set
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}
	
}



