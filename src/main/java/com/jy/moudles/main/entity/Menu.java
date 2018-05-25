package com.jy.moudles.main.entity;

import java.util.Date;
import java.util.List;

public class Menu {

	/**
	 * 
	 */
	private String id;
	/**
	 * 
	 */
	private String bsid;
	/**
	 * 
	 */
	private String menuName;
	/**
	 * 
	 */
	private int menuOrder;
	/**
	 * 
	 */
	private String permissionId;
	/**
	 * 
	 */
	private String remark;
	/**
	 * 
	 */
	private String isDelete;
	/**
	 * 
	 */
	private String createUser;
	/**
	 * 
	 */
	private Date createDate;
	/**
	 * 
	 */
	private String updateUser;
	/**
	 * 
	 */
	private Date updateDate;
	
	private List<Menu> sonMenus;
	
	private String url;
	
	private int menuLevel;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(int menuLevel) {
		this.menuLevel = menuLevel;
	}

	public List<Menu> getSonMenus() {
		return sonMenus;
	}

	public void setSonMenus(List<Menu> sonMenus) {
		this.sonMenus = sonMenus;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBsid() {
		return bsid;
	}

	public void setBsid(String bsid) {
		this.bsid = bsid;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public int getMenuOrder() {
		return menuOrder;
	}

	public void setMenuOrder(int menuOrder) {
		this.menuOrder = menuOrder;
	}

	public String getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(String permissionId) {
		this.permissionId = permissionId;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
}
