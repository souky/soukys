package com.jy.moudles.punchClock.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jy.moudles.punchClock.entity.PunchClock;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * PunchClock数据接口
 * 创建人：Administrator
 * 创建时间：2018-05-25
 */
@MyBatisDao
public interface PunchClockDao {

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
	
	/**
	 * 根据userid和月数查询打卡记录
	 *
	 * @param ids
	 */
	public List<Integer> getPunchClockByMonth(@Param("userId")String userId,@Param("month")int month);
}



