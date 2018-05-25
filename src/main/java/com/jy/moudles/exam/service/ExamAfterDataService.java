package com.jy.moudles.exam.service;

import com.jy.moudles.exam.entity.ExamAfterData;
import java.util.List;
import java.util.Map;

/** 
 * examAfterData业务接口
 * 创建人：wb
 * 创建时间：2017-10-22
 */
public interface ExamAfterDataService {

	void clearExamAfterData();

	/**
	 * 新增examAfterData对象
	 *
	 * @param examAfterData
	 */
	public void insertExamAfterData(ExamAfterData examAfterData);
	
	/**
	 * 更新examAfterData对象
	 *
	 * @param examAfterData
	 */
	public void updateExamAfterData(ExamAfterData examAfterData);
	
	/**
	 * 根据ID获取examAfterData对象
	 *
	 * @param id
	 */
	public ExamAfterData getExamAfterDataById(String id);
	
	/**
	 * 根据过滤条件获取examAfterData列表对象
	 *
	 * @param filter
	 */
	public List<ExamAfterData> queryExamAfterDatasFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除examAfterData列表对象
	 *
	 * @param id
	 */
	public void deleteExamAfterDataById(String id);
	
	/**
	 * 根据Id集合批量删除examAfterData列表对象
	 *
	 * @param ids
	 */
	public void deleteExamAfterDatas(List<String> ids);
	
}

