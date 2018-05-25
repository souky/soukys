package com.jy.protocol.jf.constants;

public interface JFCodeConstants {

	/**
	 * 空格分隔符
	 */
	public static final String SPILT_SPACE = " ";
	
	/**
	 * 帧头最小长度
	 */
	public static final int JF_CODE_LENGTH_MIN = 10;
	
	/**
	 * 帧头固定长度10
	 */
	public static final int FRAME_HEADER_LENGTH = 10;
	
	/**
	 * 16进制
	 */
	public static final int HEX = 16;
	
	/**
	 * 帧头
	 */
	public static final String HEADER = "A5F0";
	
	/**
	 * 8位数补0
	 */
	public static final String FILL_ZERO_EIGHT_DIGIT = "%08d";
	
	/**
	 * 2位数补0
	 */
	public static final String FILL_ZERO_TWO_DIGIT = "%02d";
	
	/**
	 * 补位0
	 */
	public static final char CHAR_ZERO = '0';
	
	/**
	 * 帧长度
	 */
	public static final int LENGTH_FRAME_LENGTH = 8;
	
	/**
	 * 字符基础长度
	 */
	public static final int BASE_LENGTH_BYTE = 2;
	
	/**
	 * 每两位
	 */
	public static final String REGEX_TWO_DIGIT = "(.{2})";
	
	/**
	 * 补位空格
	 */
	public static final String FILL_SPACE_REPLACE = "$1 ";
	
	/**
	 * 默认帧校验码
	 */
	public static final String DEFAULT_CHECK_CODE = "0000";
	
	/**
	 * 默认保留字段
	 */
	public static final String DEFAULT_RESERVED_CODE = "00000000";
	
	/**
	 * 字符位数20
	 */
	public static final int BYTE_DIGIT_TWENTY = 20;
	
	/**
	 * 字符位数10
	 */
	public static final int BYTE_DIGIT_TEN = 10;
	
	/**
	 * 字符位数7
	 */
	public static final int BYTE_DIGIT_SEVEN = 7;
	
	/**
	 * 字符位数4
	 */
	public static final int BYTE_DIGIT_FOUR = 4;
	
	/**
	 * 字符位数2
	 */
	public static final int BYTE_DIGIT_TWO = 2;
	
	/**
	 * 字符位数1
	 */
	public static final int BYTE_DIGIT_ONE = 1;
	
	/**
	 * 毫秒转秒除数
	 */
	public static final int MS_TO_S_THOUSAND = 1000;
	
	/**
	 * 频点
	 */
	public static final int FREQUENCY = 0;
	
	/**
	 * 频点
	 */
	public static final int BAND = 1;
	
	/**
	 * 时间偏移量
	 */
	public static final int TIME_OFFER = 28800;
	
	
}
