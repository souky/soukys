package com.jy.moudles.org.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.org.entity.Org;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * Org数据接口
 * 创建人：Administrator
 * 创建时间：2018-05-24
 */
@MyBatisDao
public interface OrgDao {

	/**
	 * 新增Org对象
	 *
	 * @param Org
	 */
	public void insertOrg(Org Org);
	
	/**
	 * 更新Org对象
	 *
	 * @param Org
	 */
	public void updateOrg(Org Org);
	
	/**
	 * 根据ID获取Org对象
	 *
	 * @param id
	 */
	public Org getOrgById(String id);
	
	/**
	 * 根据过滤条件获取Org列表对象
	 *
	 * @param filter
	 */
	public List<Org> queryOrgsFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除Org列表对象
	 *
	 * @param id
	 */
	public void deleteOrgById(String id);
	
	/**
	 * 根据Id集合批量删除Org列表对象
	 *
	 * @param ids
	 */
	public void deleteOrgs(List<String> ids);
	
}



