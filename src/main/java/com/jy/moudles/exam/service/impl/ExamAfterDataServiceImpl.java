package com.jy.moudles.exam.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.exam.dao.ExamAfterDataDao;
import com.jy.moudles.exam.entity.ExamAfterData;
import com.jy.moudles.exam.service.ExamAfterDataService;

/** 
 * examAfterData业务实现类
 * 创建人：wb
 * 创建时间：2017-10-22
 */
@Service
public class ExamAfterDataServiceImpl implements ExamAfterDataService {

	@Autowired
	private ExamAfterDataDao examAfterDataDao;
	
	@Override
	public void clearExamAfterData(){
		examAfterDataDao.clearExamAfterData();
	}
	
	@Override
	public void insertExamAfterData(ExamAfterData examAfterData){
		examAfterData.setId(UUIDUtil.get32UUID());
		examAfterDataDao.insertExamAfterData(examAfterData);
	}
	
	@Override
	public void updateExamAfterData(ExamAfterData examAfterData){
		examAfterDataDao.updateExamAfterData(examAfterData);
	}
	
	@Override
	public ExamAfterData getExamAfterDataById(String id){
		return examAfterDataDao.getExamAfterDataById(id);
	}
	
	@Override
	public List<ExamAfterData> queryExamAfterDatasFilter(Map<String, Object> filter){
		return examAfterDataDao.queryExamAfterDatasFilter(filter);
	}
	
	@Override
	public void deleteExamAfterDataById(String id){
		examAfterDataDao.deleteExamAfterDataById(id);
	}
	
	@Override
	public void deleteExamAfterDatas(List<String> ids){
		examAfterDataDao.deleteExamAfterDatas(ids);
	}
	
}

