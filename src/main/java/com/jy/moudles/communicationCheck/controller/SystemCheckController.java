package com.jy.moudles.communicationCheck.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.jy.moudles.systemConfig.constant.SystemConfigConstants;
import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.jf.utils.IssuedSendUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.systemConfig.entity.SystemConfig;
import com.jy.moudles.systemConfig.service.SystemConfigService;

@Controller
@RequestMapping(value = "/systemCheck")
public class SystemCheckController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SystemCheckController.class);
	
	@Autowired
	private SystemConfigService systemConfigService;
	
	/**
	 * 查看磁盘容量
	 * @return
	 */
	@RequestMapping(value = "/systemCheck", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData systemCheck(){
		LOGGER.info("系统检测");
		File[] roots = File.listRoots();
		//List<SystemCheck> systemCheckList = new ArrayList<>();
		String returnStr = "";
		int gb = 1024 * 1024 * 1024;
		String unit = "GB";
		long free = 0;
		long total = 0;
        for(File file : roots){
            free += file.getFreeSpace();
            total += file.getTotalSpace();
        }
        if(total != 0) {
        	String freeSpace = String.format("%.2f", free*1.0/gb) + unit;
            String totalSpace = String.format("%.2f", total*1.0/gb) + unit;
            returnStr += freeSpace + "(空闲)/" + totalSpace + "(全部);";
        }
        String[] arr = returnStr.split(";");
        if(arr.length > 2){
            returnStr = arr[0] + ";" + arr[1];
        }
        return AsyncResponseData.getSuccess(returnStr);
	}
	
	/**
	 * 查看上次检测时间
	 * @return
	 */
	@RequestMapping(value = "/getLastCheckTime", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData getLastCheckTime(){
		LOGGER.info("获取上次检测时间开始");
		SystemConfig systemConfig = systemConfigService.getSystemConfigByKey(SystemConfigConstants.LAST_CHECK_TIME);
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String nowStr = now.format(dtf);
		String message = "";
		//先查看是否已连接侦测,若没有连接,则不进行上次检测事件的更新
		Object heartBreath = ParamStatic.issuedStaticMap.get(IssuedSendUtils.HEART_BREATH);
		boolean flag = heartBreath == null ? false : (boolean)heartBreath;

		if(systemConfig == null){
		    if(flag){
                systemConfig = new SystemConfig();
                systemConfig.setSysKey(SystemConfigConstants.LAST_CHECK_TIME);
                systemConfig.setSysValue(nowStr);
                systemConfigService.insertSystemConfig(systemConfig);
            }
		}else {
			message = systemConfig.getSysValue();
			if(flag){
                systemConfig.setSysValue(nowStr);
                systemConfigService.updateSystemConfig(systemConfig);
            }
		}
		LOGGER.info("获取上次检测时间结束");
		return AsyncResponseData.getSuccess(message);
	}
    		
}
