package com.jy.moudles.targetInfo.service;

import java.util.List;
import java.util.Map;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.targetInfo.entity.TargetInfo;

/** 
 * TargetInfo业务接口
 * 创建人：Administrator
 * 创建时间：2018-05-25
 */
public interface TargetInfoService {

	/**
	 * 新增TargetInfo对象
	 *
	 * @param TargetInfo
	 */
	public AsyncResponseData.ResultData insertTargetInfo(TargetInfo TargetInfo);
	
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
	
	public TargetInfo getTargetNow(String userId);
	
	/**
	 * 更新目标状态
	 *
	 * @param ids
	 */
	public void updateStatus();
	
	/**
	 * 根据rankTime 查询目标
	 *
	 * @param ids
	 */
	public TargetInfo getTargetInfoByRankTime(String userId,String rankTime);
}

