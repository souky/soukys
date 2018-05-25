package com.jy.moudles.role.entity;

import com.jy.common.entity.BaseEntity;

public class Role extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2760800007445817119L;

	/**
	 * id
	 */
	private String id;
	
	/**
	 * 角色名称
	 */
	private String roleName;
	
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
	
}



