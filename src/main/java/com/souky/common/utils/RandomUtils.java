package com.souky.common.utils;

import java.lang.StringBuffer;

public class RandomUtils {

	/*
	 * 四位随机数  s:随机数位数
	 * */
	public static String random(int s){
		StringBuffer sb = new StringBuffer();
		for(int i = 0;i<s;i++){
			double d = Math.random()*10;
			sb.append((int)d);
		}
		return sb.toString();
	}
	
	
}
