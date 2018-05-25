package com.jy.moudles.user.service.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.excelUtil.ExportExcel;
import com.jy.moudles.user.dao.UserDao;
import com.jy.moudles.user.entity.User;
import com.jy.moudles.user.service.UserService;



@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	
	@Override
	public User getUserByNameAndPwd(String userName, String password) {
		return userDao.getUserByNameAndPwd(userName, password);
	}

	@Override
	public void modifyPassword(User user) {
		userDao.modifyPassword(user.getId(), user.getPassword());
	}
	
	@Override
	public User getUserById(String id) {
		return userDao.getUserById(id);
	}
	
	@Override
	public void addUser(User user) {
		userDao.insertUser(user);
	}

	@Override
	public void updateUser(User user) {
		userDao.updateUser(user);
	}

	@Override
	public void grentRole(String userId, String roleId) {
		User user = new User();
		user.setId(userId);
		user.setRoleId(roleId);
		userDao.updateUser(user);
	}

	@Override
	public void grentOrganization(String userId, List<String> organizationids) {
		// TODO Auto-generated method stub
		
	}

	
	/**
	 * 导出
	 */
	@Override
	public void exportUsers(HttpServletResponse response,Map<String, Object> filter){
		//TODO
		List<User> list = null;
		ExportExcel ee = new ExportExcel("用户列表",User.class);
		ee.setDataList(list);
		try {
			ee.write(response,"userList.xlsx" );
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 查询电话号码
	 */
	@Override
	public User checkPhone(String phone) throws Exception {
		return userDao.checkPhone(phone);
	}
	
	/**
	 * 查询邮箱
	 */
	@Override
	public User checkEmail(String email) throws Exception {
		return userDao.checkEmail(email);
	}
	
	/**
	 * 查询姓名
	 * @param phone
	 * @return
	 * @throws Exception
	 */
	@Override
	public User checkName(String name) throws Exception{
		return userDao.checkName(name);
	}
		
	/**
	 * 查询用户名
	 * @param email
	 * @return
	 * @throws Exception
	 */
	@Override
	public User checkUserName(String userName) throws Exception{
		return userDao.checkUserName(userName);
	}
	
	@Override
	public void deleteUserById(String id) {
		userDao.deleteUserById(id);
	}

	@Override
	public void deleteUsers(List<String> ids) {
		userDao.deleteUsers(ids);
	}

	@Override
	public List<User> queryUserFilter(Map<String, Object> filter) {
		return userDao.queryUserFilter(filter);
	}

}
