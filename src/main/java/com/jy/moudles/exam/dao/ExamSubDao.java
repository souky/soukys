package com.jy.moudles.exam.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.exam.entity.ExamSub;
import com.jy.common.persistence.annotation.MyBatisDao;

@MyBatisDao
public interface ExamSubDao {

	//清理数据
	void clearExamSubData();

	public int insertExsub(ExamSub exsub);
	
	public void updateExsub(ExamSub exsub);
	
	public ExamSub getExsubById(String id);
	
	public List<ExamSub> queryExsubsFilter(Map<String, Object> filter);

	void deleteExsubsByExamPlanId(String examPlanId);

	public int deleteExsubById(String id);
	
	public void deleteExsubs(List<String> ids);
	
	//kafka   批量增加
	void insertExsubBatch(List<ExamSub> list);
	
	void deleteExamSubBykafka(Map<String, Object> filter);
	
}



