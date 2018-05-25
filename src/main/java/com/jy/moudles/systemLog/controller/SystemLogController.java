package com.jy.moudles.systemLog.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.systemLog.entity.SystemLog;
import com.jy.moudles.systemLog.service.SystemLogService;

/** 
 * SystemLog实现类
 *
 * 创建人：wb
 * 创建时间：2017-10-14
 */
@Controller
@RequestMapping(value="/systemlog")
public class SystemLogController {
	
	@Autowired
	private SystemLogService systemlogService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SystemLogController.class);
	
	/**
	 * 新增systemlog对象
	 * 
	 * @param systemlog
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveSystemLog", method = RequestMethod.POST)
	public AsyncResponseData.ResultData saveSystemLog(SystemLog systemlog) throws Exception{
		LOGGER.info("新增SystemLog Start");
		
		systemlogService.insertSystemLog(systemlog);
		
		LOGGER.info("新增SystemLog End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取systemlog对象
	 * 
	 * @param systemlog
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/querySystemLogs", method = RequestMethod.POST)
	public ModelAndView querySystemLogs(SystemLog systemlog,HttpServletRequest request,int pageNum,int pageSize) throws Exception{
		LOGGER.info("获取SystemLog Start");
		ModelAndView mv = new ModelAndView("log/showLogPost");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		String userName = request.getParameter("userName");
		String operationEvent = request.getParameter("operationEvent");
		filter.put("userName", userName);
		filter.put("operationEvent", operationEvent);
		PageHelper.startPage(pageNum, pageSize);
		List<SystemLog> systemlogs= systemlogService.querySystemLogsFilter(filter);
		PageInfo<SystemLog> pageInfo = new PageInfo<SystemLog>(systemlogs);
		mv.addObject("pageNow", pageInfo.getPageNum());
		mv.addObject("pageTotal", pageInfo.getPages());
		mv.addObject("logList", pageInfo.getList());
		
		LOGGER.info("获取SystemLog End");
		
		return mv;
	}
	
}
