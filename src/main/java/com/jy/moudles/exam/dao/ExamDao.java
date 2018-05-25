package com.jy.moudles.exam.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jy.common.persistence.annotation.MyBatisDao;
import com.jy.moudles.exam.entity.Exam;

@MyBatisDao
public interface ExamDao {
	
	List<Exam> queryExpiredExamsfilter(Map<String, Object> filter);

	List<Exam> queryExamsByExamTypeAndYear(Map<String, Object> filter);
	
	List<Exam> queryCurrentExam(@Param("currentTime")Date currentTime);

	void clearExamData();

	List<Exam> queryExamToSend(Map<String, Object> filter);
	
	String queryMaxExamNo();

	public List<Exam> queryExamFilter(Map<String, Object> filter);
	
	public int addExam(Exam exam);
	
	public int updateExam(Exam exam);
	
	public int deleteExamById(@Param("id")String id);
	
	public int deleteExams(List<String> ids);
	
	public List<Exam> queryExamById(@Param("id")String id); 
	
	public List<Exam> getExamSubData(@Param("id") String id);
	
	//kafka
	List<Exam> queryExamsByKafka(Map<String, Object> filter);
	
	void insertExamBatch(List<Exam> examList);
	
	void deleteExamByKafka(Map<String, Object> filter);
}
