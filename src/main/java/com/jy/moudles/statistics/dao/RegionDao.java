package com.jy.moudles.statistics.dao;

import java.util.List;
import java.util.Map;

import com.jy.common.persistence.annotation.MyBatisDao;
import com.jy.moudles.statistics.entity.Region;

/** 
 * 创建人：1
 * 创建时间：2017-08-17
 */
@MyBatisDao
public interface RegionDao {
	
	/**
	 *
	 * @param filter
	 */
	public List<Region> queryRegionsFilter(Map<String, Object> filter);
	
	public Region getCodeByName(String name);
	
	public Region getRegionByCode(String code);
	
	public List<Region> getRegionByPid(String pid);
	
	public Region getRegionById(String id);
}



