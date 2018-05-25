package com.jy.protocol.jf.utils;


/**
 * Mac地址工具类
 * */
public class MacUtils {

	/**
	 * 转字符串为mac地址 00-00-00-00-00-00
	 * @return 有可能为null
	 * */
	public static String coverStringToMac(String code) {
		String mac = null;
		if(null != code && code.length() == 12) {
			code = code.toUpperCase();
			char[] charArray = code.toCharArray();
			StringBuffer sb = new StringBuffer();
			for(int i = 0;i < charArray.length;i++) {
				sb.append(charArray[i]);
				if(i != 0 && i % 2 == 1 && i != (charArray.length-1)) {
					sb.append("-");
				}
			}
			mac = sb.toString();
		}
		return mac;
	}
	
	public static void main(String[] args) {
		String s = coverStringToMac("949fb401727a");
		System.out.println(s);
	}
}
