package com.souky.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.souky.dao.user.UserInfoDao;
import com.souky.entity.user.UserInfo;
import com.souky.service.user.UserInfoService;

@Service("UserInfoService")
public class UserInfoServiceImpl implements UserInfoService{
	
	@Autowired
	private UserInfoDao userInfoDao;
	
	public List<UserInfo> findAll() {
		return userInfoDao.findAll();
	}

	public int save(UserInfo entity) {
		return userInfoDao.save(entity);
	}

	public void update(UserInfo entity) {
		userInfoDao.update(entity);
	}

	public void delete(UserInfo entity) {
		userInfoDao.delete(entity);
	}

	public UserInfo queryById(int id) {
		return userInfoDao.queryById(id);
	}

}
