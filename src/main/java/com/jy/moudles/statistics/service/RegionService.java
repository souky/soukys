package com.jy.moudles.statistics.service;

import java.util.List;
import java.util.Map;

import com.jy.moudles.statistics.entity.Region;

/** 
 * SuspiciousSignal数据接口
 * 创建人：1
 * 创建时间：2017-08-17
 */

public interface RegionService {
	
	/**
	 *
	 * @param filter
	 */
	public List<Region> queryRegionsFilter(Map<String, Object> filter);

	public String getCodeByName(String name);
	
	public Region getRegionByCode(String code);
	
	public List<Region> getRegionByPid(String pid);
	
	public Region getRegionById(String id);
}



