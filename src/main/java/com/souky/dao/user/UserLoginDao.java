package com.souky.dao.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.souky.common.utils.UUIDUtil;
import com.souky.dao.base.BaseDao;
import com.souky.entity.user.UserLogin;

@Repository
public class UserLoginDao extends BaseDao<UserLogin>{
	
	private static final String enables = "1";
	private static final String unenables = "0";
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<UserLogin> findAll() {
		String sql = "select u.*,j.jurisdiction_name jurisdictionName,j.identification identification  "
				+ " from user_login u left join jurisdiction j on u.jurisdiction_id = j.id ";
		List<String> list = new ArrayList<String>();
		List<UserLogin> lists = jdbcTemplate.query(sql, new BeanPropertyRowMapper(UserLogin.class), list.toArray());
		return lists;
	}

	public int save(UserLogin entity) {
		String sql = "insert into user_login (id,login_name,pass_word,jurisdiction_id,info_id,nickname"
				+ ",login_time,register_time,enabled) values (?,?,?,?,?,?,?,?,?)";
		List<Object> list = new ArrayList<Object>();
		String id = UUIDUtil.get32UUID();
		list.add(id);
		list.add(entity.getLoginName());
		list.add(entity.getPassWord());
		list.add(entity.getJurisdictionId());
		list.add(entity.getInfoId());
		list.add(entity.getNickname());
		list.add(entity.getLoginTime());
		list.add(new Date());
		list.add(enables);
		return jdbcTemplate.update(sql, list.toArray());
	}

	public int delete(UserLogin entity) {
		String sql = "update user_login set enabled = ? where id = ?";
		List<Object> list = new ArrayList<Object>();
		list.add(unenables);
		list.add(entity.getId());
		return jdbcTemplate.update(sql, list.toArray());
	}

	public int update(UserLogin entity) {
		String sql = "update user_login set ";
		List<Object> list = new ArrayList<Object>();
		sql += " id = ? ";
		list.add(entity.getId());
		if(null != entity.getLoginName()) {
			sql +=" and login_name = ?";
			list.add(entity.getLoginName());
		}
		if(null != entity.getPassWord()) {
			sql +=" and pass_word = ?";
			list.add(entity.getPassWord());
		}
		if(null != entity.getJurisdictionId()) {
			sql +=" and jurisdiction_id = ?";
			list.add(entity.getJurisdictionId());
		}
		if(null != entity.getInfoId()) {
			sql +=" and info_id = ?";
			list.add(entity.getInfoId());
		}
		if(null != entity.getNickname()) {
			sql +=" and nickname = ?";
			list.add(entity.getNickname());
		}
		if(null != entity.getLoginTime()) {
			sql +=" and login_time = ?";
			list.add(entity.getLoginTime());
		}
		if(null != entity.getRegisterTime()) {
			sql +=" and register_time = ?";
			list.add(entity.getRegisterTime());
		}
		if(null != entity.getEnabled()) {
			sql +=" and enabled = ?";
			list.add(entity.getEnabled());
		}
		sql += "where id = ?";
		list.add(entity.getId());
		return jdbcTemplate.update(sql, list.toArray());
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<UserLogin> queryById(String id) {
		String sql = "select u.*,j.jurisdiction_name jurisdictionName,j.identification identification  "
				+ " from user_login u left join jurisdiction j on u.jurisdiction_id = j.id "
				+ "where u.id=?";
		List<Object> list = new ArrayList<Object>();
		list.add(id);
		List<UserLogin> lists = jdbcTemplate.query(sql, new BeanPropertyRowMapper(UserLogin.class), list.toArray());
		return lists;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<UserLogin> queryByLoginName(String loginName) {
		String sql = "select u.*,j.jurisdiction_name jurisdictionName,j.identification identification  "
				+ " from user_login u left join jurisdiction j on u.jurisdiction_id = j.id "
				+ "where u.login_name=?";
		List<Object> list = new ArrayList<Object>();
		list.add(loginName);
		List<UserLogin> lists = jdbcTemplate.query(sql, new BeanPropertyRowMapper(UserLogin.class), list.toArray());
		return lists;
	}
}
