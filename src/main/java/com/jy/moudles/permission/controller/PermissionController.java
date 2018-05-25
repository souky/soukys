package com.jy.moudles.permission.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.jy.common.utils.LogUtil;
import com.jy.moudles.systemLog.constants.LogOperationType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.permission.entity.Permission;
import com.jy.moudles.permission.entity.PermissionVO;
import com.jy.moudles.permission.service.PermissionService;
import com.jy.moudles.role.entity.Role;
import com.jy.moudles.role.service.RoleService;

/** 
 * permisson实现类
 *
 * 创建人：wb
 * 创建时间：2017-06-05
 */
@Controller
@RequestMapping(value="/permission")
public class PermissionController {
	
	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private RoleService roleService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PermissionController.class);
	
	/**
	 * 获取permisson对象
	 * 
	 * @param roleId
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryPermissions", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryPermissions(String roleId,HttpServletRequest request) throws Exception{
    	LOGGER.info("获取权限列表开始");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<Permission> permissions = permissionService.queryPermissonsFilter(filter);
		List<Permission> roleRermissions = permissionService.queryRolePermissonsByRoleId(roleId);
		
		// 父ID集合
		List<String> ids = new ArrayList<String>();
		for (Permission permission : permissions) {
			if (!ids.contains(permission.getParentId())){
				ids.add(permission.getParentId());
			}
		}
		List<PermissionVO> vos = new ArrayList<PermissionVO>();
		
		for (Permission permission : permissions) {
			PermissionVO vo = new PermissionVO(permission);
			for (Permission roleRermission : roleRermissions) {
				if (roleRermission.getId().equalsIgnoreCase(permission.getId())) {
					vo.setChecked(true);
				}
			}
			if (ids.contains(permission.getId())) {
				vo.setOpen(true);
			}
			vos.add(vo);
		}
		LOGGER.info("获取权限列表结束");
		
		return AsyncResponseData.getSuccess(vos);
	}
	
	@RequestMapping(value = "/getPermissions", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getPermissions(HttpServletRequest request) throws Exception{
    	LOGGER.info("获取权限列表开始");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<Permission> permissions = permissionService.queryPermissonsFilter(filter);
		LOGGER.info("获取权限列表结束");
		
		return AsyncResponseData.getSuccess(permissions);
	}
	
	@RequestMapping(value = "/grentPermissions", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData grentPermissions(String roleId, String[] ids,HttpServletRequest request){
		LOGGER.info("角色授权开始");
		Role role = roleService.getRoleById(roleId);
		
		if (role != null && 0 != role.getIsDelete()) {
			return AsyncResponseData.getSuccess().asParamError("该角色不存在.");
		}
		//先清空角色-权限关系,在重新插入
		permissionService.deleteRolePermissionRelationByRoleId(roleId);
		permissionService.batchInsertRolePermissionRelation(roleId, Arrays.asList(ids));
		LogUtil.addLog("角色授权", LogOperationType.AUTHORIZE,request);
		LOGGER.info("角色授权结束");
		return AsyncResponseData.getSuccess();
	}
	
}
