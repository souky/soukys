package com.jy.moudles.role.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.moudles.role.dao.RoleDao;
import com.jy.moudles.role.entity.Role;
import com.jy.moudles.role.service.RoleService;


@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleDao roledao;
	
	@Override
	public void insertRole(Role role){
		roledao.insertRole(role);
	}
	
	@Override
	public void updateRole(Role role){
		roledao.updateRole(role);
	}
	
	@Override
	public Role getRoleById(String id){
		return roledao.getRoleById(id);
	}
	
	@Override
	public List<Role> queryRolesFilter(Map<String, Object> filter){
		return roledao.queryRolesFilter(filter);
	}
	
	@Override
	public void deleteRoleById(String id){
		roledao.deleteRoleById(id);
	}
	
	@Override
	public void deleteRoles(List<String> ids){
		roledao.deleteRoles(ids);
	}
	
}

