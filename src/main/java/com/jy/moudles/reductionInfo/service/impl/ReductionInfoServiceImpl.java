package com.jy.moudles.reductionInfo.service.impl;

import com.jy.moudles.statistics.entity.ReductionCollectVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.reductionInfo.dao.ReductionInfoDao;
import com.jy.moudles.reductionInfo.entity.ReductionInfo;
import com.jy.moudles.reductionInfo.service.ReductionInfoService;

@Service
public class ReductionInfoServiceImpl implements ReductionInfoService {

	@Autowired
	private ReductionInfoDao reductionInfodao;

	@Override
	public void insertReductionInfosBatch(List<ReductionInfo> list) {
		if(list != null && list.size() > 0){
			reductionInfodao.insertReductionInfosBatch(list);
		}
	}

	@Override
	public void deleteReductionInfosByKafka(Map<String, Object> filter) {
		reductionInfodao.deleteReductionInfosByKafka(filter);
	}

	@Override
	public List<ReductionCollectVO> queryReductionInfoCount(Map<String, Object> filter) {
		return reductionInfodao.queryReductionInfoCount(filter);
	}

	@Override
	public void clearReductionInfoData() {
		reductionInfodao.clearReductionInfoData();
	}

	@Override
	public void insertReductionInfo(ReductionInfo reductionInfo){
		reductionInfo.setId(UUIDUtil.get32UUID());
		reductionInfodao.insertReductionInfo(reductionInfo);
	}
	
	@Override
	public void updateReductionInfo(ReductionInfo reductionInfo){
		reductionInfodao.updateReductionInfo(reductionInfo);
	}
	
	@Override
	public ReductionInfo getReductionInfoById(String id){
		return reductionInfodao.getReductionInfoById(id);
	}
	
	@Override
	public List<ReductionInfo> queryReductionInfosFilter(Map<String, Object> filter){
		return reductionInfodao.queryReductionInfosFilter(filter);
	}
	
	@Override
	public void deleteReductionInfoById(String id){
		reductionInfodao.deleteReductionInfoById(id);
	}
	
	@Override
	public void deleteReductionInfos(List<String> ids){
		reductionInfodao.deleteReductionInfos(ids);
	}
	
}

