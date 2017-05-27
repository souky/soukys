package com.souky.dao.user.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.souky.common.Sessions;
import com.souky.dao.user.UserInfoDao;
import com.souky.entity.user.UserInfo;

@Repository("UserInfoDao")
public class UserInfoDaoImpl extends Sessions implements UserInfoDao {

	@SuppressWarnings("unchecked")
	public List<UserInfo> findAll() {
		List<UserInfo> list = getSession().createQuery("from user_info").list();
		return list;
	}

	public int save(UserInfo entity) {
		int i = (Integer) getSession().save(entity);
		return i;
	}

	public void update(UserInfo entity) {
		getSession().update(entity);
	}

	public void delete(UserInfo entity) {
		getSession().delete(entity);
	}

	public UserInfo queryById(int id) {
		return (UserInfo) getSession().load(UserInfo.class, id);
	}

	
}
