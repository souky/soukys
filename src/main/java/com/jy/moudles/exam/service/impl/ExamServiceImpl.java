package com.jy.moudles.exam.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.moudles.exam.dao.ExamDao;
import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.service.ExamService;

@Service
public class ExamServiceImpl implements ExamService{

	@Autowired
	private ExamDao examDao;
	
	@Autowired
	public List<Exam> queryExpiredExamsfilter(Map<String, Object> filter){
		return examDao.queryExpiredExamsfilter(filter);
	}

	@Override
	public List<Exam> queryExamsByExamTypeAndYear(Map<String, Object> filter){
		return examDao.queryExamsByExamTypeAndYear(filter);
	}


	@Override
	public void clearExamData() {
		examDao.clearExamData();
	}

	@Override
	public List<Exam> queryExamToSend(Map<String, Object> filter){
		return examDao.queryExamToSend(filter);
	}

	@Override
	public List<Exam> queryExamFilter(Map<String, Object> filter) {
		return examDao.queryExamFilter(filter);
	}

	@Override
	public int addExam(Exam exam) {
		return examDao.addExam(exam);
	}

	@Override
	public int updateExam(Exam exam) {
		return examDao.updateExam(exam);
	}

	@Override
	public int deleteExamById(String id) {
		return examDao.deleteExamById(id);
	}
	
	@Override
	public List<Exam> queryExamById(String id){
		return examDao.queryExamById(id);
	}
	
	@Override
	public int deleteExams(List<String> ids) {
		return examDao.deleteExams(ids);
	}
	
	@Override
	public List<Exam> getExamSubData(String exnum) {
		return examDao.getExamSubData(exnum);
	}

	@Override
	public List<Exam> queryExamsByKafka(Map<String, Object> filter) {
		return examDao.queryExamsByKafka(filter);
	}

	@Override
	public void insertExamBatch(List<Exam> examList) {
		if(examList != null && examList.size() > 0){
			examDao.insertExamBatch(examList);
		}
	}
	
	@Override
	public void deleteExamByKafka(Map<String, Object> filter){
		examDao.deleteExamByKafka(filter);
	}

	@Override
	public String queryMaxExamNo() {
		return examDao.queryMaxExamNo();
	}

	@Override
	public List<Exam> queryCurrentExam(Date currentTime) {
		return examDao.queryCurrentExam(currentTime);
	}
}
