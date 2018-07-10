package com.jy.moudles.punchRank.service;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.punchRank.entity.PunchRank;
import java.util.List;
import java.util.Map;

/** 
 * PunchRank业务接口
 * 创建人：Administrator
 * 创建时间：2018-07-04
 */
public interface PunchRankService {

	/**
	 * 新增PunchRank对象
	 *
	 * @param PunchRank
	 */
	public AsyncResponseData.ResultData insertPunchRank(String orgCode,String rankTime);
	
	/**
	 * 更新PunchRank对象
	 *
	 * @param PunchRank
	 */
	public void updatePunchRank(PunchRank PunchRank);
	
	/**
	 * 根据ID获取PunchRank对象
	 *
	 * @param id
	 */
	public PunchRank getPunchRankById(String id);
	
	/**
	 * 根据过滤条件获取PunchRank列表对象
	 *
	 * @param filter
	 */
	public List<PunchRank> queryPunchRanksFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除PunchRank列表对象
	 *
	 * @param id
	 */
	public void deletePunchRankById(String id);
	
	/**
	 * 根据Id集合批量删除PunchRank列表对象
	 *
	 * @param ids
	 */
	public void deletePunchRanks(List<String> ids);
	
	/**
	 * 查找最近的排名
	 *
	 * @param filter
	 */
	public List<PunchRank> getLastPunchRank(PunchRank PunchRank);
	
}

