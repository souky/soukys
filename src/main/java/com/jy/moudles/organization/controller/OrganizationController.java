package com.jy.moudles.organization.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.jy.common.utils.LogUtil;
import com.jy.moudles.organization.entity.OrganizationVO;
import com.jy.moudles.systemConfig.constant.SystemConfigConstants;
import com.jy.moudles.systemLog.constants.LogOperationType;
import com.jy.moudles.user.entity.User;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.organization.entity.Organization;
import com.jy.moudles.organization.service.OrganizationService;
import com.jy.moudles.statistics.entity.Region;
import com.jy.moudles.statistics.service.RegionService;
import com.jy.moudles.systemConfig.entity.SystemConfig;
import com.jy.moudles.systemConfig.service.SystemConfigService;

/** 
 * organization实现类
 *
 * 创建人：1
 * 创建时间：2017-06-08
 */
@Controller
@RequestMapping(value="/organization")
public class OrganizationController {
	
	@Autowired
	private OrganizationService organizationService;
	
	@Autowired
	private SystemConfigService systemconfigService;
	
	@Autowired
	private RegionService regionService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(OrganizationController.class);
	
	/**
	 * 新增organization对象
	 * 
	 * @param organization
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOrganization", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveOrganization(Organization organization,HttpServletRequest request) throws Exception{
    	LOGGER.info("新增组织机构开始");
    	if(StringUtils.isBlank(organization.getName()) || StringUtils.isBlank(organization.getIp())) {
    		return AsyncResponseData.getSuccess().asParamError("参数错误");
    	}
    	SystemConfig systemConfig = systemconfigService.getSystemConfigByKey(SystemConfigConstants.ORGANIZATION_ID);
    	if(systemConfig != null) {
    		return AsyncResponseData.getSuccess().asParamError("当前已有考点级组织机构");
    	}

    	Map<String,Object> filter = new HashMap<>();
    	filter.put("name", organization.getName());
    	List<Organization> organizations = organizationService.queryOrganizationsFilter(filter);
    	if(organizations != null && !organizations.isEmpty()){
    		return AsyncResponseData.getSuccess().asParamError("该组织机构名称已经存在");
		}
    	
    	Organization upperOrg = organizationService.getOrganizationById(organization.getParentId());
    	if(upperOrg != null){
    		Region region = regionService.getRegionByCode(upperOrg.getCode());
    		if(region != null && "4".equals(region.getRegionLevel())) {
    			String id = UUIDUtil.get32UUID();
    			organization.setId(id);
    			Date date = new Date();
    			User user = LoginInterceptor.getCurrentUser();
    			organization.setCreateUser(user.getId());
    			organization.setCreateDate(date);
    			organization.setUpdateUser(user.getId());
    			organization.setUpdateDate(date);
    			organizationService.insertOrganization(organization);
    			LogUtil.addLog("新增组织机构", LogOperationType.ADD,request);
    			
    			if(systemConfig == null) {
    				systemConfig = new SystemConfig();
    				systemConfig.setSysKey(SystemConfigConstants.ORGANIZATION_ID);
    				systemConfig.setSysValue(id);
    				systemconfigService.insertSystemConfig(systemConfig);
    			}
    			
    			LOGGER.info("新增组织机构结束");
    		}else {
    			return AsyncResponseData.getSuccess().asParamError("只能在区县下面新增组织机构");
    		}
    	}
    	
		return AsyncResponseData.getSuccess(organization);
	}
	
	/**
	 * 修改organization对象
	 * 
	 * @param organization
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateOrganization", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateOrganization(Organization organization,HttpServletRequest request) throws Exception{
    	LOGGER.info("修改组织机构开始");
    	if(StringUtils.isBlank(organization.getName()) || StringUtils.isBlank(organization.getIp())) {
    		return AsyncResponseData.getSuccess().asParamError("参数错误");
    	}
		Map<String,Object> filter = new HashMap<>();
		filter.put("name", organization.getName());
		List<Organization> organizations = organizationService.queryOrganizationsFilter(filter);
		if(organizations != null && !organizations.isEmpty()){
			Organization org = organizations.get(0);
			if(!org.getId().equals(organization.getId())){
				return AsyncResponseData.getSuccess().asParamError("该组织机构名称已经存在");
			}
			return AsyncResponseData.getSuccess().asParamError("该组织机构名称已经存在");
		}
		Date date = new Date();
		User user = LoginInterceptor.getCurrentUser();
		organization.setUpdateUser(user.getId());
		organization.setUpdateDate(date);
		organizationService.updateOrganization(organization);
		LogUtil.addLog("修改组织机构", LogOperationType.EDIT,request);
		LOGGER.info("修改组织机构结束");
		return AsyncResponseData.getSuccess(organization);
	}
	
	/**
	 * 删除organization对象
	 * 
	 * @param organization
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteOrganization", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteOrganization(Organization organization,HttpServletRequest request) throws Exception{
    	LOGGER.info("删除组织机构开始");
    	organization = organizationService.getOrganizationById(organization.getId());
    	if(organization != null) {
    		if(StringUtils.isNotBlank(organization.getCode())) {//新增的下级机构不设code值
    			return AsyncResponseData.getSuccess().asParamError("初始化组织机构不能删除");
    		}else {
    			organizationService.deleteOrganizationById(organization.getId());
	    		LogUtil.addLog("删除组织机构", LogOperationType.DELETE,request);
    			systemconfigService.deleteSystemConfigByKey(SystemConfigConstants.ORGANIZATION_ID);
    		}
    	}
		LOGGER.info("删除组织机构结束");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取organization对象
	 * 
	 * @param organization
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOrganizationById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getOrganizationById(Organization organization,HttpServletRequest request) throws Exception{
    	LOGGER.info("查看组织机构开始");
		
		Organization organizations = organizationService.getOrganizationById(organization.getId());
		
		LOGGER.info("查看组织机构结束");
		return AsyncResponseData.getSuccess(organizations);
	}
	
	/**
	 * 获取organization对象
	 * 树形展示
	 * @param userId
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryOrganizations", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryOrganizations(String userId,HttpServletRequest request) throws Exception{
    	LOGGER.info("获取组织机构开始");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		List<Organization> orgList = organizationService.queryOrganizationsFilter(filter);
		//根据user获取用户管理的机构ids
		List<Organization> ids = organizationService.queryOwnOrgByUserId(userId);
		
		List<OrganizationVO> orgVoList = new ArrayList<OrganizationVO>();
		for (Organization org : orgList) {
			OrganizationVO orgVo = new OrganizationVO(org);
			for (Organization organization : ids) {
				if(org.getId().equals(organization.getId())){
					orgVo.setChecked(true);
				}
			}
			orgVo.setOpen(false);
			orgVoList.add(orgVo);
		}
		
		LOGGER.info("获取组织机构--树形展示结束");
		
		return AsyncResponseData.getSuccess(orgVoList);
	}

	/**
	 * 获取organization对象,非树形展示
	 *
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOrganizations", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getOrganizations() throws Exception{
		Map<String, Object> filter = new HashMap<String, Object>();
		List<Organization> orgList = organizationService.queryOrganizationsFilter(filter);
		LOGGER.info("获取组织机构--非树形展示结束");
		return AsyncResponseData.getSuccess(orgList);
	}
	
}
