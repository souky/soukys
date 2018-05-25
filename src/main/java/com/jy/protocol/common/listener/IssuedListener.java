package com.jy.protocol.common.listener;

import com.jy.moudles.systemConfig.constant.SystemConfigConstants;
import com.jy.moudles.systemConfig.entity.SystemConfig;
import com.jy.moudles.systemConfig.service.SystemConfigService;
import com.jy.protocol.common.constant.DeviceVender;
import com.jy.protocol.jf.thread.DetectionThread;
import com.jy.protocol.jf.thread.ShieldThread;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class IssuedListener implements ServletContextListener{
	
	public static final String REGISTER = "register";
	public static final String SHIELD = "shield";
	public static final String DETECTION = "detection";

	Thread detectionThread = null;
	Thread shieldThread = null;
	Thread registerThread = null;
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		//从数据库读取设备厂商
		WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
		SystemConfigService systemConfigService = context.getBean(SystemConfigService.class);
		SystemConfig detectionVender = systemConfigService.getSystemConfigByKey(SystemConfigConstants.DETECTION_VENDER);
		SystemConfig shieldVender = systemConfigService.getSystemConfigByKey(SystemConfigConstants.SHIELD_VENDER);
		if(detectionVender != null && DeviceVender.JF.equalsIgnoreCase(detectionVender.getSysValue())){
			detectionThread = new Thread(new DetectionThread(), DETECTION);
		}
		if(shieldVender != null && DeviceVender.JF.equalsIgnoreCase(shieldVender.getSysValue())){
			shieldThread = new Thread(new ShieldThread(), SHIELD);
		}

//        registerThread = new Thread(new RegisterThread(), REGISTER);
//
//        if(null != registerThread) {
//        	registerThread.start();
//        }
        if(null != detectionThread) {
        	detectionThread.start();
        }
        if(null != shieldThread) {
        	shieldThread.start();
        }
        
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		if(null != detectionThread) {
        	detectionThread.interrupt();
        }
        if(null != shieldThread) {
        	shieldThread.interrupt();
        }
        if(null != registerThread) {
        	registerThread.interrupt();
        }
	}
}
