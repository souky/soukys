package com.jy.moudles.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jy.common.persistence.annotation.MyBatisDao;
import com.jy.moudles.user.entity.User;

@MyBatisDao
public interface UserDao {
	
	
	/**
	 * 根据Id集合批量删除user列表对象
	 *
	 * @param ids
	 */
	public void deleteUsers(List<String> ids);
	
	/**
	 * 根据id删除用户
	 * @param id
	 */
	void deleteUserById(@Param("id")String id);
	
	/**
	 * 根据登录名和密码获取用户信息
	 * 
	 * @param userName
	 * @param password
	 * @return
	 */
	User getUserByNameAndPwd(@Param("userName") String userName, @Param("password")String password);
	
	/**
	 * 根据ID修改密码
	 * 
	 * @param id
	 * @param password
	 * @return
	 */
	void modifyPassword(@Param("id") String id, @Param("password")String password);

	/**
	 * 根据ID获取用户
	 * @param id
	 * @return
	 */
	public User getUserById(String id);
	
	/**
	 * 新增用户
	 *  
	 * @param user
	 */
	public void insertUser(User user);
	
	/**
	 * 修改用户
	 *  
	 * @param user
	 */
	public void updateUser(User user);
	
	/**
	 * 查询电话号码
	 * @param phone
	 * @return
	 * @throws Exception
	 */
	User checkPhone(String phone) throws Exception;
		
	/**
	 * 查询邮箱
	 * @param email
	 * @return
	 * @throws Exception
	 */
	User checkEmail(String email) throws Exception;
	
	/**
	 * 查询姓名
	 * @param phone
	 * @return
	 * @throws Exception
	 */
	User checkName(String name) throws Exception;
		
	/**
	 * 查询用户名
	 * @param email
	 * @return
	 * @throws Exception
	 */
	User checkUserName(String userName) throws Exception;
	
	/**
	 * 查询user
	 *
	 * @param ids
	 */
	public List<User> queryUserFilter(Map<String, Object> filter);
	
}
