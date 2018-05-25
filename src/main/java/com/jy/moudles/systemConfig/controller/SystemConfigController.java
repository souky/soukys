package com.jy.moudles.systemConfig.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jy.moudles.systemConfig.constant.SystemConfigConstants;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.organization.entity.Organization;
import com.jy.moudles.organization.service.OrganizationService;
import com.jy.moudles.systemConfig.VO.OrgConfigVO;
import com.jy.moudles.systemConfig.entity.SystemConfig;
import com.jy.moudles.systemConfig.service.SystemConfigService;

/** 
 * systemConfig
 * @author wb
 */
@Controller
@RequestMapping(value="/systemconfig")
public class SystemConfigController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SystemConfigController.class);
	
	@Autowired
	private SystemConfigService systemconfigService;
	
	@Autowired
	private OrganizationService organizationService;
	
	@RequestMapping(value = "/saveSystemConfig", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveSystemConfig(SystemConfig systemconfig) throws Exception{
		LOGGER.info("保存 systemConfig");
		if(systemconfig != null && StringUtils.isNoneBlank(systemconfig.getSysKey())) {
			systemconfigService.insertSystemConfig(systemconfig);	
			LOGGER.info("保存 systemConfig 成功");
		}
		
		return AsyncResponseData.getSuccess();
	}
	
	@RequestMapping(value = "/insertOrgConfig", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData insertOrgConfig(OrgConfigVO orgConfigVO) throws Exception{
		LOGGER.info("保存 systemConfig");
		String isExamSpot = orgConfigVO.getIsExamSpot();
		String provinceCode = orgConfigVO.getProvinceCode();
		String cityCode = orgConfigVO.getCityCode();
		String areaCode = orgConfigVO.getAreaCode();
		//考点级
		String id = "";
		Organization organization = null;
		if("Y".equals(isExamSpot)) {
			if(StringUtils.isBlank(orgConfigVO.getOrgIp()) || StringUtils.isBlank(orgConfigVO.getOrgName())) {
				return AsyncResponseData.getSuccess().asParamError("参数错误");
			}
			
			if(StringUtils.isNoneBlank(areaCode)) {
				organization = organizationService.getOrgByCode(areaCode);
				if(organization != null) {
					Organization org = new Organization();
					id = UUIDUtil.get32UUID();
					org.setId(id);
					org.setParentId(organization.getId());
					org.setName(orgConfigVO.getOrgName());
					org.setIp(orgConfigVO.getOrgIp());
					org.setCreateDate(new Date());
					org.setCreateUser("");
					organizationService.insertOrganization(organization);
					
				}
			}
			
		}else if("N".equals(isExamSpot)) {
			if(StringUtils.isNoneBlank(areaCode)) {
				organization = organizationService.getOrgByCode(areaCode);
				if(organization != null) {
					id = organization.getId();
				}
			}else if(StringUtils.isNoneBlank(cityCode)) {
				organization = organizationService.getOrgByCode(cityCode);
				if(organization != null) {
					id = organization.getId();
				}
			}else if(StringUtils.isNoneBlank(provinceCode)) {
				organization = organizationService.getOrgByCode(provinceCode);
				if(organization != null) {
					id = organization.getId();
				}
			}
		}else {
			return AsyncResponseData.getSuccess().asParamError("网络错误");
		}
		
		SystemConfig systemConfig = systemconfigService.getSystemConfigByKey(SystemConfigConstants.ORGANIZATION_ID);
		if(systemConfig == null) {
			systemConfig = new SystemConfig();
			systemConfig.setSysKey(SystemConfigConstants.ORGANIZATION_ID);
			systemConfig.setSysValue(id);
			systemconfigService.insertSystemConfig(systemConfig);
		}else {
			systemConfig.setSysValue(id);
			systemconfigService.updateSystemConfig(systemConfig);
		}
		
		
		
		return AsyncResponseData.getSuccess();
	}
	
	@RequestMapping(value = "/updateSystemConfig", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateSystemConfig(SystemConfig systemconfig) throws Exception{
		
		systemconfigService.updateSystemConfig(systemconfig);
		
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 
	 * @param systemconfig
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteSystemConfig", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteSystemConfig(SystemConfig systemconfig) throws Exception{
		
		systemconfigService.deleteSystemConfigByKey(systemconfig.getSysKey());
		
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 
	 * @param systemconfig
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/querySystemConfigs", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData querySystemConfigs(SystemConfig systemconfig) throws Exception{
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<SystemConfig> systemconfigs= systemconfigService.querySystemConfigsFilter(filter);
		
		return AsyncResponseData.getSuccess(systemconfigs);
	}
	
}
