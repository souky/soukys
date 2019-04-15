package com.jy.moudles.auditionForm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.auditionForm.dao.AuditionFormDao;
import com.jy.moudles.auditionForm.entity.AuditionForm;
import com.jy.moudles.auditionForm.service.AuditionFormService;

/** 
 * auditionForm业务实现类
 * 创建人：Administrator
 * 创建时间：2019-04-15
 */
@Service
public class AuditionFormServiceImpl implements AuditionFormService {

	@Autowired
	private AuditionFormDao auditionFormDao;
	
	@Override
	public void insertAuditionForm(AuditionForm auditionForm){
		auditionForm.setId(UUIDUtil.get32UUID());
		auditionFormDao.insertAuditionForm(auditionForm);
	}
	
	@Override
	public void updateAuditionForm(AuditionForm auditionForm){
		auditionFormDao.updateAuditionForm(auditionForm);
	}
	
	@Override
	public AuditionForm getAuditionFormById(String id){
		return auditionFormDao.getAuditionFormById(id);
	}
	
	@Override
	public List<AuditionForm> queryAuditionFormsFilter(Map<String, Object> filter){
		return auditionFormDao.queryAuditionFormsFilter(filter);
	}
	
	@Override
	public void deleteAuditionFormById(String id){
		auditionFormDao.deleteAuditionFormById(id);
	}
	
	@Override
	public void deleteAuditionForms(List<String> ids){
		auditionFormDao.deleteAuditionForms(ids);
	}
	
}

