package com.jy.moudles.questionBank.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.questionBank.entity.QuestionBank;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * questionBank数据接口
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@MyBatisDao
public interface QuestionBankDao {

	/**
	 * 新增questionBank对象
	 *
	 * @param questionBank
	 */
	public void insertQuestionBank(QuestionBank questionBank);
	
	/**
	 * 更新questionBank对象
	 *
	 * @param questionBank
	 */
	public void updateQuestionBank(QuestionBank questionBank);
	
	/**
	 * 根据ID获取questionBank对象
	 *
	 * @param id
	 */
	public QuestionBank getQuestionBankById(String id);
	
	/**
	 * 根据过滤条件获取questionBank列表对象
	 *
	 * @param filter
	 */
	public List<QuestionBank> queryQuestionBanksFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除questionBank列表对象
	 *
	 * @param id
	 */
	public void deleteQuestionBankById(String id);
	
	/**
	 * 根据Id集合批量删除questionBank列表对象
	 *
	 * @param ids
	 */
	public void deleteQuestionBanks(List<String> ids);
	
}



