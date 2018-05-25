package com.jy.moudles.reductionInfo.service;

import com.jy.moudles.reductionInfo.entity.ReductionInfo;
import com.jy.moudles.statistics.entity.ReductionCollectVO;

import java.util.List;
import java.util.Map;

public interface ReductionInfoService {

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

