package com.jy.moudles.questionItems.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.questionItems.entity.QuestionItems;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * questionItems数据接口
 * 创建人：Administrator
 * 创建时间：2019-05-05
 */
@MyBatisDao
public interface QuestionItemsDao {

	/**
	 * 新增questionItems对象
	 *
	 * @param questionItems
	 */
	public void insertQuestionItems(QuestionItems questionItems);
	
	/**
	 * 更新questionItems对象
	 *
	 * @param questionItems
	 */
	public void updateQuestionItems(QuestionItems questionItems);
	
	/**
	 * 根据ID获取questionItems对象
	 *
	 * @param id
	 */
	public QuestionItems getQuestionItemsById(String id);
	
	/**
	 * 根据过滤条件获取questionItems列表对象
	 *
	 * @param filter
	 */
	public List<QuestionItems> queryQuestionItemssFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除questionItems列表对象
	 *
	 * @param id
	 */
	public void deleteQuestionItemsById(String id);
	
	/**
	 * 根据Id集合批量删除questionItems列表对象
	 *
	 * @param ids
	 */
	public void deleteQuestionItemss(List<String> ids);
	
}



