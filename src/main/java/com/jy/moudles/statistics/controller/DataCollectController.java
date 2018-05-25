package com.jy.moudles.statistics.controller;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.device.service.DeviceService;
import com.jy.moudles.reductionInfo.service.ReductionInfoService;
import com.jy.moudles.statistics.entity.DeviceCollectVO;
import com.jy.moudles.statistics.entity.ReductionCollectVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wb on 2017/11/1.
 */
@Controller
@RequestMapping("dataCollection")
public class DataCollectController {

    private static final Logger LOGGER = LoggerFactory.getLogger(DataCollectController.class);

    @Autowired
    private ReductionInfoService reductioninfoService;
    
    @Autowired
    private DeviceService deviceService;

    @RequestMapping(value = "/getReductionInfoCollect", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData getReductionInfoCollect(HttpServletRequest request){
        LOGGER.info("查询还原文件统计");
        String examPlanId = request.getParameter("examPlanId");
        String examNumberId = request.getParameter("examNumberId");
        Map<String,Object> filter = new HashMap<>();
        filter.put("examPlanId", examPlanId);
        filter.put("examNumberId", examNumberId);
        String returnStr = null;
        List<String> returnStrList = new ArrayList<>();
        List<ReductionCollectVO> reductionCollectVOs = reductioninfoService.queryReductionInfoCount(filter);
        if(reductionCollectVOs != null && reductionCollectVOs.size() > 0){
            Map<String,List<ReductionCollectVO>> map = new HashMap<>();
            for (ReductionCollectVO r:reductionCollectVOs) {
                if (map.keySet().contains(r.getOrgName())){
                    map.get(r.getOrgName()).add(r);
                }else{
                    List<ReductionCollectVO> list = new ArrayList<>();
                    list.add(r);
                    map.put(r.getOrgName(),list);
                }
            }

            for (String orgName: map.keySet()) {
                List<ReductionCollectVO> list = map.get(orgName);
                int cheatCount = 0;
                int wavCount = 0;
                int txtCount = 0;
                for(ReductionCollectVO r : list){
                    if(1 == r.getRecognitionResult()){
                        cheatCount += r.getCount();
                    }
                    if("wav".equals(r.getSuffix())){
                        wavCount += r.getCount();
                    }
                    if("txt".equals(r.getSuffix())){
                        txtCount += r.getCount();
                    }
                }
                returnStr = orgName + "," + cheatCount + "," + wavCount + "," + txtCount;
                returnStrList.add(returnStr);
            }

        }
        return AsyncResponseData.getSuccess(returnStrList);
    }

    @RequestMapping(value = "/getDeviceCollect", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData getDeviceCollect(HttpServletRequest request){
        LOGGER.info("查询设备统计");

        String returnStr = null;
        List<String> returnStrList = new ArrayList<>();
        List<DeviceCollectVO> deviceCollectVOs = deviceService.queryDeviceCount();
        if(deviceCollectVOs != null && deviceCollectVOs.size() > 0){
        	Map<String,List<DeviceCollectVO>> map = new HashMap<>();
            for (DeviceCollectVO d:deviceCollectVOs) {
                if (map.keySet().contains(d.getOrgName())){
                    map.get(d.getOrgName()).add(d);
                }else{
                    List<DeviceCollectVO> list = new ArrayList<>();
                    list.add(d);
                    map.put(d.getOrgName(),list);
                }
            }
            
            for (String orgName: map.keySet()) {
            	List<DeviceCollectVO> list = map.get(orgName);
            	int detectionOnline = 0;
            	int detectionTotal = 0;
            	int blockOnine = 0;
            	int blockTotal = 0;
            	for(DeviceCollectVO d:list){
            		if(d.getType() == 1){
            			detectionTotal += d.getCount();
            			if(d.getStatus() == 1){
            				detectionOnline += d.getCount();
            			}
            		}
            		if(d.getType() == 2){
            			blockTotal += d.getCount();
            			if(d.getStatus() == 1){
            				blockOnine += d.getCount();
            			}
            		}
            	}
            	returnStr = orgName + "," + detectionTotal  + "," + detectionOnline + "," + blockTotal + "," + blockOnine;
            	returnStrList.add(returnStr);
            }
        }
        
        return AsyncResponseData.getSuccess(returnStrList);
    }
}
