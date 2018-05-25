//package com.jy.moudles.statistics.controller;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.alibaba.fastjson.JSONArray;
//import com.github.pagehelper.PageHelper;
//import com.github.pagehelper.PageInfo;
//import com.jy.common.jsonadpter.AsyncResponseData;
//import com.jy.common.utils.IpUtils;
//import com.jy.common.utils.UUIDUtil;
//import com.jy.common.utils.auth.AuthBuilder;
//import com.jy.common.utils.auth.AuthUser;
//import com.jy.moudles.blackwhitelist.entity.BlackWhiteList;
//import com.jy.moudles.blackwhitelist.service.BlackWhiteListService;
//import com.jy.moudles.equipment.contants.EquipmentContants;
//import com.jy.moudles.equipment.entity.Equipment;
//import com.jy.moudles.equipment.service.EquipmentService;
//import com.jy.moudles.exam.entity.CheateSignalReduct;
//import com.jy.moudles.exam.service.CheateSignalReductService;
//import com.jy.moudles.organization.entity.Organization;
//import com.jy.moudles.organization.service.OrganizationService;
//import com.jy.moudles.signal.service.SuspiciousSignalService;
//import com.jy.moudles.statistics.entity.CheatFrequencyPoint;
//import com.jy.moudles.statistics.entity.Region;
//import com.jy.moudles.statistics.map.CityMap;
//import com.jy.moudles.statistics.service.RegionService;
//import com.jy.moudles.user.service.UserService;
//
//@Controller
//@RequestMapping(value="data")
//public class DataController {
//
//	private static final Logger LOGGER = LoggerFactory.getLogger(DataController.class);
//	
//	@Autowired
//	private UserService userService;
//	
//	@Autowired
//	private RegionService regionService;
//	
//	@Autowired
//	private EquipmentService equipmentService;
//	
//	@Autowired
//	private OrganizationService organizationService;
//	
//	@Autowired
//	private SuspiciousSignalService suspicioussignalService;
//	
//	@Autowired
//	private CheateSignalReductService cheatesignalreductService;
//	
//	@Autowired
//    private BlackWhiteListService blackwhitelistService;
//	
//	@RequestMapping(value="/fuck", method = RequestMethod.GET)
//	public ModelAndView testCitySouky(){
//		String[] sheng = {"8","11"};
//		String chinaId = UUIDUtil.get32UUID();
//		setOrg(chinaId,"中国","中国","");
//		for(String s : sheng){
//			Region region = regionService.getRegionById(s);
//			Organization org = new Organization();
//			String shengId = UUIDUtil.get32UUID();
//			setOrg(shengId,region.getName(),region.getCode(),chinaId);
//			List<Region> list1 = regionService.getRegionByPid(region.getId());
//			for(Region e : list1){
//				String shiId = UUIDUtil.get32UUID();
//				setOrg(shiId,e.getName(),e.getCode(),shengId);
//				List<Region> list2 = regionService.getRegionByPid(e.getId());
//				for(Region ee : list2){
//					String quId = UUIDUtil.get32UUID();
//					setOrg(quId,ee.getName(),ee.getCode(),shiId);
//				}
//			}
//		}
//		ModelAndView mv = new ModelAndView("fuck");
//		return mv;
//	}
//	
//	/*测试用方法
//	 * */
//	private void setOrg(String id,String name,String code,String pid){
//		Organization org = new Organization();
//		org.setId(id);
//		org.setName(name);
//		org.setRegionCode(code);
//		org.setParentId(pid);
//		organizationService.insertOrganization(org);
//	}
//	
//	
//	@RequestMapping(value="/mainStatistics", method = RequestMethod.GET)
//	public ModelAndView mainStatistics(HttpServletRequest request) {
//		ModelAndView mv = new ModelAndView();
//		mv.setViewName("statistics/mainStatistics");
//		Map<String,String> cityMap = CityMap.mapCity;
//		String maps = JSONArray.toJSONString(cityMap);
//		mv.addObject("cityMap", maps);
//		
//		AuthUser authUser = AuthBuilder.getUser(request, "JY_ANTI_CHEAT");
//		String currentUserOrgId = userService.getUserById(authUser.getId()).getOrgId();
//		//当前用户所在机构
//		Organization currentOrg = organizationService.getOrganizationById(currentUserOrgId);
//		//当前用户所在机构的区域层级 ：0-中国，1-省，2-市，3-区县
//		String currentUserLevel = regionService.getRegionByCode(currentOrg.getRegionCode()).getLevel();
//		
//		if("1".equals(currentUserLevel)){
//			mv.addObject("currentProvince", regionService.getRegionByCode(currentOrg.getRegionCode()).getName());
//		}else if("2".equals(currentUserLevel)){
//			mv.addObject("currentCity", regionService.getRegionByCode(currentOrg.getRegionCode()).getName());
//			Organization prvOrg = organizationService.getOrganizationById(currentOrg.getParentId());
//			mv.addObject("currentProvince", regionService.getRegionByCode(prvOrg.getRegionCode()).getName());
//		}else if("3".equals(currentUserLevel)){
//			mv.addObject("currentArea", regionService.getRegionByCode(currentOrg.getRegionCode()).getName());
//			Organization cityOrg = organizationService.getOrganizationById(currentOrg.getParentId());
//			mv.addObject("currentCity", regionService.getRegionByCode(cityOrg.getRegionCode()).getName());
//			Organization prvOrg = organizationService.getOrganizationById(cityOrg.getParentId());
//			mv.addObject("currentProvince", regionService.getRegionByCode(prvOrg.getRegionCode()).getName());
//		}
//		
//		mv.addObject("currentCountry", "中国");
//		
//		return mv;
//	}
//	
//	@RequestMapping(value = "/countNum", method = RequestMethod.POST)
//	@ResponseBody
//	public AsyncResponseData.ResultData countNum(String level,String name,HttpServletRequest request){
//    	LOGGER.info("获取设备参数开始");
//		String regionCode = regionService.getCodeByName(name);
//		if("".equals(regionCode))
//			return AsyncResponseData.getDenied("错误的参数！");
//		
//		List<Organization> areaOrgs = null;
//		List<Organization> cityOrgs = null;
//		List<Organization> provinceOrgs = null;
//		List<Organization> countryOrgs = null;
//		List<Equipment> es =null;
//	
//		Map<String ,Object> result = new HashMap<String, Object>();
//		
//		if(Constant.LEVEL_AREA.equals(level)){//区
//			areaOrgs = organizationService.getSubOrgByLocationCode(regionCode);
//			
//			es = equipmentService.getEquipmentsByOrgIds(getIdsFromList(areaOrgs));
//		}else if(Constant.LEVEL_CITY.equals(level)){//市
//			cityOrgs = organizationService.getSubOrgByLocationCode(regionCode);
//			areaOrgs = new ArrayList<Organization>();
//			for(Organization co: cityOrgs){
//				areaOrgs.addAll(organizationService.getSubOrgByLocationCode(co.getRegionCode()));
//			}
//			es = equipmentService.getEquipmentsByOrgIds(getIdsFromList(areaOrgs));
//		}else if(Constant.LEVEL_PROVINCE.equals(level)){//省
//			provinceOrgs = organizationService.getSubOrgByLocationCode(regionCode);
//			cityOrgs = new ArrayList<Organization>();
//			areaOrgs = new ArrayList<Organization>();
//			for(Organization po: provinceOrgs){
//				cityOrgs.addAll(organizationService.getSubOrgByLocationCode(po.getRegionCode()));
//			}
//			
//			for(Organization co: cityOrgs){
//				areaOrgs.addAll(organizationService.getSubOrgByLocationCode(co.getRegionCode()));
//			}
//			es = equipmentService.getEquipmentsByOrgIds(getIdsFromList(areaOrgs));
//		}else if(Constant.LEVEL_COUNTRY.equals(level)){//全国
//			countryOrgs = organizationService.getSubOrgByLocationCode(regionCode);
//			provinceOrgs = new ArrayList<Organization>();
//			cityOrgs = new ArrayList<Organization>();
//			areaOrgs = new ArrayList<Organization>();
//			for(Organization co: countryOrgs){
//				provinceOrgs.addAll(organizationService.getSubOrgByLocationCode(co.getRegionCode()));
//			}
//			for(Organization po: provinceOrgs){
//				cityOrgs.addAll(organizationService.getSubOrgByLocationCode(po.getRegionCode()));
//			}
//			
//			for(Organization co: cityOrgs){
//				areaOrgs.addAll(organizationService.getSubOrgByLocationCode(co.getRegionCode()));
//			}
//			es = equipmentService.getEquipmentsByOrgIds(getIdsFromList(areaOrgs));
//		}
//		
//		//第一步设备总数和设备运行占比
//		int equipmentNum = 0;//设备总数
//		int detectiveNum = 0;//侦测设备数量
//		int shieldNum = 0;//屏蔽设备数量
//		
//		int onlineNumForDetective=0;
////		工作状态为正常的在线侦测设备
//		int normalOnlineDetective=0;
////		工作状态为不正常的在线侦测设备
//		int innormalOnlineDetective=0;
//		
////		侦测设备离线数量
//		int offlineNumForDetective=0;
////		工作状态为正常的离线侦测设备
//		int normalOfflineDetective=0;
////		工作状态为不正常的离线侦测设备
//		int innormalOfflineDetective=0;	
//		
////		屏蔽设备在线数量
//		int onlineNumForShield=0;
////		工作状态为正常的在线屏蔽设备
//		int normalOnlineShield=0;	
////		工作状态为不正常的在线屏蔽设备
//		int innormalOnlineShield=0;
//		
////		屏蔽设离线数量
//		int offlineNumForShield=0;
////		工作状态为正常的离线屏蔽设备
//		int normalOfflineShield=0;	
////		工作状态为不正常的离线屏蔽设备
//		int innormalOfflineShield=0;
//
//		if(es!=null){
//			equipmentNum = es.size();
//			for(Equipment e:es){
//				if(EquipmentContants.DETACTIVE_EQUIPMENT.equals(e.getType())){//侦测设备
//					detectiveNum++;
//					if(EquipmentContants.ONLINE.equals(e.getStatusAlias())){//侦测在线
//						onlineNumForDetective++;
//						if(e.getWorkStatus()>=1 && e.getWorkStatus()<4)
////							对于侦测设备1/2/3表示异常
//							innormalOnlineDetective++;//侦测下线异常
//						else 
//							normalOnlineDetective++;//侦测下线正常
//					}
//					else if(EquipmentContants.OFFLINE.equals(e.getStatusAlias())){//侦测离线
//						offlineNumForDetective++;
//						if(e.getWorkStatus()>=1 && e.getWorkStatus()<4)
//							innormalOfflineDetective++;//侦测离线异常
//						else
//							normalOfflineDetective++;//侦测离线正常
//					}
//				}else if(EquipmentContants.SHIELD_EQUIPMENT.equals(e.getType())){//屏蔽设备
//					shieldNum++;
//					if(EquipmentContants.ONLINE.equals(e.getStatusAlias())){//屏蔽设备在线
//						onlineNumForShield++;
//						if(e.getWorkStatus()>=0 && e.getWorkStatus()<4)
////							对于屏蔽设备0/1/2/3表示正常
//							normalOnlineShield++;//屏蔽设备在线正常
//						else 
//							innormalOnlineShield++;//屏蔽设备在线异常
//					}
//					else if(EquipmentContants.OFFLINE.equals(e.getStatusAlias())){//屏蔽设备离线
//						offlineNumForShield++;
//						if(e.getWorkStatus()>=0 && e.getWorkStatus()<4)
//							normalOfflineShield++;//屏蔽设备离线正常
//						else 
//							innormalOfflineShield++;//屏蔽设备离线异常
//					}
//				}
//				
//			}
//		}
//		
//		result.put("equipmentNum", equipmentNum);
//		result.put("detectiveNum", detectiveNum);
//		
//		result.put("onlineNumForDetective",onlineNumForDetective );
//		result.put("normalOnlineDetective", normalOnlineDetective);
//		result.put("innormalOnlineDetective", innormalOnlineDetective);
//		
//		result.put("offlineNumForDetective", offlineNumForDetective);
//		result.put("normalOfflineDetective", normalOfflineDetective);
//		result.put("innormalOfflineDetective", innormalOfflineDetective);
//		
//		result.put("shieldNum", shieldNum);
//		result.put("onlineNumForShield", onlineNumForShield);
//		result.put("normalOnlineShield", normalOnlineShield);
//		result.put("innormalOnlineShield",innormalOnlineShield );
//		
//		result.put("offlineNumForShield", offlineNumForShield);
//		result.put("normalOfflineShield", normalOfflineShield);
//		result.put("innormalOfflineShield",innormalOfflineShield );
//		
//		//第二步高考作弊信号统计
//		//获取可疑信号数量
//		int suspiciousSignalNum = 0;
//		suspiciousSignalNum = suspicioussignalService.getSuspiciousSignalByOrgIds(getIdsFromList(areaOrgs)).size();
//		result.put("suspiciousSignalNum",suspiciousSignalNum );
//		
//		//获取作弊信号数量
//		int cheatSignalNum=0;
//		List<CheateSignalReduct> cheatList=null;
//		cheatList = cheatesignalreductService.getCheateSignalReductByOrgId(getIdsFromList(areaOrgs));
//		Iterator<CheateSignalReduct> it = cheatList.iterator();
//		while (it.hasNext()) {
//			CheateSignalReduct i = it.next();
//            if(!"确认作弊".equals(i.getReductState()))//删除掉没有被确认作弊的型号
//            	it.remove();
//        }
//		cheatSignalNum = cheatList.size();//作弊信号数量
//		result.put("cheatSignalNum",cheatSignalNum );
//		
//		//第三部作弊考点占比
//		List<String> cheatExamPointList = new ArrayList<String>();//作弊考点
//		for(CheateSignalReduct c: cheatList){
//			boolean hasCheatOrg= false;
//			if(cheatExamPointList.size()==0){
//				cheatExamPointList.add(c.getOrgId());
//			}else{//去掉重复的考点
//				for(int i=0;i<cheatExamPointList.size();i++){
//					if(cheatExamPointList.get(i).equals(c.getOrgId())){
//						hasCheatOrg=true;
//						break;
//					}
//				}
//				
//				if(!hasCheatOrg)
//						cheatExamPointList.add(c.getOrgId());
//			}
//		}
//		result.put("cheatExamPointNum",cheatExamPointList.size());
//		result.put("examPointNum",areaOrgs.size());//一个学校就是一个考点
//		
//		//第4部作弊频点散点图
//		List<CheatFrequencyPoint> pointList = new ArrayList<CheatFrequencyPoint>();
//		for(CheateSignalReduct c: cheatList){
//			boolean has= false;
//			if(pointList.size()==0){
//				CheatFrequencyPoint point = new CheatFrequencyPoint();
//				point.setFrequencyPoint(c.getFrequencyPoint());
//				point.setNumber(1);
//				pointList.add(point);
//			}else{
//				for(CheatFrequencyPoint p: pointList){
//					if(p.getFrequencyPoint().compareTo(c.getFrequencyPoint())==0){
//						p.setNumber(p.getNumber()+1);
//						has = true;
//						break;
//					}
//				}
//				
//				if(!has){
//					CheatFrequencyPoint point = new CheatFrequencyPoint();
//					point.setFrequencyPoint(c.getFrequencyPoint());
//					point.setNumber(1);
//					pointList.add(point);
//				}
//			}
//			
//		}
//		result.put("pointList",pointList );
//		result.put("cheatList",cheatList );
//		
//		//第五步黑白名单配置
//		PageHelper.startPage(1, 90);
//        PageInfo<BlackWhiteList> blackwhitelists = new PageInfo<BlackWhiteList>(blackwhitelistService.queryBlackWhiteByKafka(null));
//		result.put("blackwhitelists",blackwhitelists.getList() );
//		
//		//第六步其他数据
//		result.put("examRoomNum",detectiveNum );//一个考场有一台侦测设备
//		result.put("cheatExamPointNum",cheatExamPointList.size() );//作弊考点数量
//		
//		LOGGER.info("获取设备参数结束");
//		return AsyncResponseData.getSuccess(result);
//	}
//	
//	public List<String> getIdsFromList(List<Organization> orgs){
//		List<String> ids = new ArrayList<String>();
//		for(Organization o: orgs){
//			ids.add(o.getId());
//		}
//		
//		return ids;
//	}
//	
//	
//		
//}
