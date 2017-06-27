package com.souky.dao.base;

import java.util.List;

public interface BaseDao<T> {
	
	List<T> findAll();
	
	int save(T entity);
	
	int delete(T entity);
	
	int update(T entity);
	
	List<T> queryById(int id);
	
}
