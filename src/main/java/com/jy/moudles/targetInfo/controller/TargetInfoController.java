package com.jy.moudles.targetInfo.controller;

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
import com.jy.moudles.targetInfo.entity.TargetInfo;
import com.jy.moudles.targetInfo.service.TargetInfoService;

/** 
 * TargetInfo实现类
 *
 * 创建人：Administrator
 * 创建时间：2018-05-25
 */
@Controller
@RequestMapping(value="/targetinfo")
public class TargetInfoController {
	
	@Autowired
	private TargetInfoService targetinfoService;
	
	private static final Logger logger = LoggerFactory.getLogger(TargetInfoController.class);
	
	/**
	 * 新增targetinfo对象
	 * 
	 * @param targetinfo
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveTargetInfo", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveTargetInfo(TargetInfo targetinfo) throws Exception{
		logger.info("新增TargetInfo Start");
		
		targetinfoService.insertTargetInfo(targetinfo);
		
		logger.info("新增TargetInfo End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 修改targetinfo对象
	 * 
	 * @param targetinfo
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateTargetInfo", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateTargetInfo(TargetInfo targetinfo) throws Exception{
		logger.info("修改TargetInfo Start");
		
		targetinfoService.updateTargetInfo(targetinfo);
		
		logger.info("修改TargetInfo End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除targetinfo对象
	 * 
	 * @param targetinfo
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteTargetInfo", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteTargetInfo(TargetInfo targetinfo) throws Exception{
		logger.info("删除TargetInfo Start");
		
		targetinfoService.deleteTargetInfoById(targetinfo.getId());
		
		logger.info("删除TargetInfo End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取targetinfo对象
	 * 
	 * @param targetinfo
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryTargetInfos", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryTargetInfos(TargetInfo targetinfo) throws Exception{
		logger.info("获取TargetInfo Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<TargetInfo> targetinfos= targetinfoService.queryTargetInfosFilter(filter);
		logger.info("获取TargetInfo End");
		
		return AsyncResponseData.getSuccess(targetinfos);
	}
	
	/**
	 * 根据ID获取targetinfo对象
	 * 
	 * @param targetinfo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTargetInfoById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getTargetInfoById(String id) throws Exception{
		logger.info("获取TargetInfo Start");
		
		TargetInfo targetinfo = new TargetInfo();
		
		targetinfo = targetinfoService.getTargetInfoById(id);
		
		logger.info("获取TargetInfo End");
		
		return AsyncResponseData.getSuccess(targetinfo);
	}
	
}
