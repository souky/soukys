package com.jy.moudles.questionItems.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.questionItems.dao.QuestionItemsDao;
import com.jy.moudles.questionItems.entity.QuestionItems;
import com.jy.moudles.questionItems.service.QuestionItemsService;

/** 
 * questionItems业务实现类
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@Service
public class QuestionItemsServiceImpl implements QuestionItemsService {

	@Autowired
	private QuestionItemsDao questionItemsDao;
	
	@Override
	public void insertQuestionItems(QuestionItems questionItems){
		questionItems.setId(UUIDUtil.get32UUID());
		questionItemsDao.insertQuestionItems(questionItems);
	}
	
	@Override
	public void updateQuestionItems(QuestionItems questionItems){
		questionItemsDao.updateQuestionItems(questionItems);
	}
	
	@Override
	public QuestionItems getQuestionItemsById(String id){
		return questionItemsDao.getQuestionItemsById(id);
	}
	
	@Override
	public List<QuestionItems> queryQuestionItemssFilter(Map<String, Object> filter){
		return questionItemsDao.queryQuestionItemssFilter(filter);
	}
	
	@Override
	public void deleteQuestionItemsById(String id){
		questionItemsDao.deleteQuestionItemsById(id);
	}
	
	@Override
	public void deleteQuestionItemss(List<String> ids){
		questionItemsDao.deleteQuestionItemss(ids);
	}
	
}

