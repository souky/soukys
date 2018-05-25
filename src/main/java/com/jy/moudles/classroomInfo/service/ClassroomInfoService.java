package com.jy.moudles.classroomInfo.service;

import com.jy.moudles.classroomInfo.entity.ClassroomInfo;
import java.util.List;
import java.util.Map;

/** 
 * classroomInfo业务接口
 * 创建人：1
 * 创建时间：2018-01-06
 */
public interface ClassroomInfoService {

	/**
	 * 新增classroomInfo对象
	 *
	 * @param classroomInfo
	 */
	public void insertClassroomInfo(ClassroomInfo classroomInfo);
	
	/**
	 * 更新classroomInfo对象
	 *
	 * @param classroomInfo
	 */
	public void updateClassroomInfo(ClassroomInfo classroomInfo);
	
	/**
	 * 根据ID获取classroomInfo对象
	 *
	 * @param id
	 */
	public ClassroomInfo getClassroomInfoById(String id);
	
	/**
	 * 根据过滤条件获取classroomInfo列表对象
	 *
	 * @param filter
	 */
	public List<ClassroomInfo> queryClassroomInfosFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除classroomInfo列表对象
	 *
	 * @param id
	 */
	public void deleteClassroomInfoById(String id);
	
	/**
	 * 根据Id集合批量删除classroomInfo列表对象
	 *
	 * @param ids
	 */
	public void deleteClassroomInfos(List<String> ids);
	
}

