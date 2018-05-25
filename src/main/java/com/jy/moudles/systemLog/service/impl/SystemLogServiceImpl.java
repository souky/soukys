package com.jy.moudles.systemLog.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.systemLog.dao.SystemLogDao;
import com.jy.moudles.systemLog.entity.SystemLog;
import com.jy.moudles.systemLog.service.SystemLogService;

/** 
 * SystemLog业务实现类
 * 创建人：1
 * 创建时间：2017-10-14
 */
@Service
public class SystemLogServiceImpl implements SystemLogService {

	@Autowired
	private SystemLogDao SystemLogdao;
	
	@Override
	public void insertSystemLog(SystemLog SystemLog){
		SystemLog.setId(UUIDUtil.get32UUID());
		SystemLogdao.insertSystemLog(SystemLog);
	}
	
	@Override
	public SystemLog getSystemLogById(String id){
		return SystemLogdao.getSystemLogById(id);
	}
	
	@Override
	public List<SystemLog> querySystemLogsFilter(Map<String, Object> filter){
		return SystemLogdao.querySystemLogsFilter(filter);
	}
	
	@Override
	public void deleteSystemLogs(List<String> ids){
		SystemLogdao.deleteSystemLogs(ids);
	}
	
}

