package com.jy.moudles.permission.service;

import java.util.List;
import java.util.Map;

import com.jy.moudles.permission.entity.Permission;

/** 
 * permisson业务接口
 * 创建人：1
 * 创建时间：2017-06-05
 */
public interface PermissionService {

	/**
	 * 根据ID获取permisson对象
	 *
	 * @param id
	 */
	public Permission getPermissonById(String id);
	
	/**
	 * 根据过滤条件获取permisson列表对象
	 *
	 * @param filter
	 */
	public List<Permission> queryPermissonsFilter(Map<String, Object> filter);
	
	/**
	 * 根据角色ID获取角色所有的用户权限
	 * @param roleId
	 * @return
	 */
	public List<Permission> queryRolePermissonsByRoleId(String roleId);
	
	/**
	 * 新增角色权限关系表
	 * 
	 * @param roleId
	 * @param ids
	 */
	public void batchInsertRolePermissionRelation(String roleId, List<String> ids);
	
	/**
	 * 根据角色Id删除角色权限表
	 * 
	 * @param roleId
	 */
	public void deleteRolePermissionRelationByRoleId(String roleId);
	
}

