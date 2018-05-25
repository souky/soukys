package com.jy.moudles.org.controller;

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
import com.jy.moudles.org.entity.Org;
import com.jy.moudles.org.service.OrgService;

/** 
 * Org实现类
 *
 * 创建人：Administrator
 * 创建时间：2018-05-24
 */
@Controller
@RequestMapping(value="/org")
public class OrgController {
	
	@Autowired
	private OrgService orgService;
	
	private static final Logger logger = LoggerFactory.getLogger(OrgController.class);
	
	/**
	 * 新增org对象
	 * 
	 * @param org
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOrg", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveOrg(Org org) throws Exception{
		logger.info("新增Org Start");
		
		orgService.insertOrg(org);
		
		logger.info("新增Org End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 修改org对象
	 * 
	 * @param org
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateOrg", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateOrg(Org org) throws Exception{
		logger.info("修改Org Start");
		
		orgService.updateOrg(org);
		
		logger.info("修改Org End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除org对象
	 * 
	 * @param org
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteOrg", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteOrg(Org org) throws Exception{
		logger.info("删除Org Start");
		
		orgService.deleteOrgById(org.getId());
		
		logger.info("删除Org End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取org对象
	 * 
	 * @param org
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryOrgs", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryOrgs(Org org) throws Exception{
		logger.info("获取Org Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<Org> orgs= orgService.queryOrgsFilter(filter);
		logger.info("获取Org End");
		
		return AsyncResponseData.getSuccess(orgs);
	}
	
	/**
	 * 根据ID获取org对象
	 * 
	 * @param org
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOrgById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getOrgById(String id) throws Exception{
		logger.info("获取Org Start");
		
		Org org = new Org();
		
		org = orgService.getOrgById(id);
		
		logger.info("获取Org End");
		
		return AsyncResponseData.getSuccess(org);
	}
	
}
