package com.jy.moudles.statistics.entity;

import com.jy.common.entity.BaseEntity;

public class Region extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5963598478035678444L;

	/**
	 * 区域CODE
	 */
	private String regionCode;
	
	/**
	 * 区域名称
	 */
	private String regionName;
	
	/**
	 * 区域父ID
	 */
	private String regionPId;
	
	/**
	 * 区域级别
	 */
	private String regionLevel;
	
	/**
	 * 区域同级排序顺序
	 */
	private int regionOrder;
	
	/**
	 * 区域全拼
	 */
	private String regionNameEn;
	
	/**
	 * 区域首字母
	 */
	private String regionShortnameEn;
	
	/**
	 * 区域BSID
	 */
	private String regionBsid;
	
	/**
	 * 
	 */
	private String remark;
	
	
	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	
	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	
	public String getRegionPId() {
		return regionPId;
	}

	public void setRegionPId(String regionPId) {
		this.regionPId = regionPId;
	}
	
	public String getRegionLevel() {
		return regionLevel;
	}

	public void setRegionLevel(String regionLevel) {
		this.regionLevel = regionLevel;
	}
	
	public int getRegionOrder() {
		return regionOrder;
	}

	public void setRegionOrder(int regionOrder) {
		this.regionOrder = regionOrder;
	}
	
	public String getRegionNameEn() {
		return regionNameEn;
	}

	public void setRegionNameEn(String regionNameEn) {
		this.regionNameEn = regionNameEn;
	}
	
	public String getRegionShortnameEn() {
		return regionShortnameEn;
	}

	public void setRegionShortnameEn(String regionShortnameEn) {
		this.regionShortnameEn = regionShortnameEn;
	}
	
	public String getRegionBsid() {
		return regionBsid;
	}

	public void setRegionBsid(String regionBsid) {
		this.regionBsid = regionBsid;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}



