package com.souky.service.user;

import java.util.List;

import com.souky.entity.user.UserInfo;

public interface UserInfoService {
	List<UserInfo> findAll();
	int save(UserInfo entity);
	void update(UserInfo entity);
	void delete(UserInfo entity);
	UserInfo queryById(int id);
}
