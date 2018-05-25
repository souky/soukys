package com.jy.moudles.device.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.device.entity.DeviceGroup;
import com.jy.common.persistence.annotation.MyBatisDao;

@MyBatisDao
public interface DeviceGroupDao {

	
	Integer getMaxGroupNo();
	
	/**
	 *
	 * @param deviceGroup
	 */
	public void insertDeviceGroup(DeviceGroup deviceGroup);
	
	/**
	 *
	 * @param deviceGroup
	 */
	public void updateDeviceGroup(DeviceGroup deviceGroup);
	
	/**
	 *
	 * @param id
	 */
	public DeviceGroup getDeviceGroupById(String id);
	
	/**
	 *
	 * @param filter
	 */
	public List<DeviceGroup> queryDeviceGroupsFilter(Map<String, Object> filter);
	
	/**
	 *
	 * @param id
	 */
	public void deleteDeviceGroupById(String id);
	
	/**
	 *
	 * @param ids
	 */
	public void deleteDeviceGroups(List<String> ids);
	
}



