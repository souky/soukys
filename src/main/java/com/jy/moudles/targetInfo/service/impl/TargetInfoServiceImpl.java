package com.jy.moudles.targetInfo.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.targetInfo.dao.TargetInfoDao;
import com.jy.moudles.targetInfo.entity.TargetInfo;
import com.jy.moudles.targetInfo.service.TargetInfoService;

/** 
 * TargetInfo业务实现类
 * 创建人：Administrator
 * 创建时间：2018-05-25
 */
@Service
public class TargetInfoServiceImpl implements TargetInfoService {

	@Autowired
	private TargetInfoDao TargetInfoDao;
	
	@Override
	public void insertTargetInfo(TargetInfo TargetInfo){
		TargetInfo.setId(UUIDUtil.get32UUID());
		TargetInfoDao.insertTargetInfo(TargetInfo);
	}
	
	@Override
	public void updateTargetInfo(TargetInfo TargetInfo){
		TargetInfoDao.updateTargetInfo(TargetInfo);
	}
	
	@Override
	public TargetInfo getTargetInfoById(String id){
		return TargetInfoDao.getTargetInfoById(id);
	}
	
	@Override
	public List<TargetInfo> queryTargetInfosFilter(Map<String, Object> filter){
		return TargetInfoDao.queryTargetInfosFilter(filter);
	}
	
	@Override
	public void deleteTargetInfoById(String id){
		TargetInfoDao.deleteTargetInfoById(id);
	}
	
	@Override
	public void deleteTargetInfos(List<String> ids){
		TargetInfoDao.deleteTargetInfos(ids);
	}
	
}

