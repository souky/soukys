package com.jy.moudles.punchClock.controller;

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
import com.jy.moudles.punchClock.entity.PunchClock;
import com.jy.moudles.punchClock.service.PunchClockService;

/** 
 * PunchClock实现类
 *
 * 创建人：Administrator
 * 创建时间：2018-05-25
 */
@Controller
@RequestMapping(value="/punchclock")
public class PunchClockController {
	
	@Autowired
	private PunchClockService punchclockService;
	
	private static final Logger logger = LoggerFactory.getLogger(PunchClockController.class);
	
	/**
	 * 新增punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/savePunchClock", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData savePunchClock(PunchClock punchclock) throws Exception{
		logger.info("新增PunchClock Start");
		
		punchclockService.insertPunchClock(punchclock);
		
		logger.info("新增PunchClock End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 修改punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePunchClock", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updatePunchClock(PunchClock punchclock) throws Exception{
		logger.info("修改PunchClock Start");
		
		punchclockService.updatePunchClock(punchclock);
		
		logger.info("修改PunchClock End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePunchClock", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deletePunchClock(PunchClock punchclock) throws Exception{
		logger.info("删除PunchClock Start");
		
		punchclockService.deletePunchClockById(punchclock.getId());
		
		logger.info("删除PunchClock End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryPunchClocks", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryPunchClocks(PunchClock punchclock) throws Exception{
		logger.info("获取PunchClock Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<PunchClock> punchclocks= punchclockService.queryPunchClocksFilter(filter);
		logger.info("获取PunchClock End");
		
		return AsyncResponseData.getSuccess(punchclocks);
	}
	
	/**
	 * 根据ID获取punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/getPunchClockById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getPunchClockById(String id) throws Exception{
		logger.info("获取PunchClock Start");
		
		PunchClock punchclock = new PunchClock();
		
		punchclock = punchclockService.getPunchClockById(id);
		
		logger.info("获取PunchClock End");
		
		return AsyncResponseData.getSuccess(punchclock);
	}
	
}
