package com.souky.dao.user;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.souky.dao.base.BaseDao;
import com.souky.entity.user.UserInfo;
import com.souky.entity.user.UserLogin;

@Repository
public class UserLoginDao implements BaseDao<UserLogin>{

	@Autowired
	JdbcTemplate jdbcTemplate;

	public List<UserLogin> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public int save(UserLogin entity) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int delete(UserLogin entity) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int update(UserLogin entity) {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<UserLogin> queryById(int id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<UserLogin> queryByLoginName(String loginName) {
		String sql = "select u.*,j.jurisdiction_name jurisdictionName,j.identification identification  "
				+ " from user_info u left join jurisdiction j on u.jurisdiction_id = j.id "
				+ "where u.login_name=?";
		List<String> list = new ArrayList<String>();
		list.add(loginName);
		List<UserLogin> lists = jdbcTemplate.query(sql, new BeanPropertyRowMapper(UserLogin.class), list.toArray());
		return lists;
	}
}
