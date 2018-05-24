package com.jy.common.validate;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

public class Validator {
//	IP地址
	private static final String REGEX_IP="^([1-9]|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}$";
	
//	MAC地址
	private static final String REGEX_MAC="^([0-9a-fA-F]{2})(([-][0-9a-fA-F]{2}){5})$";
	
//	手机号码
	private static final String REGEX_PHONE_NUMBER="^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
	
//	邮箱
	public static final String EMAIL_REGEX = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	
	public static final SimpleDateFormat sf = new SimpleDateFormat("dd-MM-yyyy");
	
	
	/**
	 * ip地址验证
	 */
	public static boolean isIp(String ip) {
		if (StringUtils.isEmpty(ip))
			return false;
		else {
			return ip.matches(REGEX_IP);
		}
	}
	
	/**
	 * mac地址验证
	 */
	public static boolean isMac(String mac) {
		if (StringUtils.isEmpty(mac))
			return false;
		else {
			return mac.matches(REGEX_MAC);
		}
	}
	
	/**
	 * 手机号码验证
	 */
	public static boolean isPhoneNumber(String num) {
		if (num!=null && !"".equals(num)) {
			return num.matches(REGEX_PHONE_NUMBER);
		}
		return false;
	}
	
	/**
	 * 邮箱地址验证
	 */
	public static boolean isEmail(String address) {
		if (StringUtils.isEmpty(address))
			return false;
		else {
			return address.matches(EMAIL_REGEX);
		}
	}
	
	/**
	 * 日期from必须在to之前
	 */
	public static boolean isFromBeforTo(String fromStr,String toStr){
			try {
				Date fromDate = sf.parse(fromStr);
				Date toDate = sf.parse(toStr);
				return toDate.after(fromDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		return false;
	}
	
	/**
	 * 计算日期差值
	 */
	public static int dateSubstract(String fromStr,String toStr){
		try {
			Date fromDate = sf.parse(fromStr);
			Date toDate = sf.parse(toStr);
			int days = (int) ((toDate.getTime() - fromDate.getTime()) / (1000*3600*24));
			return days;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	

	/**
	 * 校验所给字符串是否小于给定长度
	 */
	public static boolean checkStringLength(String string,int maxLength){
		
		if(string != null){
			int len = string.length();
			if(len <= maxLength){
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 校验所给字符串是否在给定长度之间
	 */
	public static boolean checkStringLength(String str,int minLength,int maxLength){
		
		if(str != null){
			int len = str.length();
			if(len <= maxLength && len >= minLength){
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 校验所给字符串是否等于给定长度
	 */
	public static boolean checkStringLen(String str,int length){
		
		if(str != null){
			if(str.length() == length){
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 校验所给字符串是纯数字
	 */
	public static boolean isPureNumber(String str){
		if(str != null && !"".equals(str)){
			return str.matches("^[0-9]+$");
		}
		return false;
	}

	/**
	 * 校验所给字符串是否为正数(正整数和小数)
	 */
	public static boolean isPositiveNumber(String str){
		if(str != null && !"".equals(str)){
			boolean isInt = Pattern.compile("^[1-9]\\d*$").matcher(str).find();
			boolean isDouble = Pattern.compile("^([1-9]\\d{2,3}\\.\\d{0,3})$").matcher(str).find();
			return isInt || isDouble;
		}
		return false;
	}
	
	/**
	 * 校验所给字符串是纯字母
	 */
	public static boolean isEnglish(String str){
		if(str != null && !"".equals(str)){
			return str.matches("^[A-Za-z]+$");
		}
		return false;
	}
	
	/**
	 * 校验所给字符串是否含有特殊符号
	 */
	public static boolean hasSpecialChar(String str){
		String regEx= "[—_`~!@#$%^&*()+=|{}':;,.<>/?~！@#￥%…&*（）——【】‘；：”“’。，、？\"-\\《》]";
		if(str != null && !"".equals(str)){
			Pattern p = Pattern.compile(regEx);
			Matcher m = p.matcher(str);
			return m.find();
		}
		return false;
	}
	
	
}
