package com.souky.dao.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.souky.dao.base.BaseDao;
import com.souky.entity.user.UserInfo;

@Repository
public class UserInfoDao implements BaseDao<UserInfo>{

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List findAll() {
		String sql = "";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
		return list;
	}

	@SuppressWarnings("rawtypes")
	public int save(UserInfo entity) {
		String sql = "";
		List list = new ArrayList();
		int i = jdbcTemplate.update(sql, list);
		return i;
	}

	
	@SuppressWarnings("rawtypes")
	public int update(UserInfo entity) {
		String sql = "";
		List list = new ArrayList();
		int i = jdbcTemplate.update(sql, list);
		return i;
	}

	@SuppressWarnings("rawtypes")
	public int delete(UserInfo entity) {
		String sql = "";
		List list = new ArrayList();
		int i = jdbcTemplate.update(sql, list);
		return i;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List queryById(int id) {
		String sql = "select u.*,j.name,j.identification "
				+ "from user_info u left join jurisdiction j on u.jurisdiction_id = j.id "
				+ "where u.id=?";
		List list = new ArrayList();
		list.add(id);
		list = jdbcTemplate.queryForList(sql, list);
		return list;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List queryByLoginName(String loginName) {
		String sql = "select u.*,j.name,j.identification "
				+ "from user_info u left join jurisdiction j on u.jurisdiction_id = j.id "
				+ "where u.login_name=?";
		List list = new ArrayList();
		list.add(loginName);
		List<UserInfo> lists = jdbcTemplate.query(sql, BeanPropertyRowMapper.newInstance(UserInfo.class), list.toArray());
		System.out.println(lists);
		return lists;
		//return jdbcTemplate.queryForList(sql,list.toArray());
	}
}
