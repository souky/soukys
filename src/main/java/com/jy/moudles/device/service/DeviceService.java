package com.jy.moudles.device.service;

import com.jy.moudles.device.entity.Device;
import com.jy.moudles.statistics.entity.DeviceCollectVO;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

/** 
 * xipeng
 * 2017-10-17
 */
public interface DeviceService {

	void clearDeviceData();
	
	void deleteDeviceGroupNo(String id);
	
	void addDeviceGroupNo(String id,List<String> list);
	
	/**
	 * 
	 * @param id 设备分组id
	 * @return
	 */
	List<Device> queryDevicesByGroupNo(String id);

	List<DeviceCollectVO> queryDeviceCount();
	
	/**
	 *
	 * @param device
	 */
	public void insertDevice(Device device);
	
	/**
	 *
	 * @param device
	 */
	public void updateDevice(Device device);
	
	/**
	 *
	 * @param id
	 */
	public Device getDeviceById(String id);
	
	/**
	 *
	 * @param filter
	 */
	public List<Device> queryDevicesFilter(Map<String, Object> filter);
	
	/**
	 *
	 * @param id
	 */
	public void deleteDeviceById(String id);
	
	/**
	 *
	 * @param ids
	 */
	public void deleteDevices(List<String> ids);
	
	/**
	 * 导出设备列表的Excel文件
	 *
	 * @param response
	 */
	public void getEquipmentsList(HttpServletResponse response,Map<String, Object> filter);
	
	/**
	 * 开启关闭选中设备
	 * @param
	 */
	public void openOrCloseSelectedDevices(Map<String,Object> params);
	
	/**
	 * 开启关闭全部设备
	 * @param operationType
	 */
	public void openOrCloseAllDevices(String operationType);
	
	public Device getDeviceByMac(String mac);

	List<Device> getDeviceListByIds(List<String> ids);
	
	public void updateDeviceByMac(Device device);
	
	/**
	 * 协议专用更新文件
	 * */
	public void updateDeviceStatusOnAgreement();
	
	void deleteDevicesByKafka(Map<String,Object> filter);

	void insertDevicesBatch(List<Device> list);

	List<Device> queryDevicesByListOrder();

    List<String> queryIPs();

    void updateShieldListOrder(Map<String,Object> filter);
}

