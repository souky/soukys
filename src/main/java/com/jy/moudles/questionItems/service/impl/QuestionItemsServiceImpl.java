package com.jy.moudles.questionItems.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.questionBank.VO.QuestionBankVO;
import com.jy.moudles.questionBank.dao.QuestionBankDao;
import com.jy.moudles.questionBank.entity.QuestionBank;
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
	@Autowired
	private QuestionBankDao questionBankDao;
	
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
	public void test(){
		QuestionBank questionbank = new QuestionBank();
		questionbank.setType(3);
		List<QuestionBankVO> list = questionBankDao.queryQuestionBanksFilter(questionbank);
		for(QuestionBankVO e :list) {
			String questionId = e.getId();
			QuestionItems QuestionItem = new QuestionItems();
			QuestionItem.setQuestionId(questionId);
			
			QuestionItem.setSort(1);
			QuestionItem.setAnswerItem("完全不符");
			QuestionItem.setAnswerKey("A");
			QuestionItem.setId(UUIDUtil.get32UUID());
			questionItemsDao.insertQuestionItems(QuestionItem);
			
			QuestionItem.setSort(2);
			QuestionItem.setAnswerItem("小部分符合");
			QuestionItem.setAnswerKey("B");
			QuestionItem.setId(UUIDUtil.get32UUID());
			questionItemsDao.insertQuestionItems(QuestionItem);
			
			QuestionItem.setSort(3);
			QuestionItem.setAnswerItem("部分符合");
			QuestionItem.setAnswerKey("C");
			QuestionItem.setId(UUIDUtil.get32UUID());
			questionItemsDao.insertQuestionItems(QuestionItem);
			
			QuestionItem.setSort(4);
			QuestionItem.setAnswerItem("大致符合");
			QuestionItem.setAnswerKey("D");
			QuestionItem.setId(UUIDUtil.get32UUID());
			questionItemsDao.insertQuestionItems(QuestionItem);
			
			QuestionItem.setSort(5);
			QuestionItem.setAnswerItem("完全符合");
			QuestionItem.setAnswerKey("E");
			QuestionItem.setId(UUIDUtil.get32UUID());
			questionItemsDao.insertQuestionItems(QuestionItem);
			
		}
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

