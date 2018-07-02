package com.jy.moudles.targetInfo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.UserUtils;
import com.jy.moudles.targetInfo.entity.TargetInfo;
import com.jy.moudles.targetInfo.service.TargetInfoService;
import com.jy.moudles.user.entity.User;

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
	public AsyncResponseData.ResultData saveTargetInfo(TargetInfo targetinfo,
			HttpServletRequest request) throws Exception{
		logger.info("新增TargetInfo Start");
		
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		
		targetinfo.setUserId(user.getId());
		targetinfo.setCreateUser(user.getCreateUser());
		
		return targetinfoService.insertTargetInfo(targetinfo);
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
	 * 根据ID获取targetinfo对象
	 * 
	 * @param targetinfo
	 * @throws Exception
	 */
	@RequestMapping(value = "/targetNow", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData targetNow(HttpServletRequest request) throws Exception{
		logger.info("获取TargetInfo Start");
		
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		TargetInfo targetinfo = new TargetInfo();
		
		targetinfo = targetinfoService.getTargetNow(user.getId());
		
		logger.info("获取TargetInfo End");
		
		return AsyncResponseData.getSuccess(targetinfo);
	}
	
	/**
	 * 获取targetinfo对象
	 * 
	 * @param targetinfo
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryTargetInfos", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryTargetInfos(TargetInfo targetinfo,
			int pageNum,int pageSize,HttpServletRequest request) throws Exception{
		logger.info("获取TargetInfo Start");
		
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		filter.put("status", targetinfo.getStatus());
		filter.put("userId", user.getId());
		
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<TargetInfo> targetinfos = new PageInfo<TargetInfo>(
				targetinfoService.queryTargetInfosFilter(filter));
		
		logger.info("获取TargetInfo End");
		
		return AsyncResponseData.getSuccess(targetinfos);
	}
	
	/**
	 * 获取targetinfo对象
	 * 
	 * @param targetinfo
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryOtherTargetInfos", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryOrtherTargetInfos(TargetInfo targetinfo,
			int pageNum,int pageSize) throws Exception{
		logger.info("获取TargetInfo Start");
		
		//封装userId
		String id = targetinfo.getId();
		if(StringUtils.isBlank(id)) {
			return AsyncResponseData.getSuccess("");
		}
		Map<String, Object> filter = new HashMap<String, Object>();
		
		filter.put("userId", id);
		
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<TargetInfo> targetinfos = new PageInfo<TargetInfo>(
				targetinfoService.queryTargetInfosFilter(filter));
		
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
