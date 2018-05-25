package com.jy.moudles.statistics.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.moudles.statistics.dao.RegionDao;
import com.jy.moudles.statistics.entity.Region;
import com.jy.moudles.statistics.service.RegionService;

@Service
public class RegionServiceImpl implements RegionService{

	@Autowired
	private RegionDao regiondao;
	
	@Override
	public String getCodeByName(String name) {
		Region nc = regiondao.getCodeByName(name);
		if(nc==null)
			return "";
		else
		return nc.getRegionCode();
	}

	@Override
	public Region getRegionByCode(String code) {
		return regiondao.getRegionByCode(code);
	}
	
	@Override
	public Region getRegionById(String id) {
		return regiondao.getRegionById(id);
	}
	
	@Override
	public List<Region> getRegionByPid(String pid) {
		return regiondao.getRegionByPid(pid);
	}

	@Override
	public List<Region> queryRegionsFilter(Map<String, Object> filter) {
		return regiondao.queryRegionsFilter(filter);
	}
}
