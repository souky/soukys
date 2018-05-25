package com.jy.moudles.organization.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.organization.dao.OrganizationDao;
import com.jy.moudles.organization.entity.Organization;
import com.jy.moudles.organization.service.OrganizationService;
import com.jy.moudles.user.entity.User;

/** 
 * organization业务实现类
 * 创建人：1
 * 创建时间：2017-06-08
 */
@Service
public class OrganizationServiceImpl implements OrganizationService {

	@Autowired
	private OrganizationDao organizationdao;
	

	@Override
	public Organization getOrgByCode(String code) {
		return organizationdao.getOrgByCode(code);
	}
	
	@Override
	public List<Organization> getSubOrgByLocationCode(String locationCode) {
		return organizationdao.getSubOrgByLocationCode(locationCode);
	}
	
	@Override
	public void insertOrganization(Organization organization){
		
		/*Organization parentOrg = organizationdao.getOrganizationById(organization.getParentId());
		String bsid = "";
		if (null == parentOrg || StringUtils.isBlank(parentOrg.getBsid())) {
			bsid = OrgContants.FIRST_LEVEL_MENU_SERCH_BSID;
		} else {
			boolean flag = false;
			String parentBsid = parentOrg.getBsid();
			String[] parentBsids = parentBsid.split(OrgContants.LINE);
			int lastFiveZero = -1;
			for (int i = 0; i < parentBsids.length; i++) {
				String pBsid = parentBsids[i];
				if (!OrgContants.FIVE_ZERO.equals(pBsid)){
					lastFiveZero = i;
					flag = true;
				}
			}
			if (-1 == lastFiveZero) {
				lastFiveZero = parentBsids.length - 2;
			} else {
				if (!flag) {
					lastFiveZero = 0;
				}
			}
			parentBsids[lastFiveZero + 1] = OrgContants.FIVE_UNDERLINE;
			for (String pBsid : parentBsids) {
				bsid += (pBsid + OrgContants.LINE);
			}
			bsid = bsid.substring(0, (bsid.length() - 1));
			
			String orgMaxBsid = organizationdao.queryOrgMaxBsid(bsid);
			if (StringUtils.isBlank(orgMaxBsid)) {
				bsid = bsid.replace(OrgContants.FIVE_UNDERLINE, OrgContants.FIVE_DEGIT_FIRST);
			} else {
				bsid = "";
				String[] orgMaxBsids = orgMaxBsid.split(OrgContants.LINE);
				orgMaxBsids[lastFiveZero] = String.format("%05d", Integer.valueOf(orgMaxBsids[lastFiveZero]) + 1);
				
				for (String orgBsid : orgMaxBsids) {
					bsid += (orgBsid + OrgContants.LINE);
				}
				bsid = bsid.substring(0, (bsid.length() - 1));
			}
		}
		organization.setBsid(bsid);*/
		organization.setBsid("00000-00000-00000-00000-测试");
		organizationdao.insertOrganization(organization);
	}
	
	@Override
	public void updateOrganization(Organization organization){
		
		organizationdao.updateOrganization(organization);
	}
	
	@Override
	public Organization getOrganizationById(String id){
		return organizationdao.getOrganizationById(id);
	}
	
	@Override
	public List<Organization> queryOrganizationsFilter(Map<String, Object> filter){
		return organizationdao.queryOrganizationsFilter(filter);
	}
	
	@Override
	public void deleteOrganizationById(String id){
		organizationdao.deleteOrganizationById(id);
	}
	
	@Override
	public void deleteOrganizations(List<String> ids){
		organizationdao.deleteOrganizations(ids);
	}

	@Override
	public List<Organization> queryOwnOrgByUserId(String userId) {
		return organizationdao.queryOwnOrgByUserId(userId);
	}

	@Override
	public void deleteOwnOrgByUserId(String userId) {
		organizationdao.deleteOwnOrgByUserId(userId);
	}

	@Override
	public void batchInsertOwnOrg(String userId,List<String> ids) {
		organizationdao.deleteOwnOrgByUserId(userId);
		List<Map<String,Object>> list = new ArrayList<>();
		User user = LoginInterceptor.getCurrentUser();
		for (String id : ids) {
            Map<String, Object> filter = new HashMap<String, Object>();
            filter.put("id", UUIDUtil.get32UUID());
            filter.put("userId", userId);
            filter.put("orgId", id);
            filter.put("user", user.getId());
            list.add(filter);
		}
		organizationdao.batchInsertOwnOrg(list);
	}

}

