package com.jy.moudles.org.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.org.dao.OrgDao;
import com.jy.moudles.org.entity.Org;
import com.jy.moudles.org.service.OrgService;

/** 
 * Org业务实现类
 * 创建人：Administrator
 * 创建时间：2018-05-24
 */
@Service
public class OrgServiceImpl implements OrgService {

	@Autowired
	private OrgDao OrgDao;
	
	@Override
	public void insertOrg(Org Org){
		Org.setId(UUIDUtil.get32UUID());
		Org.setCreateDate(new Date());
		Org.setCreateUser("wx");
		OrgDao.insertOrg(Org);
	}
	
	@Override
	public void updateOrg(Org Org){
		OrgDao.updateOrg(Org);
	}
	
	@Override
	public Org getOrgById(String id){
		return OrgDao.getOrgById(id);
	}
	
	@Override
	public List<Org> queryOrgsFilter(Map<String, Object> filter){
		List<Org> orgs = OrgDao.queryOrgsFilter(filter);
		if(null != orgs && orgs.size() == 1) {
			String id = orgs.get(0).getId();
			if(null == id) {
				orgs.clear();
			}
		}
		return orgs;
	}
	
	@Override
	public void deleteOrgById(String id){
		OrgDao.deleteOrgById(id);
	}
	
	@Override
	public void deleteOrgs(List<String> ids){
		OrgDao.deleteOrgs(ids);
	}
	
}

