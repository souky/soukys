package com.jy.moudles.permission.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.permission.dao.PermissionDao;
import com.jy.moudles.permission.entity.Permission;
import com.jy.moudles.permission.service.PermissionService;
import com.jy.moudles.user.entity.User;

/** 
 * permisson业务实现类
 * 创建人：1
 * 创建时间：2017-06-05
 */
@Service
public class PermissionServiceImpl implements PermissionService {

	@Autowired
	private PermissionDao permissiondao;
	
	@Override
	public Permission getPermissonById(String id){
		return permissiondao.getPermissonById(id);
	}
	
	@Override
	public List<Permission> queryPermissonsFilter(Map<String, Object> filter){
		return permissiondao.queryPermissonsFilter(filter);
	}

	@Override
	public List<Permission> queryRolePermissonsByRoleId(String roleId) {
		return permissiondao.queryRolePermissonsByRoleId(roleId);
	}

	@Override
	public void batchInsertRolePermissionRelation(String roleId, List<String> ids) {
		// 删除已有的权限
		permissiondao.deleteRolePermissionRelationByRoleId(roleId);
		User user = LoginInterceptor.getCurrentUser();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for (String id : ids){
			Map<String, Object> filter = new HashMap<String, Object>();
			filter.put("id", UUIDUtil.get32UUID());
			filter.put("roleId", roleId);
			filter.put("permissionId", id);
			filter.put("user", user.getId());
			list.add(filter);
		}
		
		permissiondao.batchInsertRolePermissionRelation(list);
	}

	@Override
	public void deleteRolePermissionRelationByRoleId(String roleId) {
		permissiondao.deleteRolePermissionRelationByRoleId(roleId);
	}

}

