package com.jy.moudles.blackwhitelist.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.blackwhitelist.entity.BlackWhiteList;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * blackWhiteList
 * 2017-10-16
 */
@MyBatisDao
public interface BlackWhiteListDao {

	/**
	 *
	 * @param blackWhiteList
	 */
	public void insertBlackWhiteList(BlackWhiteList blackWhiteList);
	
	/**
	 * 批量新增blackWhiteList对象
	 *
	 * @param blackWhiteLists
	 */
	public void insertBlackWhiteListBatch(List<BlackWhiteList> blackWhiteLists);
	
	/**
	 *
	 * @param blackWhiteList
	 */
	public void updateBlackWhiteList(BlackWhiteList blackWhiteList);
	
	/**
	 *
	 * @param id
	 */
	public BlackWhiteList getBlackWhiteListById(String id);
	
	/**
	 *
	 * @param filter
	 */
	public List<BlackWhiteList> queryBlackWhiteListsFilter(Map<String, Object> filter);
	
	/**
	 *
	 * @param id
	 */
	public void deleteBlackWhiteListById(String id);
	
	/**
	 *
	 * @param ids
	 */
	public void deleteBlackWhiteLists(Map<String, Object> ids);

	void deleteBWsByKafka(Map<String,Object> filter);
	
}



