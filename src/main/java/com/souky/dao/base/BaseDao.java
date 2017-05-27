package com.souky.dao.base;

import java.util.List;

public interface BaseDao<T> {
	
	List<T> findAll();
	
	int save(T entity);
	
	void delete(T entity);
	
	void update(T entity);
	
	T queryById(int id);
	
}
