package com.jy.moudles.punchClock.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.moudles.punchClock.dao.PunchClockDao;
import com.jy.moudles.punchClock.entity.PunchClock;
import com.jy.moudles.punchClock.service.PunchClockService;

/** 
 * PunchClock业务实现类
 * 创建人：Administrator
 * 创建时间：2018-05-25
 */
@Service
public class PunchClockServiceImpl implements PunchClockService {

	@Autowired
	private PunchClockDao PunchClockDao;
	
	@Override
	public void insertPunchClock(PunchClock PunchClock){
		PunchClockDao.insertPunchClock(PunchClock);
	}
	
	@Override
	public void updatePunchClock(PunchClock PunchClock){
		PunchClockDao.updatePunchClock(PunchClock);
	}
	
	@Override
	public PunchClock getPunchClockById(String id){
		return PunchClockDao.getPunchClockById(id);
	}
	
	@Override
	public List<PunchClock> queryPunchClocksFilter(Map<String, Object> filter){
		return PunchClockDao.queryPunchClocksFilter(filter);
	}
	
	@Override
	public void deletePunchClockById(String id){
		PunchClockDao.deletePunchClockById(id);
	}
	
	@Override
	public void deletePunchClocks(List<String> ids){
		PunchClockDao.deletePunchClocks(ids);
	}

	@Override
	public List<Integer> getPunchClockByMonth(String userId,int month) {
		return PunchClockDao.getPunchClockByMonth(userId, month);
	}
	
}

