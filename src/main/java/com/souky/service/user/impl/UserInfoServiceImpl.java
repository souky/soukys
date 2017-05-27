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
	
	@Override
	public List<UserInfo> findAll() {
		return userInfoDao.findAll();
	}

	@Override
	public int save(UserInfo entity) {
		return userInfoDao.save(entity);
	}

	@Override
	public void update(UserInfo entity) {
		userInfoDao.update(entity);
	}

	@Override
	public void delete(UserInfo entity) {
		userInfoDao.delete(entity);
	}

	@Override
	public UserInfo queryById(int id) {
		return userInfoDao.queryById(id);
	}

}
