package com.jy.moudles.auditionForm.dao;

import java.util.List;
import java.util.Map;

import com.jy.moudles.auditionForm.entity.AuditionForm;
import com.jy.common.persistence.annotation.MyBatisDao;

/** 
 * auditionForm数据接口
 * 创建人：Administrator
 * 创建时间：2019-04-15
 */
@MyBatisDao
public interface AuditionFormDao {

	/**
	 * 新增auditionForm对象
	 *
	 * @param auditionForm
	 */
	public void insertAuditionForm(AuditionForm auditionForm);
	
	/**
	 * 更新auditionForm对象
	 *
	 * @param auditionForm
	 */
	public void updateAuditionForm(AuditionForm auditionForm);
	
	/**
	 * 根据ID获取auditionForm对象
	 *
	 * @param id
	 */
	public AuditionForm getAuditionFormById(String id);
	
	/**
	 * 根据过滤条件获取auditionForm列表对象
	 *
	 * @param filter
	 */
	public List<AuditionForm> queryAuditionFormsFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除auditionForm列表对象
	 *
	 * @param id
	 */
	public void deleteAuditionFormById(String id);
	
	/**
	 * 根据Id集合批量删除auditionForm列表对象
	 *
	 * @param ids
	 */
	public void deleteAuditionForms(List<String> ids);
	
}



