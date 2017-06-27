package com.souky.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.souky.dao.user.UserInfoDao;
import com.souky.entity.user.UserInfo;

@Service
public class UserInfoService {
	@Autowired
	private UserInfoDao userInfoDao;
	
	@SuppressWarnings("unchecked")
	public List<UserInfo> findAll() {
		return userInfoDao.findAll();
	}

	public int save(UserInfo entity) {
		return userInfoDao.save(entity);
	}

	public int update(UserInfo entity) {
		return userInfoDao.update(entity);
	}

	public int delete(UserInfo entity) {
		return userInfoDao.delete(entity);
	}


	@SuppressWarnings("unchecked")
	public List<UserInfo> queryById(int id) {
		return userInfoDao.queryById(id);
	}
	
}
