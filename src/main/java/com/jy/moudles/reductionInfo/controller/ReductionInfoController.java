package com.jy.moudles.reductionInfo.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jcraft.jsch.ChannelSftp;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.kafka.producer.JyKafkaProducer;
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.LogUtil;
import com.jy.common.utils.SftpUtils;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.kafka.entity.KafkaSync;
import com.jy.moudles.kafka.service.KafkaSyncService;
import com.jy.moudles.organization.entity.Organization;
import com.jy.moudles.organization.service.OrganizationService;
import com.jy.moudles.reductionInfo.constant.ReductionInfoConstant;
import com.jy.moudles.reductionInfo.entity.ReductionInfo;
import com.jy.moudles.reductionInfo.service.ReductionInfoService;
import com.jy.moudles.systemLog.constants.LogOperationType;
import com.jy.moudles.user.entity.User;

/** 
 * wb
 * 时间2017-10-17
 */
@Controller
@RequestMapping(value="/reductioninfo")
public class ReductionInfoController {
	
	@Autowired
	private ReductionInfoService reductioninfoService;
	
	@Autowired
	private KafkaSyncService kafkaSyncService;
	
	@Autowired
	private OrganizationService organizationService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ReductionInfoController.class);
	
	
	/**
	 * 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateReductionInfo", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateReductionInfo(HttpServletRequest request) throws Exception{
		LOGGER.info("修改ReductionInfo Start");
		
		String id = request.getParameter("id");
		String recognitionResult = request.getParameter("recognitionResult");
		ReductionInfo reductioninfo = reductioninfoService.getReductionInfoById(id);
		if(reductioninfo == null){
			return AsyncResponseData.getSuccess().asParamError("查询不到该信号信息");
		}
		if((ReductionInfoConstant.CHEAT + "").equals(recognitionResult)){
			reductioninfo.setRecognitionResult(ReductionInfoConstant.CHEAT);
		}else if((ReductionInfoConstant.UNCHEAT + "").equals(recognitionResult)){
			reductioninfo.setRecognitionResult(ReductionInfoConstant.UNCHEAT);
		}
		
		reductioninfoService.updateReductionInfo(reductioninfo);
		LogUtil.addLog("修改还原信号", LogOperationType.EDIT, request);
		LOGGER.info("修改ReductionInfo End");
		return AsyncResponseData.getSuccess();
	}
	
	
	/**
	 * 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryReductionInfos", method = RequestMethod.POST)
	public ModelAndView queryReductionInfos(HttpServletRequest request) throws Exception{
		LOGGER.info("查询ReductionInfo Start");
		ModelAndView mv = new ModelAndView("exam/post/reductionInfoPost");
		//获取前台数据
		String examPlanId = request.getParameter("examPlanId");
		String examNumberId = request.getParameter("examNumberId");
		String suffix = request.getParameter("suffix");
		String signalType = request.getParameter("signalType");
		String recognitionResult = request.getParameter("recognitionResult");
		BigDecimal frequencyPointBegin = null;
		BigDecimal frequencyPointEnd = null;
		
		//转化频点
		if(!StringUtils.isBlank(request.getParameter("frequencyPointBegin"))){
			try{
				double d = Double.parseDouble(request.getParameter("frequencyPointBegin"));
				d=d*1000;
				frequencyPointBegin = BigDecimal.valueOf(d);
			}catch(NumberFormatException e){
				return mv;
			}
			
		}
		if(!StringUtils.isBlank(request.getParameter("frequencyPointEnd"))){
			try{
				double t = Double.parseDouble(request.getParameter("frequencyPointEnd"));
				t=t*1000;
				frequencyPointEnd = BigDecimal.valueOf(t);
			}catch(NumberFormatException e){
				return mv;
			}
		}
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		filter.put("examPlanId", examPlanId);
		filter.put("examNumberId", examNumberId);
		filter.put("suffix", suffix);
		filter.put("signalType", signalType);
		filter.put("recognitionResult", recognitionResult);
		filter.put("frequencyPointBegin", frequencyPointBegin);
		filter.put("frequencyPointEnd", frequencyPointEnd);
		
		//分页处理
		int pageNum = 1;
		int pageSize = 10;
		String pageNumString = request.getParameter("pageNum");
		String pageSizeString = request.getParameter("pageSize");
		if(!StringUtils.isBlank(pageNumString)){
			pageNum = Integer.parseInt(pageNumString);
		}
		
		if(!StringUtils.isBlank(pageSizeString)){
			pageSize = Integer.parseInt(pageSizeString);
		}
		
		PageHelper.startPage(pageNum, pageSize);
		List<ReductionInfo> reductioninfos = reductioninfoService.queryReductionInfosFilter(filter);
		PageInfo<ReductionInfo> pageInfo = new PageInfo<ReductionInfo>(reductioninfos);
		mv.addObject("pageNow", pageInfo.getPageNum());
		mv.addObject("pageTotal", pageInfo.getPages());
		mv.addObject("reductionInfoList", pageInfo.getList());
		
		//传入basePath
		String path = request.getContextPath();
	    String
	    basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	    mv.addObject("basePath",basePath);
		
		LOGGER.info("查询ReductionInfo End");
		
		return mv;
	}
	
	/**
	 * 上传作弊信号
	 */
	@RequestMapping(value = "/uploadReductionInfo", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData uploadReductionInfo(String id, HttpServletRequest request) throws Exception{
		LOGGER.info("开始上传作弊信号");
		ReductionInfo reductionInfo = reductioninfoService.getReductionInfoById(id);
		if(reductionInfo == null) {
			return AsyncResponseData.getSuccess().asParamError("参数错误");
		}
		User user = LoginInterceptor.getCurrentUser();
		if(user == null) {
			return AsyncResponseData.getSuccess().asParamError("查询不到用户信息,请重新登录");
		}
		
		if (1 == reductionInfo.getRecognitionResult()) {//确认作弊则上传
			//判断该信号是否已经上传
			KafkaSync kafkaSync = kafkaSyncService.queryByDataId(id);
			if(kafkaSync != null){
				return AsyncResponseData.getSuccess("该信号已经上传");
			}else{
				Organization currentOrg = organizationService.getOrganizationById(user.getOrgId());
				Organization upperOrg = null;
				if(currentOrg != null) {
					upperOrg = organizationService.getOrganizationById(currentOrg.getParentId());
				}
				
				if(upperOrg == null || upperOrg.getIp() == null || "".equals(upperOrg.getIp())){
					return AsyncResponseData.getSuccess("没有上级机构可以上传");
				}
				String address = upperOrg.getIp() + ":" + JyKafkaProducer.KAFKA_PORT;
				new JyKafkaProducer(address).send("reductionInfo,add", JSON.toJSONString(reductionInfo));
				
				kafkaSync = new KafkaSync();
				kafkaSync.setTime(new Date());
				kafkaSync.setType("reductionInfo");
				kafkaSync.setDataId(reductionInfo.getId());
				kafkaSync.setId(UUIDUtil.get32UUID());
				kafkaSyncService.addKafkaSync(kafkaSync);
				
				String fileAddr = reductionInfo.getFileAddr();
				String orgId = reductionInfo.getOrgId();
				String uploadFile = request.getServletContext().getRealPath("/") + fileAddr;
				//连接sftp
				ChannelSftp sftp = SftpUtils.connect();
				if(user.getOrgId() != null && user.getOrgId().equals(orgId)) {//当前用户组织机构和信号的机构一致,上传信号文件至sftp
					System.out.println("uploadFile == " + uploadFile);
					SftpUtils.upload("/upload", uploadFile, sftp);
					SftpUtils.disConnect(sftp);
				}
			}
		}
		
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 信号收听
	 */
	@RequestMapping(value = "/listen", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData listenSignal(HttpServletRequest request, String id) throws Exception{
		ReductionInfo reductionInfo = reductioninfoService.getReductionInfoById(id);
		if(reductionInfo == null) {
			return AsyncResponseData.getSuccess().asParamError("参数错误");
		}
		
		String fileAddr = reductionInfo.getFileAddr();
		String orgId = reductionInfo.getOrgId();
		User user = LoginInterceptor.getCurrentUser();
		if(user == null) {
			return AsyncResponseData.getSuccess().asParamError("请重新登陆");
		}
		
		String uploadFile = request.getServletContext().getRealPath("/") + fileAddr;
		//连接sftp
		ChannelSftp sftp = SftpUtils.connect();
		if(user.getOrgId() != null && user.getOrgId().equals(orgId)) {//当前用户组织机构和信号的机构一致,上传信号文件至sftp
			System.out.println("uploadFile == " + uploadFile);
			SftpUtils.upload("/upload", uploadFile, sftp);
		}

		String fileName = reductionInfo.getFileName();
		String saveFile = request.getServletContext().getRealPath("/") + "static/sftpDownload/" + fileName;
		SftpUtils.download("/upload",fileName , saveFile, sftp);
		SftpUtils.disConnect(sftp);
		
		return AsyncResponseData.getSuccess("static/sftpDownload/" + fileName);
	}
	
	/**
	 * 读取txt文件
	 */
	@RequestMapping(value = "/readTxt", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData readTxt(HttpServletRequest request, String id) throws Exception{
		try {
			String encoding="UTF-8";
			ReductionInfo reductionInfo = reductioninfoService.getReductionInfoById(id);
			if(reductionInfo == null) {
				return AsyncResponseData.getSuccess().asParamError("参数错误");
			}
			
			String fileAddr = reductionInfo.getFileAddr();
			String orgId = reductionInfo.getOrgId();
			User user = LoginInterceptor.getCurrentUser();
			if(user == null) {
				return AsyncResponseData.getSuccess().asParamError("请重新登录");
			}
			String uploadFile = request.getServletContext().getRealPath("/") + fileAddr;
			//连接sftp
			ChannelSftp sftp = SftpUtils.connect();
			if(user.getOrgId() != null && user.getOrgId().equals(orgId)) {//当前用户组织机构和信号的机构一致,上传信号文件至sftp
				System.out.println("uploadFile == " + uploadFile);
				SftpUtils.upload("/upload", uploadFile, sftp);
			}
			
			String fileName = reductionInfo.getFileName();
			String saveFile = request.getServletContext().getRealPath("/") + "static/sftpDownload/" + fileName;
			SftpUtils.download("/upload",fileName , saveFile, sftp);
			SftpUtils.disConnect(sftp);
			File file = new File(saveFile);
			if(file.exists() && file.isFile()) {//判断文件是否存在
				InputStreamReader read = new InputStreamReader(new FileInputStream(file),encoding);//考虑到编码格式
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
				List<String> txtContent = new ArrayList<String>();
				while((lineTxt = bufferedReader.readLine()) != null){
					txtContent.add(lineTxt);
				}
				read.close();
				return AsyncResponseData.getSuccess(txtContent);
			}else {
				return AsyncResponseData.getSuccess("找不到指定的文件");
			}	
		}catch(Exception e) {
			e.printStackTrace();
	        return AsyncResponseData.getSuccess("读取文件内容出错");
		}
	}
	
}
