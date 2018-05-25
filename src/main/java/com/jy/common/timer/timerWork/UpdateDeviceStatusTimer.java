package com.jy.common.timer.timerWork;

import java.util.*;

import com.jy.moudles.device.entity.Device;
import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.jf.utils.IssuedSendUtils;
import com.jy.protocol.jf.utils.ThreadSwitchUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import com.jy.moudles.device.service.DeviceService;


public class UpdateDeviceStatusTimer {

    private static final Logger logger = LoggerFactory.getLogger(UpdateDeviceStatusTimer.class);

    private static ApplicationContext context;

    @SuppressWarnings("static-access")
	public UpdateDeviceStatusTimer(ApplicationContext context) {
        this.context = context;
    }
    
    public void start(){
        logger.debug("检测设备更新");
        Timer timer = new Timer("update-device-status");
        timer.schedule(new ChangeDeviceStatusTask(), 1000 * 10, (1000 * 60));

        Timer timer1 = new Timer("update-heart-breath");
        timer1.schedule(new ChangeDeviceHeartBreath(), 1000 * 35, 1000 * 20);

    }

    class ChangeDeviceHeartBreath extends TimerTask{

        @Override
        public void run(){
            Object obj = ParamStatic.issuedStaticMap.get("heart_breath_time");
            if(obj != null){
                Date lastBreath = (Date)obj;
                long milliseconds = new Date().getTime() - lastBreath.getTime();
                //20秒内没有更新心跳,关闭连接平台连接侦测线程,tcp,心跳置为false
                if(milliseconds > 20 * 1000){
                    ThreadSwitchUtils.closeServerThread();
                }
            }
        }
    }

    class ChangeDeviceStatusTask extends TimerTask{

		@Override
		public void run() {
			//更改设备状态
			DeviceService deviceService = context.getBean(DeviceService.class);
			deviceService.updateDeviceStatusOnAgreement();

			/*Object flag = ParamStatic.issuedStaticMap.get(IssuedSendUtils.HEART_BREATH);
			if(flag != null && (boolean)flag){
                //若心跳存在,且侦测状态为离线,则关闭线程
                Map<String, Object> filter = new HashMap<>();
                filter.put("type", "1");
                filter.put("status", "2");
                List<Device> devices = deviceService.queryDevicesFilter(filter);
                if(devices != null && !devices.isEmpty()){
                    ThreadSwitchUtils.closeServerThread();
                }

                //平台服务状态监测
                ParamStatic.issuedStaticMap.put(IssuedSendUtils.HEART_BREATH, false);
            }*/
		}
    	
    }
    
    
}
