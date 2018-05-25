package com.jy.moudles.role.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.role.entity.Role;
import com.jy.common.persistence.annotation.MyBatisDao;


@MyBatisDao
public interface RoleDao {

	/**
\	 *
	 * @param role
	 */
	public void insertRole(Role role);
	
	/**
	 *
	 * @param role
	 */
	public void updateRole(Role role);
	
	/**
	 *
	 * @param id
	 */
	public Role getRoleById(String id);
	
	/**
	 *
	 * @param filter
	 */
	public List<Role> queryRolesFilter(Map<String, Object> filter);
	
	/**
	 *
	 * @param id
	 */
	public void deleteRoleById(String id);
	
	/**
	 *
	 * @param ids
	 */
	public void deleteRoles(List<String> ids);
	
}



