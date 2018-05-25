package com.jy.moudles.classroomInfo.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.classroomInfo.dao.ClassroomInfoDao;
import com.jy.moudles.classroomInfo.entity.ClassroomInfo;
import com.jy.moudles.classroomInfo.service.ClassroomInfoService;

/** 
 * classroomInfo业务实现类
 * 创建人：1
 * 创建时间：2018-01-06
 */
@Service
public class ClassroomInfoServiceImpl implements ClassroomInfoService {

	@Autowired
	private ClassroomInfoDao classroomInfodao;
	
	@Override
	public void insertClassroomInfo(ClassroomInfo classroomInfo){
		classroomInfodao.insertClassroomInfo(classroomInfo);
	}
	
	@Override
	public void updateClassroomInfo(ClassroomInfo classroomInfo){
		classroomInfodao.updateClassroomInfo(classroomInfo);
	}
	
	@Override
	public ClassroomInfo getClassroomInfoById(String id){
		return classroomInfodao.getClassroomInfoById(id);
	}
	
	@Override
	public List<ClassroomInfo> queryClassroomInfosFilter(Map<String, Object> filter){
		return classroomInfodao.queryClassroomInfosFilter(filter);
	}
	
	@Override
	public void deleteClassroomInfoById(String id){
		classroomInfodao.deleteClassroomInfoById(id);
	}
	
	@Override
	public void deleteClassroomInfos(List<String> ids){
		classroomInfodao.deleteClassroomInfos(ids);
	}
	
}

