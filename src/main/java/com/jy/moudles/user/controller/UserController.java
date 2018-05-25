package com.jy.moudles.user.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.MD5Util;
import com.jy.common.utils.UUIDUtil;
import com.jy.common.utils.LogUtil;
import com.jy.common.validate.Validator;
import com.jy.moudles.organization.service.OrganizationService;
import com.jy.moudles.systemLog.constants.LogOperationType;
import com.jy.moudles.user.entity.User;
import com.jy.moudles.user.service.UserService;


@Controller
@RequestMapping(value="/user")
public class UserController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	private static final String DEFAULT_PASSWORD = "123456";
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OrganizationService orgService;
	
	
	/**
	 *
	 * @param
	 */
	@RequestMapping(value = "/getUsers", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getUsers(@RequestParam int pageNum,@RequestParam int pageSize){
    	LOGGER.info("查询用户开始");
    	PageHelper.startPage(pageNum, pageSize);
    	PageInfo<User> userList = new PageInfo<User>(userService.queryUserFilter(null));
		LOGGER.info("查询用户结束 ");
		return AsyncResponseData.getSuccess(userList);
	}
	
	/**
	 * 批量删除
	 * @param ids
	 */
	@RequestMapping(value = "/deleteUsers", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteUsers(@RequestParam List<String> ids,HttpServletRequest request){
    	LOGGER.info("批量删除用户开始");
		for (String userId : ids) {
			//删除user对应的管理机构
			orgService.deleteOwnOrgByUserId(userId);
		}
		userService.deleteUsers(ids);
		LogUtil.addLog("批量删除用户", LogOperationType.DELETE,request);
		LOGGER.info("批量删除用户结束 ");
		return AsyncResponseData.getSuccess();
	}
	

    /**
     * getUserById
     * @param id
     * @return
     */
    @RequestMapping(value = "/getUserById", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData getUserById(@RequestParam String id){
    	User user  = userService.getUserById(id);
    	if (null != user){
    		return AsyncResponseData.getSuccess(user);
    	} else {
    		return AsyncResponseData.getSuccess().asParamError("该用户不存在");
    	}
    }
    
    /**
     * editUser
     * @param user
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = "/editUser", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData editUser(User user,HttpServletRequest request) throws Exception{
    	LOGGER.info("编辑用户信息");
    	//校验姓名重复性
    	User userExits = userService.checkName(user.getName());
  		if(userExits != null){
  			if(userExits.getId() != null && !userExits.getId().equals(user.getId())) {
  				return AsyncResponseData.getSuccess().asParamError("姓名已存在,请重新输入");
  			}
  		}
  		
  		userExits = userService.checkUserName(user.getUserName());
  		if(userExits != null){
  			if(userExits.getId() != null && !userExits.getId().equals(user.getId())) {
  				return AsyncResponseData.getSuccess().asParamError("用户名已存在,请重新输入");
  			}
  		}
  		
  		userExits = userService.checkPhone(user.getPhone());
  		if(userExits != null){
  			if(userExits.getId() != null && !userExits.getId().equals(user.getId())) {
  				return AsyncResponseData.getSuccess().asParamError("电话号码已存在,请重新输入");
  			}
  		}
  		
    	Date now = new Date();
		User authUser = LoginInterceptor.getCurrentUser();
		if (!StringUtils.isBlank(user.getId())){
			user.setUpdateDate(now);
			user.setUpdateUser(authUser.getId());
			userService.updateUser(user);
			LogUtil.addLog("编辑用户信息", LogOperationType.EDIT,request);

		}else {
			user.setId(UUIDUtil.get32UUID());
			user.setUserName(user.getUserName());
			user.setPhone(user.getPhone());
			// 发送短信，密码随机生成
			//String password = RandomCodeUtil.getStringRandom(6);
			//System.out.println(password);
			user.setPassword(MD5Util.MD5(DEFAULT_PASSWORD));
			user.setCreateUser(authUser.getId());
			user.setCreateDate(now);
			user.setUpdateUser(authUser.getId());
			user.setUpdateDate(now);
			userService.addUser(user);
			LogUtil.addLog("编辑用户信息", LogOperationType.ADD,request);
		}
    	
    	return AsyncResponseData.getSuccess();
    }
    
    /**
     * 删除用户
     * @param id
     */
    @RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData deleteUser(String id,HttpServletRequest request){
    	LOGGER.info("删除用户开始");
    	userService.deleteUserById(id);
    	//删除用户可管理的组织机构关系
		orgService.deleteOwnOrgByUserId(id);
		LogUtil.addLog("删除用户", LogOperationType.DELETE,request);
    	LOGGER.info("删除用户结束");
    	return AsyncResponseData.getSuccess();
    }
    
    /**
     * grentUserRolePermission
     * @param userId
     * @param organizationids
     * @return
     */
    @RequestMapping(value = "/grentUserOrganization", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData grentUserRolePermission(@RequestParam String userId, @RequestParam List<String> organizationids,HttpServletRequest request){
    	
    	orgService.batchInsertOwnOrg(userId, organizationids);
		LogUtil.addLog("组织机构授权", LogOperationType.AUTHORIZE,request);
    	LOGGER.info("插入用户可管理的组织机构信息");
    	return AsyncResponseData.getSuccess();
    }
  	
  	/**
  	 * 查询用户信息
  	 * @return
  	 * @throws Exception
  	 */
  	@RequestMapping(value = "/queryUserById")
  	@ResponseBody
  	public AsyncResponseData.ResultData queryUserById() throws Exception {
  		//获取用户的id
		User authUser = LoginInterceptor.getCurrentUser();
  		User user = userService.getUserById(authUser.getId());
  		return AsyncResponseData.getSuccess(user);
  	}
  	
  	/**
  	 * 导出user
  	 */
  	@RequestMapping(value = "/exportUsers", method = RequestMethod.GET)
  	@ResponseBody
  	public void exportUsers(HttpServletResponse response,User user){
  		Map<String, Object> filter = new HashMap<String, Object>();
  		filter.put("name", user.getName());
		filter.put("userName", user.getUserName());
		filter.put("phone", user.getPhone());
		userService.exportUsers(response, filter);
  	}
  	
  	
  	/**
  	 * 校验并修改用户信息
  	 * @param user
  	 * @return
  	 * @throws Exception
  	 */
   	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
   	@ResponseBody
  	public AsyncResponseData.ResultData updateUser(User user, HttpServletRequest request) throws Exception {
    	LOGGER.info("用户编辑个人信息开始");
   		String errors = "";
   		
  		if (user.getName() == "" || user.getName() == null) {
  			errors = "姓名不能为空!";
  			return AsyncResponseData.getSuccess().asParamError(errors);
  		}
  		User userExits = userService.checkName(user.getName());
  		if(userExits != null){
  			if(userExits.getId() != null && !userExits.getId().equals(user.getId())) {
  				return AsyncResponseData.getSuccess().asParamError("姓名已存在,请重新输入");
  			}
  		}
  		
  		if (!Validator.checkStringLength(user.getName(), 2, 20)) {
  			errors = "姓名的字符要求是2到20个字符!";
  			return AsyncResponseData.getSuccess().asParamError(errors);
  		}
  		if(user.getAge() == null ||user.getAge() > 150  || user.getAge() < 1){
  			errors = "年龄不符合范围!";
  			return AsyncResponseData.getSuccess().asParamError(errors);
  		}
  		if (user.getPhone() == "" || user.getPhone() == null) {
  			errors = "电话号码不能为空!";
  			return AsyncResponseData.getSuccess().asParamError(errors);
  		}
  		userExits = userService.checkPhone(user.getPhone());
  		if(userExits != null){
  			if(userExits.getId() != null && !userExits.getId().equals(user.getId())) {
  				return AsyncResponseData.getSuccess().asParamError("电话号码已存在,请重新输入");
  			}
  		}
  		
  		if (!Validator.checkStringLen(user.getPhone(), 11)) {
  			errors = "电话号码的字符要求是11个字符!";
  			return AsyncResponseData.getSuccess().asParamError(errors);
  		}
  		if (user.getEmail() == "" || user.getEmail() == null) {
  			errors = "邮箱不能为空!";
  			return AsyncResponseData.getSuccess().asParamError(errors);
  		}
  		userExits = userService.checkEmail(user.getEmail());
  		if(userExits != null){
  			if(userExits.getId() != null && !userExits.getId().equals(user.getId())) {
  				return AsyncResponseData.getSuccess().asParamError("邮箱已存在,请重新输入");
  			}
  		}
  		
  		if (!Validator.checkStringLength(user.getEmail(), 1, 50)) {
  			errors = "邮箱的字符要求是1到50个字符!";
  			return AsyncResponseData.getSuccess().asParamError(errors);
  		} 
  		//如果通过校验，实现更新，返回成功信息
  		user.setUpdateDate(new Date());
		userService.updateUser(user);
		LogUtil.addLog("修改个人信息", LogOperationType.EDIT, request);
		return AsyncResponseData.getSuccess();
  	}
  	
	/**
	 * 修改密码
	 * 满足更新的前提条件：
	 * (1)输入的原密码和数据库中的密码相同。
	 * (2)输入的新密码必须要与原密码不同。
	 * (3)输入的新密码必须要和确认新密码相同。
	 * @param newPassWord 新密码
	 * @param newPassWords 新密码确认
	 * @param inputPassWord 旧密码
	 * @return 
	 */
  	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updatePassword(String newPassWord, String newPassWords, String inputPassWord, HttpServletRequest request) throws Exception {
		String errorsMsg = "";
  		if(StringUtils.isBlank(newPassWord) || StringUtils.isBlank(inputPassWord) || StringUtils.isBlank(newPassWords)){
  			return AsyncResponseData.getSuccess().asParamError("参数不能为空");
  		}
  		if(!newPassWord.equals(newPassWords)){
			return AsyncResponseData.getSuccess().asParamError("输入的确认新密码与新密码不一致");
		}
  		User authUser = LoginInterceptor.getCurrentUser();
  		if(authUser == null){
  			return AsyncResponseData.getSuccess().asParamError("请退出重新登录");
  		}
  		String userId = authUser.getId();
  		User user = userService.getUserById(userId);
  		if(user == null){
  			return AsyncResponseData.getSuccess().asParamError("查询不到用户信息,请退出重新登录");
  		}
		//如果输入的原密码与数据库中的密码相同可更改
		if (!MD5Util.MD5(inputPassWord).toLowerCase().equals(user.getPassword())) {
			errorsMsg += "注意：你输入的原密码错误！";
			return AsyncResponseData.getDenied(errorsMsg);
		}
		if ((MD5Util.MD5(newPassWord).toLowerCase()).equals(user.getPassword())) {
			//如果输入的新密码与数据库中的密码相同，也是不可以的。
			errorsMsg += "注意：输入的新旧密码不能一样！  ";
			return AsyncResponseData.getDenied(errorsMsg);
		}
		user.setPassword(MD5Util.MD5(newPassWord).toLowerCase());
		userService.modifyPassword(user);
		LogUtil.addLog("修改密码", LogOperationType.EDIT, request);
		return AsyncResponseData.getSuccess();
  	}
  	
}
