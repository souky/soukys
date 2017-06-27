package com.souky.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.souky.dao.user.UserLoginDao;
import com.souky.entity.user.UserLogin;

@Service
public class UserLoginService {

	@Autowired
	private UserLoginDao userLoginDao;
	
	public List<UserLogin> queryByLoginName(String loginName) {
		return userLoginDao.queryByLoginName(loginName);
	}
}
