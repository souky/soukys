package com.jy.moudles.main.service;

import java.util.List;
import java.util.Map;

import com.jy.moudles.main.entity.Menu;

/** 
 * Menu业务接口
 * 创建人：1
 * 创建时间：2017-05-15
 */
public interface MenuService {

	/**
	 * 查询所有菜单
	 */
	public List<Menu> queryAllMenus();
	
	/**
	 * 根据过滤条件获取Menu列表对象
	 *
	 * @param filter
	 */
	public List<Menu> queryMenus(Map<String, Object> filter);
	
	/**
	 * 获取下级菜单
	 * 
	 * @param params
	 * @return
	 */
	public List<Menu> querySonMenusByBsid(Map<String, Object> params);
	
	
	/**
	 * 根据菜单Id获取资源
	 * 
	 * @param ids
	 * @return
	 */
	public List<String> queryResourceByMenuIds(List<String> ids);
	
}

