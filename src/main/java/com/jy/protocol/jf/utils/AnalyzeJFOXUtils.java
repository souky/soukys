package com.jy.protocol.jf.utils;


import com.jy.protocol.jf.constants.CommandCode;
import com.jy.protocol.jf.constants.JFCodeConstants;
import com.jy.protocol.jf.entity.BlackWhiteListCode;
import com.jy.protocol.jf.entity.EquipmentCode;
import com.jy.protocol.jf.entity.ExamPlan;
import com.jy.protocol.jf.entity.FrameHeader;

import java.util.List;


public class AnalyzeJFOXUtils {
	
	/**
	 * 获取帧头
	 * 
	 * @param hexString
	 * @return
	 */
	public static FrameHeader getFrameHeader(String hexString) {
		FrameHeader frameHeader = new FrameHeader(hexString);
		return frameHeader;
	}
	
	/**
	 * 组装帧头
	 * 
	 * @param length 帧长度
	 * @param source 来源
	 * @param commandCode 命令码
	 * @return
	 */
	public static String assembleFrameHeader(int length, String source, String commandCode) {
		StringBuffer sb = new StringBuffer();
		// 同步字节
		sb.append(JFCodeConstants.HEADER);
		
		// 帧长度
		String hexLength = getHexBack(length, 4);
		sb.append(hexLength);
		
		// 来源
		sb.append(source);
		
		// 命令码
		sb.append(commandCode);
		
		// 帧校验
		sb.append(JFCodeConstants.DEFAULT_CHECK_CODE);
		
		return sb.toString();
	}
	
	/**
	 * 获取考试计划
	 * 
	 * @param examPlans
	 * @return
	 */
	public static String getExamPlanCode(List<ExamPlan> examPlans){
		
		StringBuffer sb = new StringBuffer();
		// 帧头
		sb.append(assembleFrameHeader(JFCodeConstants.FRAME_HEADER_LENGTH + JFCodeConstants.BYTE_DIGIT_SEVEN + (examPlans.size() * JFCodeConstants.BYTE_DIGIT_TWENTY),
				String.format(JFCodeConstants.FILL_ZERO_TWO_DIGIT, EquipmentCode.SERVER.getType()), CommandCode.EXAM_PLAN.getCode()));
		// 阻断优先
		sb.append("00");
		// 还原间隔时间
		sb.append("00");
		// 当前系统时间
		sb.append(TimeUtils.getTimeToHex(System.currentTimeMillis()));
		// 参数个数
		sb.append(String.format(JFCodeConstants.FILL_ZERO_TWO_DIGIT, examPlans.size()));
		for (ExamPlan examPlan : examPlans) {
			String hexExamCode = getHexBack(Integer.parseInt(examPlan.getExamCode().replaceAll("-", "")), JFCodeConstants.BYTE_DIGIT_FOUR);
			sb.append(hexExamCode);
			String hexNum = getHexBack(examPlan.getNumber(), JFCodeConstants.BYTE_DIGIT_FOUR);
			sb.append(hexNum);
			String hexStartDate = TimeUtils.getTimeToHex(examPlan.getStartDate().getTime());
			sb.append(hexStartDate);
			String hexEndDate = TimeUtils.getTimeToHex(examPlan.getEndDate().getTime());
			sb.append(hexEndDate);
			sb.append(JFCodeConstants.DEFAULT_RESERVED_CODE);
		}
		
		return sb.toString();
	}
	
	/**
	 * 获取黑白名单
	 * 
	 * @param blackWhiteList
	 * @return
	 */
	public static String getBlackWhiteList(List<BlackWhiteListCode> blackWhiteList) {
		
		StringBuffer sb = new StringBuffer();
		// 帧头
		sb.append(assembleFrameHeader(JFCodeConstants.FRAME_HEADER_LENGTH + JFCodeConstants.BYTE_DIGIT_FOUR + JFCodeConstants.BYTE_DIGIT_TWO + JFCodeConstants.BYTE_DIGIT_TEN * blackWhiteList.size(),
				String.format(JFCodeConstants.FILL_ZERO_TWO_DIGIT, EquipmentCode.SERVER.getType()), CommandCode.BLACK_WHITE_LIST.getCode()));
		// 时间
		sb.append(TimeUtils.getTimeToHex(System.currentTimeMillis()));
		// 数量
		sb.append(getHexBack(blackWhiteList.size(), JFCodeConstants.BYTE_DIGIT_TWO));
		for (BlackWhiteListCode blackWhite : blackWhiteList) {
			
			// 类型
			sb.append(String.format(JFCodeConstants.FILL_ZERO_TWO_DIGIT, blackWhite.getType()));
			// 目标频点/起始频点
			sb.append(getHexBack(Integer.parseInt(blackWhite.getStartFrequency()), JFCodeConstants.BYTE_DIGIT_FOUR));
			// 关联频点/结束频点
			sb.append(getHexBack(Integer.parseInt(blackWhite.getEndFrequency()), JFCodeConstants.BYTE_DIGIT_FOUR));
			// 属性
			sb.append(String.format(JFCodeConstants.FILL_ZERO_TWO_DIGIT, blackWhite.getAttribute()));
			
		}
		
		return sb.toString();
	}
	
