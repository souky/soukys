package com.jy.moudles.systemConfig.entity;

import com.jy.common.entity.BaseEntity;

public class SystemConfig extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -512107580695017588L;


	/**
	 * 
	 */
	private String sysKey;
	
	/**
	 * 
	 */
	private String sysValue;

	/**
	 * @return the sysKey
	 */
	public String getSysKey() {
		return sysKey;
	}

	/**
	 * @param sysKey the sysKey to set
	 */
	public void setSysKey(String sysKey) {
		this.sysKey = sysKey;
	}

	/**
	 * @return the sysValue
	 */
	public String getSysValue() {
		return sysValue;
	}

	/**
	 * @param sysValue the sysValue to set
	 */
	public void setSysValue(String sysValue) {
		this.sysValue = sysValue;
	}
	
}



