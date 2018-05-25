package com.jy.moudles.organization.service;

import java.util.List;
import java.util.Map;

import com.jy.moudles.organization.entity.Organization;

/** 
 * organization业务接口
 * 创建人：1
 * 创建时间：2017-06-08
 */
public interface OrganizationService {
	
	Organization getOrgByCode(String code);
	
	/**
	 * 通过父机构的locationcode 获取子机构
	 */
	public List<Organization> getSubOrgByLocationCode(String locationCode);

	/**
	 * 新增organization对象
	 *
	 * @param organization
	 */
	public void insertOrganization(Organization organization);
	
	/**
	 * 更新organization对象
	 *
	 * @param organization
	 */
	public void updateOrganization(Organization organization);
	
	/**
	 * 根据ID获取organization对象
	 *
	 * @param id
	 */
	public Organization getOrganizationById(String id);
	
	/**
	 * 根据过滤条件获取organization列表对象
	 *
	 * @param filter
	 */
	public List<Organization> queryOrganizationsFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除organization列表对象
	 *
	 * @param id
	 */
	public void deleteOrganizationById(String id);
	
	/**
	 * 根据Id集合批量删除organization列表对象
	 *
	 * @param ids
	 */
	public void deleteOrganizations(List<String> ids);


	/**
	 * 查询用户可以管理的组织机构
	 * @param userId
	 */
	List<Organization> queryOwnOrgByUserId(String userId);

	/**
	 * 删除用户所管理的组织机构
	 * @param userId
	 */
	void deleteOwnOrgByUserId(String userId);

	/**
	 * 加入用户可以管理的组织机构
	 * @param userId,ids
	 */
	void batchInsertOwnOrg(String userId,List<String> ids);
	
}

