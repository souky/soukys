package com.jy.moudles.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.UserUtils;
import com.jy.moudles.user.entity.User;
import com.jy.moudles.user.service.UserService;

/** 
 * User实现类
 *
 * 创建人：Administrator
 * 创建时间：2018-05-24
 */
@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	/**
	 * 新增user对象
	 * 
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveUser(User user) throws Exception{
		logger.info("新增User Start");
		
		userService.insertUser(user);
		
		logger.info("新增User End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 修改user对象
	 * 
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateUser(User user,HttpServletRequest request) throws Exception{
		logger.info("修改User Start");
		
		userService.updateUser(user);
		UserUtils.resetUser(request,userService);
		
		logger.info("修改User End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 根据ID获取user对象
	 * 
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping(value = "/getLoginUser", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getLoginUser(HttpServletRequest request) throws Exception{
		logger.info("获取User Start");
		
		User user = UserUtils.getLoginUser(request);
		
		logger.info("获取User End");
		return AsyncResponseData.getSuccess(user);
	}
	
	/**
	 * 删除user对象
	 * 
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteUser(User user) throws Exception{
		logger.info("删除User Start");
		
		userService.deleteUserById(user.getId());
		
		logger.info("删除User End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取user对象
	 * 
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryUsers", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryUsers(User user) throws Exception{
		logger.info("获取User Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<User> users= userService.queryUsersFilter(filter);
		logger.info("获取User End");
		
		return AsyncResponseData.getSuccess(users);
	}
	
	/**
	 * 获取user对象带目标
	 * 
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryUserWithTarger", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryUserWithTarger(String orgCode,String rankTime) 
			throws Exception{
		logger.info("获取User Start");
		
		
		List<User> users= userService.queryUserWithTarget(orgCode, rankTime);
		logger.info("获取User End");
		
		return AsyncResponseData.getSuccess(users);
	}
	
	/**
	 * 获取朋友数据
	 * 
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping(value = "/findFriends", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData findFriends(HttpServletRequest request) throws Exception{
		logger.info("获取friends Start");
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		List<User> users= userService.queryFriends(user);
		logger.info("获取friends End");
		return AsyncResponseData.getSuccess(users);
	}
	
	/**
	 * 根据ID获取user对象
	 * 
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping(value = "/getUserById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getUserById(String id) throws Exception{
		logger.info("获取User Start");
		
		User user = new User();
		
		user = userService.getUserById(id);
		
		logger.info("获取User End");
		
		return AsyncResponseData.getSuccess(user);
	}
	
}
