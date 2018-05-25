package com.jy.protocol.jf.entity;

import com.jy.protocol.jf.constants.JFCodeConstants;

public class FrameHeader {
	
	/**
	 * 同步字节
	 */
	private String syncByte;
	
	/**
	 * 帧长度
	 */
	private int length;
	
	/**
	 * 来源
	 */
	private int source;
	
	/**
	 * 命令码
	 */
	private String commandCode;
	
	/**
	 * 帧校验
	 */
	private String checkCode;
	
	public String getSyncByte() {
		return syncByte;
	}

	public void setSyncByte(String syncByte) {
		this.syncByte = syncByte;
	}

	public int getLength() {
		return length;
	}

	public void setLength(int length) {
		this.length = length;
	}

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
	}

	public String getCommandCode() {
		return commandCode;
	}

	public void setCommandCode(String commandCode) {
		this.commandCode = commandCode;
	}

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	public FrameHeader() {
		
	}
	
	public FrameHeader(String hexString) {
		String[] hexStrings = hexString.split(JFCodeConstants.SPILT_SPACE);
		if (JFCodeConstants.JF_CODE_LENGTH_MIN > hexStrings.length) {
			return;
		}
		
		syncByte = hexStrings[1] + hexStrings[0];
		
		length = Integer.parseInt(hexStrings[5] + hexStrings[4] + hexStrings[3] + hexStrings[2], JFCodeConstants.HEX);
		
		source = Integer.parseInt(hexStrings[6], JFCodeConstants.HEX);
		
		commandCode = hexStrings[7];
		
		checkCode = hexStrings[9] + hexStrings[8];
	}
}
