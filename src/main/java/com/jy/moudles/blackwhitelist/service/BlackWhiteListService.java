package com.jy.moudles.blackwhitelist.service;

import com.jy.moudles.blackwhitelist.entity.BlackWhiteList;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

/** 
 * blackWhiteList
 * 1
 * 2017-10-16
 */
public interface BlackWhiteListService {

	/**
	 *
	 * @param blackWhiteList
	 */
	public void insertBlackWhiteList(BlackWhiteList blackWhiteList);
	
	/**
	 * 批量新增blackWhiteList对象
	 *
	 * @param blackWhiteList
	 */
	public void insertBlackWhiteListBatch(List<BlackWhiteList> blackWhiteList);
	
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
	 * blackWhiteList
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
	public void deleteBlackWhiteLists(List<String> ids);
	
	public void getBlackWhiteLists(HttpServletResponse response,Map<String, Object> filter);

	void deleteBWsByKafka(Map<String,Object> filter);
}

