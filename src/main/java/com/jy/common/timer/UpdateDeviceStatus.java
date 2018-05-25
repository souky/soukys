package com.jy.common.timer;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.jy.common.timer.timerWork.UpdateDeviceStatusTimer;

@Component
public class UpdateDeviceStatus implements ApplicationListener<ContextRefreshedEvent> {

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if(event.getApplicationContext().getParent() == null){
            new UpdateDeviceStatusTimer(event.getApplicationContext()).start();
		}
	}

}
