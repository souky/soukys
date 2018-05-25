package com.jy.moudles.device.controller;

import java.net.URLDecoder;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jy.common.utils.LogUtil;
import com.jy.moudles.device.VO.ResDeviceVO;
import com.jy.moudles.systemLog.constants.LogOperationType;
import com.jy.protocol.common.utils.GeneralProtocol;
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
import com.jy.moudles.device.entity.Device;
import com.jy.moudles.device.service.DeviceService;

/** 
 * 设备
 * xipeng
 * 2017-10-17
 */
@Controller
@RequestMapping(value="/device")
public class DeviceController {
	
	@Autowired
	private DeviceService deviceService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DeviceController.class);
	
	/**
	 *
	 * @param device
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveDevice", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveDevice(Device device,HttpServletRequest request) throws Exception{
		LOGGER.info("saveDevice Start");
		
		deviceService.insertDevice(device);
		LogUtil.addLog("新增设备", LogOperationType.ADD,request);
		LOGGER.info("saveDevice End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 *
	 * @param device
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateDevice", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateDevice(Device device,HttpServletRequest request) throws Exception{
		LOGGER.info("updateDevice Start");

		if(StringUtils.isBlank(device.getAddress())){
			return AsyncResponseData.getSuccess().asParamError("参数错误");
		}
		
		deviceService.updateDevice(device);
		LogUtil.addLog("更新设备信息", LogOperationType.EDIT,request);
		LOGGER.info("updateDevice End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 *
	 * @param device
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteDevice", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteDevice(Device device ,HttpServletRequest request) throws Exception{
    	LOGGER.info("删除设备开始");
		
		deviceService.deleteDeviceById(device.getId());
		LogUtil.addLog("删除设备信息", LogOperationType.DELETE,request);
		LOGGER.info("删除设备结束");
		return AsyncResponseData.getSuccess();
	}
	
	/**
     * 批量删除blackwhitelist对象
     *
     * @return ModelAndView
     * @throws Exception
     */
	@RequestMapping(value = "/deleteDevices", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData deleteDevices(String[] ids,HttpServletRequest request) throws Exception {

        if(ids ==null || ids.length==0) {
			return AsyncResponseData.getDenied("没有要删除的设备！");
		}

    	LOGGER.info("批量删除设备开始");
		
        deviceService.deleteDevices(Arrays.asList(ids));
		LogUtil.addLog("批量删除设备", LogOperationType.DELETE,request);
        LOGGER.info("批量删除设备结束");
        return AsyncResponseData.getSuccess();
    }
    
	/**
	 *
	 * @param device
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryDevices", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryDevices(Device device,HttpServletRequest request) throws Exception{
		LOGGER.info("获取设备开始");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		if(!"".equals(device.getIp()))
			filter.put("ip", device.getIp());

		if(!"".equals(device.getMac()))
			filter.put("mac", device.getMac());

		if(device.getStatus()!=null && -1 < device.getStatus())
			filter.put("status", device.getStatus());

		if(device.getType()!=null && -1 < device.getType())
			filter.put("type", device.getType());
		
		PageHelper.startPage(device.getPageNum(), device.getPageSize());
        PageInfo<Device> devices = null;
        
        List<Device> list = deviceService.queryDevicesFilter(filter);
		devices = new PageInfo<Device>(list);

        LOGGER.info("获取设备结束");
		
		return AsyncResponseData.getSuccess(devices);
	}

    /**
     * 开关屏蔽终端设备
     */
    @RequestMapping(value = "/updateShieldPoweroff", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData updateShieldPoweroff(Device device){
        LOGGER.info("更新屏蔽终端设备开关开始");
        if(StringUtils.isBlank(device.getId()) || device.getPoweroff() == null){
            return AsyncResponseData.getSuccess().asParamError("参数错误");
        }
        Device d = deviceService.getDeviceById(device.getId());
        if(d.getStatus() != 1){
            return AsyncResponseData.getSuccess().asParamError("当前设备状态为离线,请刷新页面后重试");
        }
        d.setPoweroff(device.getPoweroff());
        d.setUpdateDate(new Date());
        deviceService.updateDevice(d);
        LOGGER.info("更新屏蔽终端设备开关结束");
        return AsyncResponseData.getSuccess();
    }

    /**
     * 给屏蔽设备更新list_order
     */
    @RequestMapping(value = "/updateShieldListOrder", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData updateShieldListOrder(String ip, String address, Integer listOrder){
        LOGGER.info("屏蔽终端更新listOrder开始");
        if(StringUtils.isBlank(ip) || listOrder == null){
            return AsyncResponseData.getSuccess().asParamError("参数错误");
        }

        Map<String, Object> filter = new HashMap<>();
        filter.put("listOrder", listOrder);
        List<Device> devices = deviceService.queryDevicesFilter(filter);
        if(devices != null){
            if(devices.size() > 1){
                return AsyncResponseData.getSuccess().asParamError("数据错误");
            }else if(devices.size() == 1){
                if(!ip.equals(devices.get(0).getIp())){
                    return AsyncResponseData.getSuccess().asParamError("该IP已经有对应的排序规则");
                }
            }
        }
        filter.put("ip", ip);
        filter.put("address", address);
        deviceService.updateShieldListOrder(filter);

        LOGGER.info("屏蔽终端更新listOrder结束");
        return AsyncResponseData.getSuccess();
    }


    /**
     * 根据list_order排序获取屏蔽终端
     */
    @RequestMapping(value = "/queryDevicesByListOrder", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData queryDevicesByListOrder(){
        LOGGER.info("根据list_order排序获取屏蔽终端开始");
        List<Device> devices = deviceService.queryDevicesByListOrder();
        Map<Integer, Device> deviceMaps = new HashMap<>();
        if(devices != null && devices.size() > 0){
            for (Device device : devices) {
                if(device.getListOrder() != null){
                    deviceMaps.put(device.getListOrder(), device);
                }
            }
        }
        ResDeviceVO resDeviceVO = new ResDeviceVO();
        resDeviceVO.setDeviceMaps(deviceMaps);
        resDeviceVO.setDevices(devices);
        LOGGER.info("根据list_order排序获取屏蔽终端结束");
        return AsyncResponseData.getSuccess(resDeviceVO);
    }

    /**
     *
     * 查询屏蔽终端ip,过滤list_order不为空的
     */
    @RequestMapping(value = "/queryIPs", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData queryIPs(){
        LOGGER.info("查询屏蔽ip__list开始");
        List<String> ips = deviceService.queryIPs();
        LOGGER.info("查询屏蔽ip__list结束");
        return AsyncResponseData.getSuccess(ips);
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
	@RequestMapping(value = "/queryDeviceById")
	@ResponseBody
	public AsyncResponseData.ResultData queryDeviceById(String id){
		LOGGER.info("根据id=" + id + "查询设备开始");
		if(StringUtils.isBlank(id)){
			return AsyncResponseData.getSuccess().asParamError("参数不能为空");
		}
		Device device = deviceService.getDeviceById(id);
		LOGGER.info("根据id=" + id + "查询设备结束");
		return AsyncResponseData.getSuccess(device);
	}
	
	/**
	 * 下载equipment列表的Excel文件对象
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/exportDeviceList", method = RequestMethod.GET)
	@ResponseBody
	public void exportDeviceList(HttpServletResponse response,Device device) throws Exception{
		device.setIp(URLDecoder.decode(device.getIp(), "UTF-8"));
		device.setMac(URLDecoder.decode(device.getMac(), "UTF-8"));
		Map<String, Object> filter = new HashMap<String, Object>();

		if(!"".equals(device.getIp()))
			filter.put("ip", device.getIp());

		if(!"".equals(device.getMac()))
			filter.put("mac", device.getMac());

		if(device.getStatus()!=null && -1 < device.getStatus())
			filter.put("status", device.getStatus());

		if(device.getType()!=null && -1 < device.getType())
			filter.put("type", device.getType());
		
		deviceService.getEquipmentsList(response,filter);
	}
	
	@RequestMapping(value = "/bootDevice", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData bootDevice(Device device) throws Exception{
		LOGGER.info("bootDevice Start");
		Device d = deviceService.getDeviceById(device.getId());
		if(d == null){
			return AsyncResponseData.getSuccess().asParamError("查询不到设备信息");
		}

		if(1 == device.getControlled()){//自动
			device.setOperationType(1);//自动
			GeneralProtocol.sendShieldCommand(d, 1 + "");
		} else if(2 == device.getControlled()){//手动
			if(device.getOperationType1G()==null && device.getOperationTypePhone()==null){
				device.setOperationType(5);//全不选是5
				GeneralProtocol.sendShieldCommand(d, 5 + "");
			}
			if(device.getOperationType1G()==null && device.getOperationTypePhone()!=null){
				device.setOperationType(4);//手机模块是4 
                GeneralProtocol.sendShieldCommand(d, 4 + "");
			}
			if(device.getOperationType1G()!=null && device.getOperationTypePhone()==null){
				device.setOperationType(3);//1G模块是3
                GeneralProtocol.sendShieldCommand(d, 3 + "");
			}
			if(device.getOperationType1G()!=null && device.getOperationTypePhone()!=null){
				device.setOperationType(2);//全选是2
                GeneralProtocol.sendShieldCommand(d, 2 + "");
			}
			
		}else {
			device.setControlled(0);//未知
			device.setOperationType(0);//未知
            GeneralProtocol.sendShieldCommand(d,  "");
		}
		deviceService.updateDevice(device);
		
		LOGGER.info("bootDevice End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 根据checkbox批量开启/关闭设备
	 * 
	 * @param  ids , String operationType(开启/关闭)
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/openOrCloseSelectedDevices", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData openOrCloseSelectedDevices(String ids,String operationType) throws Exception{
	    if(StringUtils.isBlank(ids) || StringUtils.isBlank(operationType)){
            return AsyncResponseData.getLogicError("参数错误！");
        }
		List<String> list = new ArrayList<String>();
		if(ids!=null){
			String[] s = ids.split(",");
			if(s.length == 0){
				return AsyncResponseData.getLogicError("请选择要操作的设备！");
			}else{
				list = Arrays.asList(s);
			}
		}

		LOGGER.info("批量开启设备开始");
//		System.out.println(operationType);
//		List<String> macs = new ArrayList<String>();
//		Device device = new Device();
//		for(int i=0; i<list.size(); i++) {
//			device = deviceService.getDeviceById(list.get(i));
//			macs.add(device.getMac());
//		}
        if(list != null && list.size() > 0){
            Map<String,Object> params = new HashMap<String,Object>();
            params.put("list", list);
            params.put("operationType", operationType);
            deviceService.openOrCloseSelectedDevices(params);
            //发送协议到阻断
            List<Device> devices = deviceService.getDeviceListByIds(list);
            sendProtocol(devices, operationType);
        }
		
		LOGGER.info("批量开启设备结束");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 一键批量开启/关闭所有设备
	 * @param 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/openOrCloseAllDevices", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData openOrCloseAllDevices(String operationType) throws Exception{

		LOGGER.info("批量开启设备开始");
		if(StringUtils.isNotBlank(operationType)){
			deviceService.openOrCloseAllDevices(operationType);
			//发送协议,获取所有阻断设备
			Map<String,Object> filter = new HashMap<>();
			filter.put("type","2");
			List<Device> devices = deviceService.queryDevicesFilter(filter);
			sendProtocol(devices, operationType);
		}
		
		LOGGER.info("批量开启设备结束");
		return AsyncResponseData.getSuccess();
	}

	private void sendProtocol(List<Device> devices, String operationType){
	    if(devices != null){
            for(Device device : devices){
				GeneralProtocol.sendShieldCommand(device, operationType);
            }
        }
    }
	
}
