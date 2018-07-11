package com.jy.moudles.targetInfo.scheduled;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.jy.moudles.targetInfo.service.TargetInfoService;

@Component
public class TargetScheduled implements ApplicationListener<ContextRefreshedEvent> {
	
	
	@Autowired
	private TargetInfoService targetInfoService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TargetScheduled.class);
	
	/**
     * 定时任务，每天晚上12点05删除数据表t_tempClob中的所有记录
     */
    @Scheduled(cron= "0 05 0 * * ?")
    public void deleteAllTempClob(){
    	LOGGER.info("start update targetInfo status");
        targetInfoService.updateStatus();
    }

	@Override
	public void onApplicationEvent(ContextRefreshedEvent arg0) {
		// TODO Auto-generated method stub
		
	}
}
