package com.jy.moudles.questionBank.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.questionBank.dao.QuestionBankDao;
import com.jy.moudles.questionBank.entity.QuestionBank;
import com.jy.moudles.questionBank.service.QuestionBankService;

/** 
 * questionBank业务实现类
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@Service
public class QuestionBankServiceImpl implements QuestionBankService {

	@Autowired
	private QuestionBankDao questionBankDao;
	
	@Override
	public void insertQuestionBank(QuestionBank questionBank){
		questionBank.setId(UUIDUtil.get32UUID());
		questionBankDao.insertQuestionBank(questionBank);
	}
	
	@Override
	public void updateQuestionBank(QuestionBank questionBank){
		questionBankDao.updateQuestionBank(questionBank);
	}
	
	@Override
	public QuestionBank getQuestionBankById(String id){
		return questionBankDao.getQuestionBankById(id);
	}
	
	@Override
	public List<QuestionBank> queryQuestionBanksFilter(Map<String, Object> filter){
		return questionBankDao.queryQuestionBanksFilter(filter);
	}
	
	@Override
	public void deleteQuestionBankById(String id){
		questionBankDao.deleteQuestionBankById(id);
	}
	
	@Override
	public void deleteQuestionBanks(List<String> ids){
		questionBankDao.deleteQuestionBanks(ids);
	}
	
}

