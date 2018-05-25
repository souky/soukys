package com.jy.moudles.permission.entity;

public class PermissionVO {
	/**
	 * id
	 */
	private String id;
	
	/**
	 * 名称
	 */
	private String name;
	
	/**
	 * 父ID
	 */
	private String pId;
	
	/**
	 * 节点是否打开
	 */
	private boolean open;
	
	/**
	 * 节点是否选中
	 */
	private boolean checked;
	
	public PermissionVO(){
		
	}
	
	public PermissionVO(Permission permission){
		this.id = permission.getId();
		this.name = permission.getPermissionName();
		this.pId = permission.getParentId();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
}
