package com.jy.moudles.permission.service;

import com.jy.moudles.permission.entity.Permission;
import java.util.List;
import java.util.Map;

/** 
 * Permission业务接口
 * 创建人：Administrator
 * 创建时间：2018-05-24
 */
public interface PermissionService {

	/**
	 * 新增Permission对象
	 *
	 * @param Permission
	 */
	public void insertPermission(Permission Permission);
	
	/**
	 * 更新Permission对象
	 *
	 * @param Permission
	 */
	public void updatePermission(Permission Permission);
	
	/**
	 * 根据ID获取Permission对象
	 *
	 * @param id
	 */
	public Permission getPermissionById(String id);
	
	/**
	 * 根据过滤条件获取Permission列表对象
	 *
	 * @param filter
	 */
	public List<Permission> queryPermissionsFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除Permission列表对象
	 *
	 * @param id
	 */
	public void deletePermissionById(String id);
	
	/**
	 * 根据Id集合批量删除Permission列表对象
	 *
	 * @param ids
	 */
	public void deletePermissions(List<String> ids);
	
}

