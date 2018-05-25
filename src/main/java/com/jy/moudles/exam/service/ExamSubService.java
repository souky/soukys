package com.jy.moudles.exam.service;

import com.jy.moudles.exam.entity.ExamSub;
import java.util.List;
import java.util.Map;

public interface ExamSubService {

	//清理数据
	void clearExamSubData();

	void deleteExsubsByExamPlanId(String examPlanId);

	public int insertExsub(ExamSub exsub);
	
	public void updateExsub(ExamSub exsub);
	
	public ExamSub getExsubById(String id);
	
	public List<ExamSub> queryExsubsFilter(Map<String, Object> filter);
	
	public int deleteExsubById(String id);
	
	public void deleteExsubs(List<String> ids);
	
	//kafka   批量增加
	void insertExsubBatch(List<ExamSub> list);
	
	void deleteExamSubBykafka(Map<String, Object> filter);
}

