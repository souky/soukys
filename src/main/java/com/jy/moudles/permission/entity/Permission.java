package com.jy.moudles.permission.entity;

import com.jy.common.entity.BaseEntity;

public class Permission extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6577192441203848075L;

	/**
	 * 上级id
	 */
	private String pId;
	
	/**
	 * 权限名称
	 */
	private String pName;
	
	
	public String getPId() {
		return pId;
	}

	public void setPId(String pId) {
		this.pId = pId;
	}
	
	public String getPName() {
		return pName;
	}

	public void setPName(String pName) {
		this.pName = pName;
	}
	
}



