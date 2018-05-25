package com.jy.protocol.jf.entity;

public class BlackWhiteListCode {

	/**
	 * 类型
	 */
	private int type;
	
	/**
	 * 目标频点/起始频点
	 */
	private String startFrequency;
	
	/**
	 * 关联频点/结束频点
	 */
	private String endFrequency;
	
	/**
	 * 属性
	 */
	private int attribute;
	
	public enum Attribute {
		
		BLACK(0), WHITE(1), LOW_SUSPICION(2), HIGH_SUSPICION(3);
		
		private Attribute (int code) {
			this.code = code;
		}
		
		private int code;

		public int getCode() {
			return code;
		}

		public void setCode(int code) {
			this.code = code;
		}
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getStartFrequency() {
		return startFrequency;
	}

	public void setStartFrequency(String startFrequency) {
		this.startFrequency = startFrequency;
	}

	public String getEndFrequency() {
		return endFrequency;
	}

	public void setEndFrequency(String endFrequency) {
		this.endFrequency = endFrequency;
	}

	public int getAttribute() {
		return attribute;
	}

	public void setAttribute(int attribute) {
		this.attribute = attribute;
	}
	
}
