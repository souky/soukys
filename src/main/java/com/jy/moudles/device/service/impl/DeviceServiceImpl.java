package com.jy.moudles.device.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.jy.common.excelUtil.ExportExcel;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.device.dao.DeviceDao;
import com.jy.moudles.device.entity.Device;
import com.jy.moudles.device.service.DeviceService;
import com.jy.moudles.statistics.entity.DeviceCollectVO;

/** 
 * xipeng
 * 2017-10-17
 */
@Service
public class DeviceServiceImpl implements DeviceService {

	@Autowired
	private DeviceDao devicedao;
	
	@Override
	public void insertDevice(Device device){
		device.setId(UUIDUtil.get32UUID());
		devicedao.insertDevice(device);
	}
	
	@Override
	public void updateDevice(Device device){
		devicedao.updateDevice(device);
	}
	
	@Override
	public Device getDeviceById(String id){
		return devicedao.getDeviceById(id);
	}
	
	@Override
	public List<Device> queryDevicesFilter(Map<String, Object> filter){
		return devicedao.queryDevicesFilter(filter);
	}
	
	@Override
	public void deleteDeviceById(String id){
		devicedao.deleteDeviceById(id);
	}
	
	@Override
	public void deleteDevices(List<String> ids){
		devicedao.deleteDevices(ids);
	}

	@Override
	public void getEquipmentsList(HttpServletResponse response,
			Map<String, Object> filter) {
		List<Device> deviceList = devicedao.queryDevicesFilter(filter);
		ExportExcel ee = new ExportExcel("这是设备列表文件的标题",Device.class);
		ee.setDataList(deviceList);
		try {
			ee.write(response,"DeviceList.xlsx" );
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void openOrCloseSelectedDevices(Map<String,Object> params) {
		devicedao.openOrCloseSelectedDevices(params);
	}
	
	@Override
	public void openOrCloseAllDevices(String operationType) {
		devicedao.openOrCloseAllDevices(operationType);
		
	}
	
	 @Override
	public Device getDeviceByMac(String mac) {
		return devicedao.getDeviceByMac(mac);
	}

	@Override
	public List<Device> getDeviceListByIds(List<String> ids){
		return devicedao.getDeviceListByIds(ids);
	}

	@Override
	public List<DeviceCollectVO> queryDeviceCount() {
		return devicedao.queryDeviceCount();
	}
	
	/**
	 * 
	 * @param id 设备分组id
	 * @return
	 */
	@Override
	public List<Device> queryDevicesByGroupNo(String id){
		return devicedao.queryDevicesByGroupNo(id);
	}

	@Override
	public void deleteDeviceGroupNo(String id) {
		devicedao.deleteDeviceGroupNo(id);
	}

	@Override
	public void addDeviceGroupNo(String id, List<String> list) {
		devicedao.addDeviceGroupNo(id, list);		
	}
	@Override
	public void updateDeviceByMac(Device device) {
		devicedao.updateDeviceByMac(device);
	};
	
	@Override
	public void updateDeviceStatusOnAgreement() {
		devicedao.updateDeviceStatusOnAgreement();
	}

	@Override	
	public void deleteDevicesByKafka(Map<String, Object> filter) {
		devicedao.deleteDevicesByKafka(filter);
	}

	@Override
	public void insertDevicesBatch(List<Device> list) {
		if(list != null && list.size() > 0){
			devicedao.insertDevicesBatch(list);
		}
	}

	@Override
	public void clearDeviceData() {
		devicedao.clearDeviceData();
	}

	@Override
	public List<Device> queryDevicesByListOrder(){
		return devicedao.queryDevicesByListOrder();
	}

	@Override
    public List<String> queryIPs(){
	    return devicedao.queryIPs();
    }

    @Override
    public void updateShieldListOrder(Map<String,Object> filter){
	    devicedao.updateShieldListOrder(filter);
    }
}

