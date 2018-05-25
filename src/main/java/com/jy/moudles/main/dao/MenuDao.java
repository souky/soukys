package com.jy.moudles.main.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jy.common.persistence.annotation.MyBatisDao;
import com.jy.moudles.main.entity.Menu;

/** 
 * Menu数据接口
 * 创建人：1
 * 创建时间：2017-05-15
 */
@MyBatisDao
public interface MenuDao {

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
	public List<Menu> querySonMenusByBsid(@Param("bsid") String bsid, @Param("level") int level);
	
	/**
	 * 根据菜单Id获取资源
	 * 
	 * @param ids
	 * @return
	 */
	public List<String> queryResourceByMenuIds(@Param("ids") List<String> ids);
	
}



