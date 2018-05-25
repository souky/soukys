package com.jy.moudles.device.timer;

import com.jy.moudles.device.entity.Device;
import com.jy.moudles.device.entity.DeviceGroup;
import com.jy.moudles.device.service.DeviceService;
import com.jy.protocol.common.utils.GeneralProtocol;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import java.util.*;

/**
 * Created by wb on 2017/12/20 17:06
 * 定时开关机计划定时器
 */
public class DeviceOpenAndCloseTimer {

    static WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();

    private static Map<String, Timer> timerMap = new HashMap<>();

    /**
     * @param deviceGroup
     */
    public static void openPlan(DeviceGroup deviceGroup){
        int groupNo = deviceGroup.getGroupNo();
        int controlModule = deviceGroup.getControlModule();
        Date date = deviceGroup.getStartTime();
        String name = "deviceGroup-" + groupNo + "-start";
        Timer timer = new Timer(name);
        timer.schedule(new OpenOrClosePlanTask(groupNo, 1, controlModule), date);
        timerMap.put(name, timer);
    }

    /**
     * @param deviceGroup
     */
    public static void closePlan(DeviceGroup deviceGroup){
        int groupNo = deviceGroup.getGroupNo();
        int controlModule = deviceGroup.getControlModule();
        Date date = deviceGroup.getEndTime();
        String name = "deviceGroup-" + groupNo + "-end";
        Timer timer = new Timer(name);
        timer.schedule(new OpenOrClosePlanTask(groupNo, 0, controlModule), date);
        timerMap.put(name, timer);
    }

    /**
     * @param groupNo 设备分组编号
     */
    public static void closeTimer(int groupNo){
        Timer openTimer = timerMap.get("deviceGroup-" + groupNo + "-start");
        Timer closeTimer = timerMap.get("deviceGroup-" + groupNo + "-end");
        if(openTimer != null){
            openTimer.cancel();
            openTimer.purge();
        }
        if(closeTimer != null){
            closeTimer.cancel();
            closeTimer.purge();
        }
    }


    static class OpenOrClosePlanTask extends TimerTask{

        private int groupNo;

        //1:开   0:关
        private int type;

        //0:全部, 1:1g, 2:手机
        private  int controlModule;

        public int getType() {
            return type;
        }

        public void setType(int type) {
            this.type = type;
        }

        public int getGroupNo() {
            return groupNo;
        }

        public void setGroupNo(int groupNo) {
            this.groupNo = groupNo;
        }

        public int getControlModule() {
            return controlModule;
        }

        public void setControlModule(int controlModule) {
            this.controlModule = controlModule;
        }

        public OpenOrClosePlanTask(){

        }

        public OpenOrClosePlanTask(int groupNo, int type, int controlModule){
            setGroupNo(groupNo);
            setType(type);
            setControlModule(controlModule);
        }

        @Override
        public void run() {
            DeviceService deviceService = context.getBean(DeviceService.class);
            Map<String, Object> filter = new HashMap<>();
            filter.put("type", "2");
            filter.put("groupNo", this.getGroupNo());
            List<Device> devices = deviceService.queryDevicesFilter(filter);
            if(devices != null && !devices.isEmpty()){
                for(Device device : devices){
                    GeneralProtocol.sendShieldCommand(device, this.getControlModule() + "");
                }
            }
        }
    }

}
