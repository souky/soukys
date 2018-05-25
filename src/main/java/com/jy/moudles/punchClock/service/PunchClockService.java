package com.jy.moudles.punchClock.service;

import com.jy.moudles.punchClock.entity.PunchClock;
import java.util.List;
import java.util.Map;

/** 
 * PunchClock业务接口
 * 创建人：Administrator
 * 创建时间：2018-05-25
 */
public interface PunchClockService {

	/**
	 * 新增PunchClock对象
	 *
	 * @param PunchClock
	 */
	public void insertPunchClock(PunchClock PunchClock);
	
	/**
	 * 更新PunchClock对象
	 *
	 * @param PunchClock
	 */
	public void updatePunchClock(PunchClock PunchClock);
	
	/**
	 * 根据ID获取PunchClock对象
	 *
	 * @param id
	 */
	public PunchClock getPunchClockById(String id);
	
	/**
	 * 根据过滤条件获取PunchClock列表对象
	 *
	 * @param filter
	 */
	public List<PunchClock> queryPunchClocksFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除PunchClock列表对象
	 *
	 * @param id
	 */
	public void deletePunchClockById(String id);
	
	/**
	 * 根据Id集合批量删除PunchClock列表对象
	 *
	 * @param ids
	 */
	public void deletePunchClocks(List<String> ids);
	
}

