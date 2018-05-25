package com.jy.moudles.permission.entity;

import com.jy.common.entity.BaseEntity;

public class Permission extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7050570252903134199L;

	/**
	 * bsid
	 */
	private String bsid;
	
	/**
	 * 权限名称
	 */
	private String permissionName;
	
	/**
	 * 父ID
	 */
	private String parentId;
	
	
	public String getBsid() {
		return bsid;
	}

	public void setBsid(String bsid) {
		this.bsid = bsid;
	}

	public String getPermissionName() {
		return permissionName;
	}

	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}

	
	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	
}



