package com.jy.moudles.reductionInfo.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.reductionInfo.entity.ReductionInfo;
import com.jy.common.persistence.annotation.MyBatisDao;
import com.jy.moudles.statistics.entity.ReductionCollectVO;

@MyBatisDao
public interface ReductionInfoDao {

	List<ReductionCollectVO> queryReductionInfoCount(Map<String, Object> filter);

	void clearReductionInfoData();

	public void insertReductionInfo(ReductionInfo reductionInfo);
	
	public void updateReductionInfo(ReductionInfo reductionInfo);
	
	public ReductionInfo getReductionInfoById(String id);
	
	public List<ReductionInfo> queryReductionInfosFilter(Map<String, Object> filter);
	
	public void deleteReductionInfoById(String id);
	
	public void deleteReductionInfos(List<String> ids);

	//insert batch
	void insertReductionInfosBatch(List<ReductionInfo> list);

	void deleteReductionInfosByKafka(Map<String, Object> filter);
	
}



