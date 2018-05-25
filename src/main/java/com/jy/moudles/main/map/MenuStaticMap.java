package com.jy.moudles.main.map;

import java.util.HashMap;
import java.util.Map;

public class MenuStaticMap {

	public static Map<String,Object> urlMap = new HashMap<String,Object>();
	
	static {
		urlMap.put("exam/examList", "考试计划");
		urlMap.put("exam/examTypeList", "考试类型");
		urlMap.put("exam/cheateList", "还原信号");
		urlMap.put("blackwhitelist/blackwhitelist", "黑白名单");
		urlMap.put("statistics/statisticsAnalysis", "统计数据");
		urlMap.put("suspiciousSignal/monitor", "实时监听");
		urlMap.put("suspiciousSignal/suspicious_signal_list", "可疑信号");
		urlMap.put("/user/user_list", "用户管理");
		urlMap.put("/userEditPassword/userAddEdit", "个人信息");
		urlMap.put("/userEditPassword/editPassword", "密码管理");
		urlMap.put("/role/role_list", "角色信息");
		urlMap.put("/org/org_list", "机构信息");
		urlMap.put("equipment/equipment", "设备列表");
		urlMap.put("log/showLog", "查看日志");
	}
}
