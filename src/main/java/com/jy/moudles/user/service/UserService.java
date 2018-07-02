package com.jy.moudles.user.service;

import com.jy.moudles.user.entity.User;
import java.util.List;
import java.util.Map;

/** 
 * User业务接口
 * 创建人：Administrator
 * 创建时间：2018-05-24
 */
public interface UserService {

	/**
	 * 新增User对象
	 *
	 * @param User
	 */
	public void insertUser(User User);
	
	/**
	 * 更新User对象
	 *
	 * @param User
	 */
	public void updateUser(User User);
	
	/**
	 * 根据ID获取User对象
	 *
	 * @param id
	 */
	public User getUserById(String id);
	
	/**
	 * 根据用户名密码获取User对象
	 *
	 * @param id
	 */
	public User getUserByNameAndPwd(User user);
	
	/**
	 * 根据过滤条件获取User列表对象
	 *
	 * @param filter
	 */
	public List<User> queryUsersFilter(Map<String, Object> filter);
	
	/**
	 * 根据Id删除User列表对象
	 *
	 * @param id
	 */
	public void deleteUserById(String id);
	
	/**
	 * 根据Id集合批量删除User列表对象
	 *
	 * @param ids
	 */
	public void deleteUsers(List<String> ids);
	
	/**
	 * 查询同组织机构用户
	 *
	 * @param filter
	 */
	public List<User> queryFriends(User user);
	
}

