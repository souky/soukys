package com.jy.protocol.jf.entity;

/**
 * 设备类型枚举
 * 
 * @author NancyJin
 *
 */
public enum EquipmentCode {
	
	SERVER(1), DETECTOR(2), SHIELDING(3);
	
	/**
	 * 命令码
	 */
	private int type;
	
	private EquipmentCode (int type) {
		this.type = type;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}
