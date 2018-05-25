package com.jy.moudles.statistics.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.statistics.entity.Region;
import com.jy.moudles.statistics.service.RegionService;

/** 
 *	@author wb
 */
@Controller
@RequestMapping(value="/region")
public class RegionController {
	
	@Autowired
	private RegionService regionService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RegionController.class);
	
	
	
	/**
	 * 
	 * @param region
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryRegions", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryRegions(Region region) throws Exception{
		LOGGER.info("查询区域 Region Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("regionPId", region.getRegionPId());
		
		List<Region> regions= regionService.queryRegionsFilter(filter);
		
		LOGGER.info("查询区域 Region End");
		
		return AsyncResponseData.getSuccess(regions);
	}
	
}
