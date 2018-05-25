package com.jy.moudles.role.controller;


import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.LogUtil;
import com.jy.moudles.systemLog.constants.LogOperationType;
import com.jy.moudles.user.entity.User;
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
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.role.entity.Role;
import com.jy.moudles.role.service.RoleService;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * wb
 * 创建时间2017-10-20
 */
@Controller
@RequestMapping(value="/role")
public class RoleController {
	
	@Autowired
	private RoleService roleService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RoleController.class);
	
	/**
	 * 
	 * @param role
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/editRole", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveRole(Role role, HttpServletRequest request) throws Exception{
		LOGGER.info("编辑Role Start");
		User user = LoginInterceptor.getCurrentUser();
		if(user == null){
			return AsyncResponseData.getSuccess().asParamError("请重新登录");
		}
		if(StringUtils.isBlank(role.getRoleName())){
			return AsyncResponseData.getSuccess().asParamError("角色名称不能为空");
		}
        Map<String, Object> filter = new HashMap<>();
		filter.put("roleName",role.getRoleName());
        List<Role> roles = roleService.queryRolesFilter(filter);
        if(roles != null && !roles.isEmpty()){
            for(Role r : roles){
                if(role.getRoleName().equals(r.getRoleName()) && !r.getId().equals(role.getId())){
                    return AsyncResponseData.getSuccess().asParamError("该角色名称已存在");
                }
            }
        }
		role.setUpdateDate(new Date());
		role.setUpdateUser(user.getId());
		if(!StringUtils.isBlank(role.getId())) {
			roleService.updateRole(role);
			LogUtil.addLog("修改角色信息", LogOperationType.EDIT,request);
		}else {
			role.setId(UUIDUtil.get32UUID());
			role.setCreateDate(new Date());
			role.setCreateUser(user.getId());
			roleService.insertRole(role);
			LogUtil.addLog("新增角色信息",LogOperationType.ADD,request);
		}
		
		
		LOGGER.info("编辑Role End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 
	 * @param role
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteRole", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteRole( Role role, HttpServletRequest request) throws Exception{
		LOGGER.info("删除Role Start");
		
		roleService.deleteRoleById(role.getId());
		LogUtil.addLog("删除角色信息",LogOperationType.DELETE,request);
		LOGGER.info("删除Role End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 
	 * @param id
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/getRoleById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getRoleById(String id) throws Exception{
		
		if(StringUtils.isBlank(id)) {
			return AsyncResponseData.getSuccess().asParamError("参数错误");
		}else {
			Role role = roleService.getRoleById(id);
			return AsyncResponseData.getSuccess(role);
		}
	}
	
	/**
	 * 
	 * @param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryRoles", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryRoles(@RequestParam int pageNum,@RequestParam int pageSize) throws Exception{
		
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<Role> roles = new PageInfo<Role>(roleService.queryRolesFilter(null));
		
		return AsyncResponseData.getSuccess(roles);
	}
	
}
