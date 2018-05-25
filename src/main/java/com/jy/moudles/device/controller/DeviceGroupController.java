package com.jy.moudles.device.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.device.timer.DeviceOpenAndCloseTimer;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.moudles.device.VO.DeviceVO;
import com.jy.moudles.device.entity.Device;
import com.jy.moudles.device.entity.DeviceGroup;
import com.jy.moudles.device.service.DeviceGroupService;
import com.jy.moudles.device.service.DeviceService;
import com.jy.moudles.user.entity.User;

import javax.servlet.http.HttpServletRequest;

/** 
 * deviceGroup
 * wb
 */
@Controller
@RequestMapping(value="/devicegroup")
public class DeviceGroupController {
	
	@Autowired
	private DeviceService deviceService;
	
	@Autowired
	private DeviceGroupService devicegroupService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DeviceGroupController.class);
	
	/**
	 * 保存devicegroup
	 * 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveDeviceGroup", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveDeviceGroup(HttpServletRequest request) throws Exception{
		LOGGER.info("保存DeviceGroup Start");
        String id = request.getParameter("id");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String controlModuleStr = request.getParameter("controlModule");
        String isActiveStr = request.getParameter("isActive");
        String groupName = request.getParameter("groupName");
		if(StringUtils.isBlank(groupName)){
			return AsyncResponseData.getSuccess().asParamError("分组名不能为空");
		}

        Map<String, Object> filter = new HashMap<>();
        filter.put("groupName", groupName);
        List<DeviceGroup> deviceGroups = devicegroupService.queryDeviceGroupsFilter(filter);
        if(deviceGroups != null && !deviceGroups.isEmpty()){
            if(!deviceGroups.get(0).getId().equals(id)){
                return AsyncResponseData.getSuccess().asParamError("该分组名已经存在");
            }
        }

        if(StringUtils.isBlank(startTimeStr) || StringUtils.isBlank(endTimeStr)){
            return AsyncResponseData.getSuccess().asParamError("开始时间和结束时间不能为空");
        }

        DeviceGroup devicegroup = new DeviceGroup();
        try{
            //校验日期
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date startTime = sdf.parse(startTimeStr);
            Date endTime = sdf.parse(endTimeStr);
            if(startTime.after(endTime) || startTime.equals(endTime)){
                return AsyncResponseData.getSuccess().asParamError("结束时间必须大于开始时间");
            }

            filter.clear();
            deviceGroups = devicegroupService.queryDeviceGroupsFilter(filter);
            if(deviceGroups != null && !deviceGroups.isEmpty()){
                for(DeviceGroup d : deviceGroups){
                    if(!d.getId().equals(id)){
                        if(!(endTime.getTime() <= d.getStartTime().getTime() || startTime.getTime() >= d.getEndTime().getTime())){
                            return AsyncResponseData.getSuccess().asParamError("存在两个设备分组开启/结束时间冲突");
                        }
                    }
                }
            }
            //校验
            int controlModule = 0;
            if(StringUtils.isNotBlank(controlModuleStr)){
                controlModule = Integer.parseInt(controlModuleStr);
            }
            int isActive = 0;
            if(StringUtils.isNotBlank(isActiveStr)){
                isActive = Integer.parseInt(isActiveStr);
            }

            devicegroup.setGroupName(groupName);
            devicegroup.setStartTime(startTime);
            devicegroup.setEndTime(endTime);
            devicegroup.setControlModule(controlModule);
            devicegroup.setIsActive(isActive);
            devicegroup.setId(id);

        }catch(ParseException pe){
            LOGGER.info("日期转换错误");
            return AsyncResponseData.getSuccess().asParamError("网络错误");
        }catch(NumberFormatException nfe){
            LOGGER.info("数字转换异常");
            return AsyncResponseData.getSuccess().asParamError("网络错误");
        }


		User user = LoginInterceptor.getCurrentUser();
        if(user == null){
        	return AsyncResponseData.getSuccess().asParamError("查询不到用户信息,请重新登录");
		}
		if(StringUtils.isBlank(devicegroup.getId())){
			devicegroup.setId(UUIDUtil.get32UUID());
			devicegroup.setCreateUser(user.getId());
			devicegroup.setCreateDate(new Date());
			devicegroup.setUpdateDate(new Date());
			devicegroup.setUpdateUser(user.getId());
			devicegroup.setOrgId(user.getOrgId());
			Integer groupNo = devicegroupService.getMaxGroupNo();
			if(groupNo == null){
				groupNo = 1;
			}else{
				groupNo += 1;
			}
			devicegroup.setGroupNo(groupNo);
			devicegroupService.insertDeviceGroup(devicegroup);
		}else{
            devicegroup.setUpdateDate(new Date());
            devicegroup.setUpdateUser(user.getId());
            devicegroupService.updateDeviceGroup(devicegroup);
            //关闭原有timer,开启timer
            DeviceOpenAndCloseTimer.closeTimer(devicegroup.getGroupNo());
        }

        //开启timer
        if(devicegroup.getIsActive() == 1){
            DeviceOpenAndCloseTimer.openPlan(devicegroup);
            DeviceOpenAndCloseTimer.closePlan(devicegroup);
        }
        LOGGER.info("保存DeviceGroup End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 
	 * @param devicegroup
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateDeviceGroup", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateDeviceGroup(DeviceGroup devicegroup) throws Exception{
		LOGGER.info("update DeviceGroup Start");
		
		devicegroupService.updateDeviceGroup(devicegroup);
		
		LOGGER.info("update DeviceGroup End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 
	 * @param devicegroup
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteDeviceGroup", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteDeviceGroup(DeviceGroup devicegroup) throws Exception{
		LOGGER.info("delete DeviceGroup Start");
		
		devicegroupService.deleteDeviceGroupById(devicegroup.getId());
		
		LOGGER.info("delete DeviceGroup End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 
	 * @param devicegroup
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryDeviceGroups", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryDeviceGroups(DeviceGroup devicegroup,int pageNum,int pageSize) throws Exception{
		LOGGER.info("query DeviceGroupList Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		PageHelper.startPage(pageNum, pageSize);
		List<DeviceGroup> devicegroups= devicegroupService.queryDeviceGroupsFilter(filter);
		PageInfo<DeviceGroup> pages = new PageInfo<DeviceGroup>(devicegroups);
		LOGGER.info("query DeviceGroupList End");
		
		return AsyncResponseData.getSuccess(pages);
	}
	
	/**
	 * 
	 * @param devicegroup
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryDeviceGroupById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryDeviceGroupById(DeviceGroup devicegroup) throws Exception{
		LOGGER.info("query DeviceGroup Start");
		
		if(StringUtils.isNotBlank(devicegroup.getId())){
			devicegroup = devicegroupService.getDeviceGroupById(devicegroup.getId());
		}
		
		LOGGER.info("query DeviceGroup End");
		
		return AsyncResponseData.getSuccess(devicegroup);
	}
	
	/**
	 * 获取分组对应的设备列表
	 */
	@RequestMapping(value = "/queryDevicesByGroupNo", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryDevicesByGroupNo(DeviceGroup deviceGroup) throws Exception{
		LOGGER.info("query device by group start");
		List<Device> devices = deviceService.queryDevicesByGroupNo(deviceGroup.getId());
		LOGGER.info("query device by group end");
		return AsyncResponseData.getSuccess(devices);
	}
	
	/**
	 * 获取所有阻断设备,包含已经在分组的
	 */
	@RequestMapping(value = "/queryDevicesAndSelected", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryDevicesAndSelected(DeviceGroup deviceGroup) throws Exception{
		LOGGER.info("query device by group start");
		List<Device> devices = deviceService.queryDevicesByGroupNo(deviceGroup.getId());
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("type", "2");
		List<Device> deviceAll = deviceService.queryDevicesFilter(filter);
		List<DeviceVO> vos = new ArrayList<>();
		for(Device device : deviceAll){
			DeviceVO vo = new DeviceVO();
			vo.setIp(device.getIp());
			vo.setMac(device.getMac());
			vo.setAddress(device.getAddress());
			for(Device d : devices){
				if(d.getId().equals(device.getId())){
					vo.setSelected(true);
					vo.setGroupId(deviceGroup.getId());
				}
			}
			vos.add(vo);
		}
		
		LOGGER.info("query device by group end");
		return AsyncResponseData.getSuccess(vos);
	}
	
	
	/**
	 * 保存设备分组
	 */
	@RequestMapping(value = "/saveDeviceGroupNo", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveDeviceGroupNo(String groupId,String macs) throws Exception{
		//先将符合分组的全部置为空,在重新添加
		if(StringUtils.isNoneBlank(groupId) || StringUtils.isNoneBlank(macs)){
			deviceService.deleteDeviceGroupNo(groupId);
			String [] mac = macs.split(",");
			List<String> list = Arrays.asList(mac);
			if(list != null && list.size() > 0){
				deviceService.addDeviceGroupNo(groupId, list);
			}
		}
		
		
		return AsyncResponseData.getSuccess("成功");
	}
	
	/**
	 * 删除设备分组对应的设备
	 */
	@RequestMapping(value = "/deleteDeviceGroupNo", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteDeviceGroupNo(String id) throws Exception{
		if(StringUtils.isNoneBlank(id)){
			deviceService.deleteDeviceGroupNo(id);
		}
		return AsyncResponseData.getSuccess("成功");
	}
}
