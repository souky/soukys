package com.jy.moudles.questionBank.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.jsonadpter.AsyncResponseData.ResultData;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.questionBank.VO.QuestionBankVO;
import com.jy.moudles.questionBank.dao.QuestionBankDao;
import com.jy.moudles.questionBank.entity.QuestionBank;
import com.jy.moudles.questionBank.service.QuestionBankService;
import com.jy.moudles.questionItems.dao.QuestionItemsDao;
import com.jy.moudles.questionItems.entity.QuestionItems;

/** 
 * questionBank业务实现类
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@Service
public class QuestionBankServiceImpl implements QuestionBankService {

	@Autowired
	private QuestionBankDao questionBankDao;
	@Autowired
	private QuestionItemsDao questionItemsDao;
	
	
	@Override
	public void updateQuestionBank(QuestionBank questionBank){
		questionBankDao.updateQuestionBank(questionBank);
	}
	
	public AsyncResponseData.ResultData saveOrUpdate(QuestionBankVO questionBankVO){
		String id = questionBankVO.getId();
		if(StringUtils.isBlank(id)) {
			// insert
			questionBankVO.setId(UUIDUtil.get32UUID());
			questionBankVO.setAnswer(questionBankVO.getAnswer().toUpperCase());
			questionBankDao.insertQuestionBank(questionBankVO);
			
			List<QuestionItems> list = questionBankVO.getQuestionItems();
			if(null != list && list.size() > 0) {
				for(QuestionItems e : list) {
					e.setId(UUIDUtil.get32UUID());
					e.setQuestionId(questionBankVO.getId());
					questionItemsDao.insertQuestionItems(e);
				}
			}
		}else {
			// update
			questionBankDao.updateQuestionBank(questionBankVO);
			
			List<QuestionItems> list = questionBankVO.getQuestionItems();
			if(null != list && list.size() > 0) {
				for(QuestionItems e : list) {
					questionItemsDao.updateQuestionItems(e);
				}
			}
		}
		
		return AsyncResponseData.getSuccess();
	}
	
	@Override
	public QuestionBank getQuestionBankById(String id){
		return questionBankDao.getQuestionBankById(id);
	}
	
	
	@Override
	public void deleteQuestionBankById(String id){
		questionBankDao.deleteQuestionBankById(id);
	}
	
	@Override
	public void deleteQuestionBanks(List<String> ids){
		questionBankDao.deleteQuestionBanks(ids);
	}

	@Override
	public ResultData queryQuestionBanksFilter(QuestionBank questionbank) {
		List<QuestionBankVO> list  = questionBankDao.queryQuestionBanksFilter(questionbank);
		return AsyncResponseData.getSuccess(list);
	}

	@Override
	public ResultData getAllQuestion() {
		List<QuestionBankVO> list  = questionBankDao.getAllQuestion();
		return AsyncResponseData.getSuccess(list);
	}
	
}