	/**
	 * 获取模块开关控制
	 * 
	 * @param module
	 * @param type
	 * @return
	 */
	public static String getmoduleOpenOperation(String module, int type) {
		StringBuffer sb = new StringBuffer();
		
		// 帧头
		sb.append(assembleFrameHeader(JFCodeConstants.FRAME_HEADER_LENGTH + JFCodeConstants.BYTE_DIGIT_ONE,
					String.format(JFCodeConstants.FILL_ZERO_TWO_DIGIT, EquipmentCode.SERVER.getType()),
					module));
		
		// 内容
		sb.append(String.format(JFCodeConstants.FILL_ZERO_TWO_DIGIT, type));
		
		return sb.toString();
	}
	
	/**
	 * 获取连接源标记
	 * 
	 * @param type  0：非强制连接  1：强制连接
	 * @return
	 */
	public static String getConnectionSource(int type) {
		StringBuffer sb = new StringBuffer();
		
		// 帧头
		sb.append(assembleFrameHeader(JFCodeConstants.FRAME_HEADER_LENGTH+ JFCodeConstants.BYTE_DIGIT_ONE,
				String.format(JFCodeConstants.FILL_ZERO_TWO_DIGIT, EquipmentCode.SERVER.getType()),
				CommandCode.CONNECT_CODE.getCode()));
		// 连接方式
		sb.append(String.format(JFCodeConstants.FILL_ZERO_TWO_DIGIT, type));
		
		return sb.toString();
	}
	
	
	
	/**
	 * 获取倒序16进制
	 * 
	 * @param number
	 * @param digit
	 * @return
	 */
	public static String getHexBack(int number, int digit) {
		
		StringBuffer sb = new StringBuffer();
		String hexLength = Integer.toHexString(number).toUpperCase();
		hexLength = padRight(hexLength, JFCodeConstants.BASE_LENGTH_BYTE * digit, JFCodeConstants.CHAR_ZERO);
		hexLength = hexLength.replaceAll(JFCodeConstants.REGEX_TWO_DIGIT, JFCodeConstants.FILL_SPACE_REPLACE);
		String[] hexLengths = hexLength.split(JFCodeConstants.SPILT_SPACE);
		for (int start = 0, end = hexLengths.length - 1; start < end; start++, end--) {
	        String temp = hexLengths[end];
	        hexLengths[end] = hexLengths[start];
	        hexLengths[start] = temp;
	    }
		for (String hex : hexLengths) {
			sb.append(hex);
		}
		return sb.toString();
	}
	
	/**
	 * 左补位，右对齐
	 * 
	 * @param oriStr 原字符串
	 * @param len 目标字符串长度
	 * @param alexin 补位字符
	 * @return 目标字符串
	 */
	public static String padLeft(String oriStr, int len, char alexin) {
		String str = "";
		int strlen = oriStr.length();
		if (strlen < len) {
			for (int i = 0; i < len - strlen; i++) {
				str = str + alexin;
			}
		}
		str = oriStr + str;
		return str;
	}
	
	/**
	 * 右补位，左对齐
	 * 
	 * @param oriStr 原字符串
	 * @param len 目标字符串长度
	 * @param alexin 补位字符
	 * @return 目标字符串
	 */
	public static String padRight(String oriStr, int len, char alexin) {
		String str = "";
		int strlen = oriStr.length();
		if (strlen < len) {
			for (int i = 0; i < len - strlen; i++) {
				str = str + alexin;
			}
		}
		str = str + oriStr;
		return str;
	}
	
	public static void main(String[] args) {
		System.out.println(assembleFrameHeader(10, "01", CommandCode.REGISTER_REQUEST.getCode()));;
	}

}
