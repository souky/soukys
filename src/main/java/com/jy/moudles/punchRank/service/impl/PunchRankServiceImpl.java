package com.jy.moudles.punchRank.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.punchRank.dao.PunchRankDao;
import com.jy.moudles.punchRank.entity.PunchRank;
import com.jy.moudles.punchRank.entity.RankVO;
import com.jy.moudles.punchRank.service.PunchRankService;

/** 
 * PunchRank业务实现类
 * 创建人：Administrator
 * 创建时间：2018-07-04
 */
@Service
public class PunchRankServiceImpl implements PunchRankService {

	@Autowired
	private PunchRankDao PunchRankDao;
	
	@Override
	public AsyncResponseData.ResultData insertPunchRank(String orgCode,String rankTime){
		Map<String, Object> filter = new HashMap<>();
		filter.put("rankTime", rankTime);
		filter.put("orgCode", orgCode);
		List<PunchRank> list = PunchRankDao.queryPunchRanksFilter(filter);
		if(null != list && list.size() > 0) {
			return AsyncResponseData.getSuccess().asParamError("已有此天记录");
		}else {
			for(int i = 1;i<4;i++) {
				PunchRank punchRank = new PunchRank();
				punchRank.setRankNum(i);
				punchRank.setOrgCode(orgCode);
				punchRank.setRankTime(rankTime);
				punchRank.setCreateDate(new Date());
				punchRank.setCreateUser("manager");
				punchRank.setId(UUIDUtil.get32UUID());
				PunchRankDao.insertPunchRank(punchRank);
			}
			return AsyncResponseData.getSuccess();
		}
	}
	
	@Override
	public void updatePunchRank(RankVO rankVO){
		String userId = rankVO.getUserId();
		PunchRank punchRank = new PunchRank();
		if(StringUtils.isBlank(userId)) {
			//删除
			punchRank.setUserId("");
			punchRank.setRateProgress(0);
			punchRank.setPunchDays(0);
			punchRank.setId(rankVO.getId());
		}else {
			//修改
			punchRank.setId(rankVO.getId());
			punchRank.setUserId(userId);
			int rateProgress = rankVO.getRateProgress();
			int targetDays = rankVO.getTargetDays();
			double rateProgress_ = Double.parseDouble(rateProgress+"")/100;
			Double punchDay = Math.ceil(targetDays * rateProgress_);
			punchRank.setRateProgress(rateProgress);
			punchRank.setPunchDays(punchDay.intValue());
		}
		PunchRankDao.updatePunchRank(punchRank);
	}
	
	@Override
	public PunchRank getPunchRankById(String id){
		return PunchRankDao.getPunchRankById(id);
	}
	
	@Override
	public List<PunchRank> queryPunchRanksFilter(Map<String, Object> filter){
		return PunchRankDao.queryPunchRanksFilter(filter);
	}
	
	@Override
	public void deletePunchRankById(String id){
		PunchRankDao.deletePunchRankById(id);
	}
	
	@Override
	public void deletePunchRanks(List<String> ids){
		PunchRankDao.deletePunchRanks(ids);
	}

	@Override
	public List<PunchRank> getLastPunchRank(PunchRank PunchRank) {
		List<PunchRank> list = PunchRankDao.getLastPunchRank(PunchRank);
		List<PunchRank> listNew = new ArrayList<>();
		PunchRank PunchRankTemp = new PunchRank();
		int length = list.size();
		switch(length) {
			case 0:
				listNew.add(PunchRankTemp);
				listNew.add(PunchRankTemp);
				listNew.add(PunchRankTemp);
				break;
			case 1:
				listNew.add(PunchRankTemp);
				listNew.add(list.get(0));
				listNew.add(PunchRankTemp);
				break;
			case 2:
				listNew.add(list.get(1));
				listNew.add(list.get(0));
				listNew.add(PunchRankTemp);
				break;
			case 3:
				listNew.add(list.get(1));
				listNew.add(list.get(0));
				listNew.add(list.get(2));
				break;
		}
		return listNew;
	}
	
}

