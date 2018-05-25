package com.jy.moudles.main.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.moudles.main.dao.MenuDao;
import com.jy.moudles.main.entity.Menu;
import com.jy.moudles.main.service.MenuService;

/** 
 * Menu业务实现类
 * 创建人：1
 * 创建时间：2017-05-15
 */
@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuDao menudao;
	
	@Override
	public List<Menu> queryMenus(Map<String, Object> filter){
		return menudao.queryMenus(filter);
	}

	@Override
	public List<Menu> querySonMenusByBsid(Map<String, Object> params) {
		String bsid = (String) params.get("bsid");
		int level = (int) params.get("level");
		return menudao.querySonMenusByBsid(bsid, level);
	}

	@Override
	public List<String> queryResourceByMenuIds(List<String> ids) {
		return menudao.queryResourceByMenuIds(ids);
	}

	@Override
	public List<Menu> queryAllMenus() {
		return menudao.queryAllMenus();
	}
	
	
}

