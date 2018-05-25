package com.jy.moudles.systemConfig.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.moudles.systemConfig.dao.SystemConfigDao;
import com.jy.moudles.systemConfig.entity.SystemConfig;
import com.jy.moudles.systemConfig.service.SystemConfigService;

@Service
public class SystemConfigServiceImpl implements SystemConfigService {

	@Autowired
	private SystemConfigDao systemConfigdao;
	
	@Override
	public void insertSystemConfig(SystemConfig systemConfig){
		systemConfigdao.insertSystemConfig(systemConfig);
	}
	
	@Override
	public void updateSystemConfig(SystemConfig systemConfig){
		systemConfigdao.updateSystemConfig(systemConfig);
	}
	
	@Override
	public SystemConfig getSystemConfigByKey(String key){
		return systemConfigdao.getSystemConfigByKey(key);
	}
	
	@Override
	public List<SystemConfig> querySystemConfigsFilter(Map<String, Object> filter){
		return systemConfigdao.querySystemConfigsFilter(filter);
	}
	
	@Override
	public void deleteSystemConfigByKey(String key){
		systemConfigdao.deleteSystemConfigByKey(key);
	}
	
	@Override
	public void deleteSystemConfigs(List<String> ids){
		systemConfigdao.deleteSystemConfigs(ids);
	}
	
}

