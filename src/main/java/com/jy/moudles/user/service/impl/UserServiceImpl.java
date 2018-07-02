package com.jy.moudles.user.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.moudles.user.dao.UserDao;
import com.jy.moudles.user.entity.User;
import com.jy.moudles.user.service.UserService;

/** 
 * User业务实现类
 * 创建人：Administrator
 * 创建时间：2018-05-24
 */
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao UserDao;
	
	@Override
	public void insertUser(User User){
		UserDao.insertUser(User);
	}
	
	@Override
	public void updateUser(User User){
		UserDao.updateUser(User);
	}
	
	@Override
	public User getUserById(String id){
		return UserDao.getUserById(id);
	}
	
	@Override
	public List<User> queryUsersFilter(Map<String, Object> filter){
		return UserDao.queryUsersFilter(filter);
	}
	
	@Override
	public void deleteUserById(String id){
		UserDao.deleteUserById(id);
	}
	
	@Override
	public void deleteUsers(List<String> ids){
		UserDao.deleteUsers(ids);
	}

	@Override
	public User getUserByNameAndPwd(User user) {
		return UserDao.getUserByNameAndPwd(user);
	}

	@Override
	public List<User> queryFriends(User user) {
		return UserDao.queryFriends(user);
	}
	
}

