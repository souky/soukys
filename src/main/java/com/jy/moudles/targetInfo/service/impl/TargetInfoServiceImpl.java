package com.jy.moudles.targetInfo.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.punchClock.dao.PunchClockDao;
import com.jy.moudles.punchClock.entity.PunchClock;
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
	
	@Autowired
	private PunchClockDao PunchClockDao;
	
	@Override
	public AsyncResponseData.ResultData insertTargetInfo(TargetInfo TargetInfo){
		TargetInfo.setId(UUIDUtil.get32UUID());
		TargetInfo.setStatus(1);
		TargetInfo.setCreateDate(new Date());
		//推算进度
		Map<String,Object> filter = new HashMap<>();
		filter.put("userId", TargetInfo.getUserId());
		filter.put("timeComperS", TargetInfo.getStartTime());
		filter.put("timeComperE", TargetInfo.getEndTime());
		filter.put("isLeave",0);
		
		List<PunchClock> list = PunchClockDao.queryPunchClocksFilter(filter);
		long offTime = TargetInfo.getEndTime().getTime() - TargetInfo.getStartTime().getTime();
		long offDay = offTime / 86400l / 1000l;
		
		BigDecimal doneDay = new BigDecimal(list.size());
		BigDecimal totalDay = new BigDecimal(offDay);
		
		BigDecimal RateProgress = doneDay.divide(totalDay,2,BigDecimal.ROUND_HALF_DOWN)
				.multiply(new BigDecimal(100));
		
		TargetInfo.setRateProgress(RateProgress.intValue());
		TargetInfoDao.insertTargetInfo(TargetInfo);
		return AsyncResponseData.getSuccess();
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

	@Override
	public TargetInfo getTargetNow(String userId) {
		return TargetInfoDao.getTargetNow(userId);
	}

	@Override
	public void updateStatus() {
		TargetInfoDao.updateStatus();
	}

	@Override
	public TargetInfo getTargetInfoByRankTime(String userId, String rankTime) {
		return TargetInfoDao.getTargetInfoByRankTime(userId, rankTime);
	}
	
}

