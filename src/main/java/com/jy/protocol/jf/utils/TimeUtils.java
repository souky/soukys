package com.jy.protocol.jf.utils;


import com.jy.protocol.jf.constants.JFCodeConstants;

/**
 * @author wb
 *
 */
public class TimeUtils {

	/**
	 * 获取当前时间,转十六进制,并进行倒序
	 */
	public static String getTimeToHex(long longtime) {
		
		long time = (int) (longtime/ JFCodeConstants.MS_TO_S_THOUSAND + JFCodeConstants.TIME_OFFER);
//		Date date = new Date(time * 1000); 
//		System.out.println(date);
		String t = Long.toHexString(time);
		return reverseHex(t);
	}
	
	/**
	 * 将传入的string反转,传入的string长度必须为偶数
	 * @param string
	 */
	public static String reverseHex(String string){
		
		if(string == null || string.length() == 0 || string.length() % 2 != 0){
			return "";
		}
		StringBuffer sb = new StringBuffer();
		for (int i = string.length()/2; i > 0; i--) {
			sb.append(string.substring((i-1)*2,i*2));
		}
		
		return sb.toString();
	}
	
	
	public static void main(String[] args) {
		//System.out.println(getTimeToHex());
		System.out.println(reverseHex("huojdmwe"));
	}
}
