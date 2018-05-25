package com.jy.moudles.systemLog.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.systemLog.entity.SystemLog;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * SystemLog数据接口
 * 创建人：1
 * 创建时间：2017-10-14
 */
@MyBatisDao
public interface SystemLogDao {

	/**
	 * 新增SystemLog对象
	 *
	 * @param SystemLog
	 */
	public void insertSystemLog(SystemLog SystemLog);
	
	/**
	 * 根据ID获取SystemLog对象
	 *
	 * @param id
	 */
	public SystemLog getSystemLogById(String id);
	
	/**
	 * 根据过滤条件获取SystemLog列表对象
	 *
	 * @param filter
	 */
	public List<SystemLog> querySystemLogsFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id集合批量删除SystemLog列表对象
	 *
	 * @param ids
	 */
	public void deleteSystemLogs(List<String> ids);
	
}



