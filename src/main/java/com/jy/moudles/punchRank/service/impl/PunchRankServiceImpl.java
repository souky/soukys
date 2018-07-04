package com.jy.moudles.punchRank.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.punchRank.dao.PunchRankDao;
import com.jy.moudles.punchRank.entity.PunchRank;
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
	public void insertPunchRank(PunchRank PunchRank){
		PunchRank.setId(UUIDUtil.get32UUID());
		PunchRankDao.insertPunchRank(PunchRank);
	}
	
	@Override
	public void updatePunchRank(PunchRank PunchRank){
		PunchRankDao.updatePunchRank(PunchRank);
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

