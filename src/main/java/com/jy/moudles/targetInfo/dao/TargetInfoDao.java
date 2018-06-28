package com.jy.moudles.targetInfo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jy.moudles.targetInfo.entity.TargetInfo;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * TargetInfo数据接口
 * 创建人：Administrator
 * 创建时间：2018-05-25
 */
@MyBatisDao
public interface TargetInfoDao {

	/**
	 * 新增TargetInfo对象
	 *
	 * @param TargetInfo
	 */
	public void insertTargetInfo(TargetInfo TargetInfo);
	
	/**
	 * 更新TargetInfo对象
	 *
	 * @param TargetInfo
	 */
	public void updateTargetInfo(TargetInfo TargetInfo);
	
	/**
	 * 根据ID获取TargetInfo对象
	 *
	 * @param id
	 */
	public TargetInfo getTargetInfoById(String id);
	
	/**
	 * 根据过滤条件获取TargetInfo列表对象
	 *
	 * @param filter
	 */
	public List<TargetInfo> queryTargetInfosFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除TargetInfo列表对象
	 *
	 * @param id
	 */
	public void deleteTargetInfoById(String id);
	
	/**
	 * 根据Id集合批量删除TargetInfo列表对象
	 *
	 * @param ids
	 */
	public void deleteTargetInfos(List<String> ids);
	
	/**
	 * 寻找当前对象
	 *
	 * @param ids
	 */
	public TargetInfo getTargetNow(@Param("userId")String userId);
	
}



