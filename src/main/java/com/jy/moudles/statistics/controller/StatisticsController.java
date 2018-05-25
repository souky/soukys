package com.jy.moudles.statistics.controller;

import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.device.entity.Device;
import com.jy.moudles.device.service.DeviceService;
import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.service.ExamService;
import com.jy.moudles.reductionInfo.entity.ReductionInfo;
import com.jy.moudles.reductionInfo.service.ReductionInfoService;
import com.jy.moudles.statistics.entity.CheatFrequencyPoint;
import com.jy.moudles.statistics.entity.StatisticsAnalysis;
import com.jy.moudles.statistics.map.CityMap;

/**
 * @author xipeng
 * 2017-06-22
 */
@Controller
@RequestMapping(value="/statistics")
public class StatisticsController {

	@Autowired
	private DeviceService deviceService;
	@Autowired
	private ReductionInfoService reductionInfoService;
	@Autowired
	private ExamService examService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StatisticsController.class);
	/**
	 * @return 获取可疑信号和作弊信号的数量，各种设备的数量
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryNum")
	@ResponseBody
	public AsyncResponseData.ResultData queryNum(String examNum){

		StatisticsAnalysis sa= new StatisticsAnalysis();
		
		//设备数量统计
		List<Device> devices = null;
		
		int detectiveNum = 0;//侦测设备数量
		int shieldNum = 0;//屏蔽设备数量
		
		int onlineNumForDetective=0;//侦测设备在线数量
		int normalOnlineDetective=0;//工作状态为正常的在线侦测设备
		int innormalOnlineDetective=0;//工作状态为不正常的在线侦测设备
		
		int offlineNumForDetective=0;//侦测设备离线数量
		int normalOfflineDetective=0;//工作状态为正常的离线侦测设备
		int innormalOfflineDetective=0;	//工作状态为不正常的离线侦测设备
		
		int onlineNumForShield=0;//屏蔽设备在线数量
		int normalOnlineShield=0;//工作状态为正常的在线屏蔽设备
		int innormalOnlineShield=0;//工作状态为不正常的在线屏蔽设备
		
		int offlineNumForShield=0;//屏蔽设离线数量
		int normalOfflineShield=0;//工作状态为正常的离线屏蔽设备
		int innormalOfflineShield=0;//工作状态为不正常的离线屏蔽设备
		
		devices = deviceService.queryDevicesFilter(null);
		if(devices!=null && devices.size()>0){
			for(Device device:devices){
				if(device.getType()==1){//侦测
					detectiveNum++;
					if(device.getStatus()==1){//在线
						onlineNumForDetective++;
						//正常不正常设备？待确定
						
					}else if(device.getStatus()==2){//离线
						offlineNumForDetective++;
						
						
					}
				}
				else if(device.getType()==2){//阻断
					shieldNum++;
					if(device.getStatus()==1){//在线
						onlineNumForShield++;
						
						
					}else if(device.getStatus()==2){//离线
						offlineNumForShield++;
						
						
					}
				}
					
			}
			
			sa.setDetectiveNum(detectiveNum);
			sa.setShieldNum(shieldNum);
			
			sa.setOnlineNumForDetective(onlineNumForDetective);
			sa.setNormalOnlineDetective(normalOnlineDetective);
			sa.setInnormalOnlineDetective(innormalOnlineDetective);
			
			sa.setOfflineNumForDetective(offlineNumForDetective);
			sa.setNormalOfflineDetective(normalOfflineDetective);
			sa.setInnormalOfflineDetective(innormalOfflineDetective);
			
			sa.setOnlineNumForShield(onlineNumForShield);
			sa.setNormalOnlineShield(normalOnlineShield);
			sa.setInnormalOnlineShield(innormalOnlineShield);
			
			sa.setOfflineNumForShield(offlineNumForShield);
			sa.setNormalOfflineShield(normalOfflineShield);
			sa.setInnormalOfflineShield(innormalOfflineShield);
		}
		
		
		//信号还原统计
		List<ReductionInfo> reductionInfos = null;
		Map<String, Object> reductionInfoFilter = new HashMap<String, Object>();
		
		int suspiciousSignalNum=0;
		int cheatSignalNum=0;
		
		if(!"null".equals(examNum)){
			reductionInfoFilter.put("examPlanId", examNum);
		}
		reductionInfos = reductionInfoService.queryReductionInfosFilter(reductionInfoFilter);
		List<CheatFrequencyPoint> cfpList = new ArrayList<CheatFrequencyPoint>();
		
		CheatFrequencyPoint cfp = null;
		if(reductionInfos!=null && reductionInfos.size()>0){
			for(ReductionInfo info: reductionInfos){
				boolean has= false;
				if(info.getRecognitionResult()==1){//确认作弊
					cheatSignalNum++;
					
					cfp = new CheatFrequencyPoint();
					cfp.setFrequencyPoint(info.getFrequency());
					
					
					if(cfpList.size()==0){
						cfp.setNumber(1);
						cfpList.add(cfp);
					}else{
						for(CheatFrequencyPoint p: cfpList){
							if(p.getFrequencyPoint().equals(info.getFrequency())){
								p.setNumber(p.getNumber()+1);
								has = true;
								break;
							}
						}
						
						if(!has){
							cfp.setFrequencyPoint(info.getFrequency());
							cfp.setNumber(1);
							cfpList.add(cfp);
						}
					}
					
				}else if(info.getRecognitionResult()==0)//未知信号
					suspiciousSignalNum++;
						
			}
			sa.setCheatSignalNum(cheatSignalNum);
			sa.setSuspiciousSignalNum(suspiciousSignalNum);
			sa.setPointList(cfpList);
			
		}
		
		
		return AsyncResponseData.getSuccess(sa);
	}
	
	
	/**
	 * 获取examList
	 * 
	 */
	@RequestMapping(value = "/queryExamList", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryExamList(HttpServletRequest request) throws Exception{
    	LOGGER.info("获取考试名单开始");
		
		List<Exam> examList = examService.queryExamFilter(null);
		
		LOGGER.info("获取考试名单结束");
		return AsyncResponseData.getSuccess(examList);
	}
	
	@RequestMapping(value="/mainStatistics")
	public ModelAndView mainStatistics() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("statistics/mainStatistics");
		Map<String,String> cityMap = CityMap.mapCity;
		String maps = JSONArray.toJSONString(cityMap);
		mv.addObject("cityMap", maps);
		return mv;
	}
	
}
