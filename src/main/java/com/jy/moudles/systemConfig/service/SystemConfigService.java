package com.jy.moudles.systemConfig.service;

import com.jy.moudles.systemConfig.entity.SystemConfig;
import java.util.List;
import java.util.Map;

public interface SystemConfigService {

	/**
	 * @param systemConfig
	 */
	public void insertSystemConfig(SystemConfig systemConfig);
	
	/**
	 * @param systemConfig
	 */
	public void updateSystemConfig(SystemConfig systemConfig);
	
	/**
	 * @param key
	 */
	public SystemConfig getSystemConfigByKey(String key);
	
	/**
	 * @param filter
	 */
	public List<SystemConfig> querySystemConfigsFilter(Map<String, Object> filter);
	
	/**
	 * @param key
	 */
	public void deleteSystemConfigByKey(String key);
	
	/**
	 * @param ids
	 */
	public void deleteSystemConfigs(List<String> ids);
	
}

