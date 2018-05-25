package com.jy.moudles.device.VO;

import com.jy.moudles.device.entity.Device;

import java.util.List;
import java.util.Map;

/**
 * Created by wb on 2018/1/9 16:10
 */
public class ResDeviceVO {

    private Map<Integer, Device> deviceMaps;

    private List<Device> devices;

    public Map<Integer, Device> getDeviceMaps() {
        return deviceMaps;
    }

    public void setDeviceMaps(Map<Integer, Device> deviceMaps) {
        this.deviceMaps = deviceMaps;
    }

    public List<Device> getDevices() {
        return devices;
    }

    public void setDevices(List<Device> devices) {
        this.devices = devices;
    }
}
