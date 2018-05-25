package com.jy.moudles.permission.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.permission.dao.PermissionDao;
import com.jy.moudles.permission.entity.Permission;
import com.jy.moudles.permission.service.PermissionService;

/** 
 * Permission业务实现类
 * 创建人：Administrator
 * 创建时间：2018-05-24
 */
@Service
public class PermissionServiceImpl implements PermissionService {

	@Autowired
	private PermissionDao PermissionDao;
	
	@Override
	public void insertPermission(Permission Permission){
		Permission.setId(UUIDUtil.get32UUID());
		PermissionDao.insertPermission(Permission);
	}
	
	@Override
	public void updatePermission(Permission Permission){
		PermissionDao.updatePermission(Permission);
	}
	
	@Override
	public Permission getPermissionById(String id){
		return PermissionDao.getPermissionById(id);
	}
	
	@Override
	public List<Permission> queryPermissionsFilter(Map<String, Object> filter){
		return PermissionDao.queryPermissionsFilter(filter);
	}
	
	@Override
	public void deletePermissionById(String id){
		PermissionDao.deletePermissionById(id);
	}
	
	@Override
	public void deletePermissions(List<String> ids){
		PermissionDao.deletePermissions(ids);
	}
	
}

