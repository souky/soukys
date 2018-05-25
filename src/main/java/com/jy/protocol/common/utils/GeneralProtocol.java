package com.jy.protocol.common.utils;

import com.jy.moudles.blackwhitelist.entity.BlackWhiteList;
import com.jy.moudles.device.entity.Device;
import com.jy.moudles.exam.entity.Exam;
import com.jy.protocol.common.constant.DeviceVender;
import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.jf.utils.IssuedSendUtils;
import org.apache.commons.lang3.StringUtils;

import java.util.List;

/**
 * Create by wb
 * TIME: 2018/1/29 10:24
 * 发送协议通用接口,根据设备中的厂家选择调用对应的协议
 **/
public class GeneralProtocol {

    /**
     * 注册侦测
     */
    public static void register(){
        Object obj = ParamStatic.issuedStaticMap.get(IssuedSendUtils.DETECTION_DEVICE);
        Device device = obj == null ? null : (Device)obj;
        //status=1,设备在线
        if(device != null && StringUtils.isNotBlank(device.getIp()) && device.getStatus() == 1){
            if(DeviceVender.JF.equalsIgnoreCase(device.getVender())){
                IssuedSendUtils.registerPlatform(1, device.getIp(), IssuedSendUtils.TCP_PORT);
            }
            if(DeviceVender.HS.equalsIgnoreCase(device.getVender())){

            }
        }
    }

    /**
     * 发送考试
     */
    public static void sendExam(List<Exam> examList){
        Object obj = ParamStatic.issuedStaticMap.get(IssuedSendUtils.DETECTION_DEVICE);
        Device device = obj == null ? null : (Device)obj;
        //status=1,设备在线
        if(device != null && StringUtils.isNotBlank(device.getIp()) && device.getStatus() == 1){
            if(DeviceVender.JF.equalsIgnoreCase(device.getVender())){
                IssuedSendUtils.sendExam(examList, device.getIp(), IssuedSendUtils.DETECTION_UDP_PORT);
            }
            if(DeviceVender.HS.equalsIgnoreCase(device.getVender())){

            }
        }
    }

    /**
     * 发送黑白名单
     */
    public static void sendBlackWhite(List<BlackWhiteList> listBlackWhite){
        Object obj = ParamStatic.issuedStaticMap.get(IssuedSendUtils.DETECTION_DEVICE);
        Device device = obj == null ? null : (Device)obj;
        //status=1,设备在线
        if(device != null && StringUtils.isNotBlank(device.getIp()) && device.getStatus() == 1){
            if(DeviceVender.JF.equalsIgnoreCase(device.getVender())){
                IssuedSendUtils.sendBlackWhite(listBlackWhite, device.getIp(), IssuedSendUtils.TCP_PORT);
            }
            if(DeviceVender.HS.equalsIgnoreCase(device.getVender())){

            }
        }
    }

    /**
     * 发送屏蔽
     * @param device
     * @param operationType 控制模块
     */
    public static void sendShieldCommand(Device device, String operationType){
        ////ip不为空,且状态在线
        if(device != null && StringUtils.isNotBlank(device.getIp()) && device.getStatus() == 1){
            if(DeviceVender.JF.equalsIgnoreCase(device.getVender())){
                //0：未知、1：自动、2：手动-全部、3：手动---1G、4：手动---手机、5：手动---未选
                if("1".equals(operationType) || "2".equals(operationType)){
                    IssuedSendUtils.shieldControllerBase(1, device.getIp(), IssuedSendUtils.SHIELD_UDP_PORT);
                    IssuedSendUtils.shieldControllerPhone(1, device.getIp(), IssuedSendUtils.SHIELD_UDP_PORT);
                }else if("3".equals(operationType)){
                    IssuedSendUtils.shieldControllerBase(1, device.getIp(), IssuedSendUtils.SHIELD_UDP_PORT);
                    IssuedSendUtils.shieldControllerPhone(0, device.getIp(), IssuedSendUtils.SHIELD_UDP_PORT);
                }else if("4".equals(operationType)){
                    IssuedSendUtils.shieldControllerBase(0, device.getIp(), IssuedSendUtils.SHIELD_UDP_PORT);
                    IssuedSendUtils.shieldControllerPhone(1, device.getIp(), IssuedSendUtils.SHIELD_UDP_PORT);
                }else{
                    IssuedSendUtils.shieldControllerBase(0, device.getIp(), IssuedSendUtils.SHIELD_UDP_PORT);
                    IssuedSendUtils.shieldControllerPhone(0, device.getIp(), IssuedSendUtils.SHIELD_UDP_PORT);
                }
            }
            if(DeviceVender.JRY.equalsIgnoreCase(device.getVender())){
                //
            }
        }
    }

}
