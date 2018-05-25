package com.jy.moudles.exam.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.jy.moudles.exam.entity.Exam;

public interface ExamService {
	
	List<Exam> queryExpiredExamsfilter(Map<String, Object> filter);

	List<Exam> queryExamsByExamTypeAndYear(Map<String, Object> filter);

	List<Exam> queryCurrentExam(Date currentTime);

	void clearExamData();

	List<Exam> queryExamToSend(Map<String, Object> filter);
	
	String queryMaxExamNo();
	
	public List<Exam> queryExamFilter(Map<String, Object> filter);
	
	public int addExam(Exam exam);
	
	public int updateExam(Exam exam);
	
	public int deleteExamById(String id);
	
	public List<Exam> queryExamById(String id); 
	
	public int deleteExams(List<String> ids);
	
	public List<Exam> getExamSubData(String id);
	
	//kafka
	List<Exam> queryExamsByKafka(Map<String, Object> filter);
	
	void insertExamBatch(List<Exam> examList);
	
	void deleteExamByKafka(Map<String, Object> filter);
}
