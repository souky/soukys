package com.jy.moudles.exam.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.moudles.exam.dao.ExamTypeDao;
import com.jy.moudles.exam.entity.ExamType;
import com.jy.moudles.exam.service.ExamTypeService;

/** 
 * ExamType业务实现类
 * 创建人：1
 * 创建时间：2017-06-02
 */
@Service
public class ExamTypeServiceImpl implements ExamTypeService {

	@Autowired
	private ExamTypeDao ExamTypedao;

	@Override
	public void clearExamType(){
		ExamTypedao.clearExamType();
	}
	
	@Override
	public int insertExamType(ExamType ExamType){
		return ExamTypedao.insertExamType(ExamType);
	}
	
	@Override
	public int updateExamType(ExamType ExamType){
		return ExamTypedao.updateExamType(ExamType);
	}
	
	@Override
	public ExamType getExamTypeById(String id){
		return ExamTypedao.getExamTypeById(id);
	}
	
	@Override
	public List<ExamType> queryExamTypesFilter(Map<String, Object> filter){
		return ExamTypedao.queryExamTypesFilter(filter);
	}
	
	@Override
	public int deleteExamTypeById(String id){
		return ExamTypedao.deleteExamTypeById(id);
	}
	
	@Override
	public int deleteExamTypes(List<String> ids){
		return ExamTypedao.deleteExamTypes(ids);
	}

	@Override
	public void insertExamTypeBatch(List<ExamType> list) {
		if(list != null && list.size() > 0){
			ExamTypedao.insertExamTypeBatch(list);
		}
	}
	
	@Override
	public void deleteExamTypeBykafka(Map<String, Object> filter){
		ExamTypedao.deleteExamTypeBykafka(filter);
	}

	@Override
	public int queryMaxExamTypeNo() {
		return ExamTypedao.queryMaxExamTypeNo();
	}
	
}

