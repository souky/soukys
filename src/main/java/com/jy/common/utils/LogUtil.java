package com.jy.common.utils;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.moudles.systemLog.entity.SystemLog;
import com.jy.moudles.systemLog.service.SystemLogService;
import com.jy.moudles.user.entity.User;

/**
 * @author wb
 * @date 2017年10月14日
 */
public class LogUtil {

	/**
	 * 打印日志,存储到数据库
	 * @param operationEvent 操作事件
	 * @param operationType 操作事件类型
	 * @param request
	 */
	public static void addLog(String operationEvent,int operationType,HttpServletRequest request){
		if(operationEvent != null && !"".equals(operationEvent)){
			WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
			SystemLogService systemlogService = context.getBean(SystemLogService.class);
			SystemLog systemLog = new SystemLog();
			systemLog.setId(UUIDUtil.get32UUID());
			systemLog.setOperationEvent(operationEvent);
			systemLog.setOperationType(operationType);
			systemLog.setOperationIp(getRequestIpAddr(request));
			User user = LoginInterceptor.getCurrentUser();
	  		if(user != null){
  				systemLog.setOperationUser(user.getId());
  				systemLog.setOrgId(user.getOrgId());
  				systemLog.setCreateUser(user.getId());
  				systemLog.setCreateDate(new Date());
  				systemLog.setOperationTime(new Date());
	  		}
			
			systemlogService.insertSystemLog(systemLog);
		}
	}
	
	/**
	 * 获取访问者IP 
     * 在一般情况下使用Request.getRemoteAddr()即可，但是经过nginx等反向代理软件后，这个方法会失效。 
     * 本方法先从Header中获取X-Real-IP，如果不存在再从X-Forwarded-For获得第一个IP(用,分割)， 
     * 如果还不存在则调用Request .getRemoteAddr()。 
     * @param request 
	 * @return
	 */
	public static String getRequestIpAddr(HttpServletRequest request){
//		String ip = request.getHeader("X-Real-IP");
//		if (ip!= null && !"".equals(ip) && !"unknown".equalsIgnoreCase(ip)) {  
//            return ip;  
//        }  
//        ip = request.getHeader("X-Forwarded-For");  
//        if (ip!= null && !"".equals(ip)  && !"unknown".equalsIgnoreCase(ip)) {  
//            // 多次反向代理后会有多个IP值，第一个为真实IP。  
//            int index = ip.indexOf(',');  
//            if (index != -1) {  
//                return ip.substring(0, index);  
//            } else {  
//                return ip;  
//            }  
//        } else {  
//            return request.getRemoteAddr();  
//        }  
		
		String ip = request.getHeader("x-forwarded-for");  
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
			ip = request.getHeader("Proxy-Client-IP");  
		}else {
			ip = ip.split(",")[0];
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
			ip = request.getHeader("WL-Proxy-Client-IP");  
		}  
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
			ip = request.getRemoteAddr();  
		}  
		return ip; 		 
	}
}
