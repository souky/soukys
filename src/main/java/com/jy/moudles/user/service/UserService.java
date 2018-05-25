package com.jy.moudles.user.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.jy.moudles.user.entity.User;

public interface UserService {

	public User getUserByNameAndPwd(String userName, String password);
	
	
	/**
	 * 查询user
	 *
	 * @param ids
	 */
	public List<User> queryUserFilter(Map<String, Object> filter);
	
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
	void deleteUserById(String id);
	
    /**
     * 根据ID修改密码
     *
     * @param user
     * @return
     */
    void modifyPassword(User user);

    /**
     * 添加用户
     * 
     * @param user
     */
    public void addUser(User user);
    
    /**
     * 修改用户
     * 
     * @param user
     */
    public void updateUser(User user);
    
    /**
	 * 根据ID获取用户
	 * @param id
	 * @return
	 */
	public User getUserById(String id);
	
	/**
	 * 赋予角色权限
	 * 
	 * @param userId
	 * @param roleId
	 */
	public void grentRole(String userId, String roleId);
	
	/**
	 * 用户管理机构
	 * 
	 * @param userId
	 * @param organizationids
	 */
	public void grentOrganization(String userId, List<String> organizationids);
	

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
	 * 导出
	 * @param response
	 * @param filter
	 */
	void exportUsers(HttpServletResponse response, Map<String, Object> filter);
	
}
