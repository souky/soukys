package com.jy.protocol.jf.constants;

/**
 * 命令码枚举
 * 
 * @author NancyJin
 *
 */
public enum CommandCode {
	CONNECT_CODE("F0"), CONNECT_RESPONSE_CODE("F1"),
	HEARTBEAT("F2"),
	REGISTER_REQUEST("00"),
	REGISTER_RESPONSE("01"),
	EXAM_PLAN("32"),
	BLACK_WHITE_LIST("96"),
	MONITOR_REQUEST("99"), MONITOR_RESPONSE("9A"),
	RESTORE_FILE("9D"),
	MODULAR_1G("03"), MODULAR_MOBILE("04"),
	BLOCKING_UP_START("C8");
	
	/**
	 * 命令码
	 */
	private String code;
	
	private CommandCode (String code) {
		this.code = code;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
}
