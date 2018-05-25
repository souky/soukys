package com.jy.moudles.device.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.device.dao.DeviceGroupDao;
import com.jy.moudles.device.entity.DeviceGroup;
import com.jy.moudles.device.service.DeviceGroupService;

@Service
public class DeviceGroupServiceImpl implements DeviceGroupService {

	@Autowired
	private DeviceGroupDao deviceGroupdao;
	
	@Override
	public Integer getMaxGroupNo(){
		return deviceGroupdao.getMaxGroupNo();
	}
	
	@Override
	public void insertDeviceGroup(DeviceGroup deviceGroup){
		deviceGroupdao.insertDeviceGroup(deviceGroup);
	}
	
	@Override
	public void updateDeviceGroup(DeviceGroup deviceGroup){
		deviceGroupdao.updateDeviceGroup(deviceGroup);
	}
	
	@Override
	public DeviceGroup getDeviceGroupById(String id){
		return deviceGroupdao.getDeviceGroupById(id);
	}
	
	@Override
	public List<DeviceGroup> queryDeviceGroupsFilter(Map<String, Object> filter){
		return deviceGroupdao.queryDeviceGroupsFilter(filter);
	}
	
	@Override
	public void deleteDeviceGroupById(String id){
		deviceGroupdao.deleteDeviceGroupById(id);
	}
	
	@Override
	public void deleteDeviceGroups(List<String> ids){
		deviceGroupdao.deleteDeviceGroups(ids);
	}
	
}

