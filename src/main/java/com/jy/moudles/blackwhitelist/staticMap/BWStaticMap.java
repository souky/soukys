package com.jy.moudles.blackwhitelist.staticMap;

import java.util.HashMap;
import java.util.Map;

public class BWStaticMap {
	
	/**
	 * 黑白名单类型
	 * */
	public static Map<String,Integer> typeMap = new HashMap<String, Integer>();
	
	static {
		//类型map
		typeMap.put("U", 0);//未知
		typeMap.put("B", 1);
		typeMap.put("H", 2);
		typeMap.put("M", 3);
		typeMap.put("L", 4);
		typeMap.put("W", 5);
	}
}
