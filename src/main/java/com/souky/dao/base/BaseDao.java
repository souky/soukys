package com.souky.dao.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class  BaseDao<T> {
	
	public List<T> findAll(){
		return null;
	};
	
	public int save(T entity){
		return 0;
	};
	
	public int delete(T entity){
		return 0;
	};
	
	public int update(T entity){
		return 0;
	};
	
	public List<T> queryById(int id){
		return null;
	};
	
	@Autowired
	public JdbcTemplate jdbcTemplate;
	
}
