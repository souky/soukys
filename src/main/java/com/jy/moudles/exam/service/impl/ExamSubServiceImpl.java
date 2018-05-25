package com.jy.moudles.exam.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.moudles.exam.dao.ExamSubDao;
import com.jy.moudles.exam.entity.ExamSub;
import com.jy.moudles.exam.service.ExamSubService;

@Service
public class ExamSubServiceImpl implements ExamSubService {

	@Autowired
	private ExamSubDao exsubdao;

	@Override
	public void clearExamSubData() {
		exsubdao.clearExamSubData();
	}

	@Override
	public void deleteExsubsByExamPlanId(String examPlanId) {
		exsubdao.deleteExsubsByExamPlanId(examPlanId);
	}

	@Override
	public int insertExsub(ExamSub exsub){
		return exsubdao.insertExsub(exsub);
	}
	
	@Override
	public void updateExsub(ExamSub exsub){
		exsubdao.updateExsub(exsub);
	}
	
	@Override
	public ExamSub getExsubById(String id){
		return exsubdao.getExsubById(id);
	}
	
	@Override
	public List<ExamSub> queryExsubsFilter(Map<String, Object> filter){
		return exsubdao.queryExsubsFilter(filter);
	}
	
	@Override
	public int deleteExsubById(String id){
		return exsubdao.deleteExsubById(id);
	}
	
	@Override
	public void deleteExsubs(List<String> ids){
		exsubdao.deleteExsubs(ids);
	}

	@Override
	public void insertExsubBatch(List<ExamSub> list) {
		if (list != null && list.size() > 0){
			exsubdao.insertExsubBatch(list);
		}
	}

	@Override
	public void deleteExamSubBykafka(Map<String, Object> filter) {
		exsubdao.deleteExamSubBykafka(filter);
	}
	
}

