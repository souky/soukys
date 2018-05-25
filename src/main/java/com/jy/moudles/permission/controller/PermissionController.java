package com.jy.moudles.permission.controller;

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
import com.jy.moudles.permission.entity.Permission;
import com.jy.moudles.permission.service.PermissionService;

/** 
 * Permission实现类
 *
 * 创建人：Administrator
 * 创建时间：2018-05-24
 */
@Controller
@RequestMapping(value="/permission")
public class PermissionController {
	
	@Autowired
	private PermissionService permissionService;
	
	private static final Logger logger = LoggerFactory.getLogger(PermissionController.class);
	
	/**
	 * 新增permission对象
	 * 
	 * @param permission
	 * @throws Exception
	 */
	@RequestMapping(value = "/savePermission", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData savePermission(Permission permission) throws Exception{
		logger.info("新增Permission Start");
		
		permissionService.insertPermission(permission);
		
		logger.info("新增Permission End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 修改permission对象
	 * 
	 * @param permission
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePermission", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updatePermission(Permission permission) throws Exception{
		logger.info("修改Permission Start");
		
		permissionService.updatePermission(permission);
		
		logger.info("修改Permission End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除permission对象
	 * 
	 * @param permission
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePermission", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deletePermission(Permission permission) throws Exception{
		logger.info("删除Permission Start");
		
		permissionService.deletePermissionById(permission.getId());
		
		logger.info("删除Permission End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取permission对象
	 * 
	 * @param permission
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryPermissions", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryPermissions(Permission permission) throws Exception{
		logger.info("获取Permission Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<Permission> permissions= permissionService.queryPermissionsFilter(filter);
		logger.info("获取Permission End");
		
		return AsyncResponseData.getSuccess(permissions);
	}
	
	/**
	 * 根据ID获取permission对象
	 * 
	 * @param permission
	 * @throws Exception
	 */
	@RequestMapping(value = "/getPermissionById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getPermissionById(String id) throws Exception{
		logger.info("获取Permission Start");
		
		Permission permission = new Permission();
		
		permission = permissionService.getPermissionById(id);
		
		logger.info("获取Permission End");
		
		return AsyncResponseData.getSuccess(permission);
	}
	
}
