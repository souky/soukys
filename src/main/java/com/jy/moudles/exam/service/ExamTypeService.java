package com.jy.moudles.exam.service;

import com.jy.moudles.exam.entity.ExamType;
import java.util.List;
import java.util.Map;

/** 
 * ExamType业务接口
 * 创建人：1
 * 创建时间：2017-06-02
 */
public interface ExamTypeService {

	void clearExamType();

	int queryMaxExamTypeNo();
	
	void deleteExamTypeBykafka(Map<String, Object> filter);
	
	void insertExamTypeBatch(List<ExamType> list);
	
	/**
	 * 新增ExamType对象
	 *
	 * @param ExamType
	 */
	public int insertExamType(ExamType ExamType);
	
	/**
	 * 更新ExamType对象
	 *
	 * @param ExamType
	 */
	public int updateExamType(ExamType ExamType);
	
	/**
	 * 根据ID获取ExamType对象
	 *
	 * @param id
	 */
	public ExamType getExamTypeById(String id);
	
	/**
	 * 根据过滤条件获取ExamType列表对象
	 *
	 * @param filter
	 */
	public List<ExamType> queryExamTypesFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除ExamType列表对象
	 *
	 * @param id
	 */
	public int deleteExamTypeById(String id);
	
	/**
	 * 根据Id集合批量删除ExamType列表对象
	 *
	 * @param ids
	 */
	public int deleteExamTypes(List<String> ids);
	
}

