package com.jy.moudles.auditionForm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.moudles.auditionForm.entity.AuditionForm;
import com.jy.moudles.auditionForm.service.AuditionFormService;

/** 
 * auditionForm实现类
 *
 * 创建人：Administrator
 * 创建时间：2019-04-15
 */
@Controller
@RequestMapping(value="/auditionform")
public class AuditionFormController {
	
	@Autowired
	private AuditionFormService auditionformService;
	
	private static final Logger logger = LoggerFactory.getLogger(AuditionFormController.class);
	
	
	
	
	@RequestMapping(value = "/pages")
	public ModelAndView pages() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("table/tableList");
		return mv;
	}
	
	/**
	 * 新增auditionform对象
	 * 
	 * @param auditionform
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAuditionForm", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveAuditionForm(AuditionForm auditionform) throws Exception{
		logger.info("新增AuditionForm Start");
		
		auditionformService.insertAuditionForm(auditionform);
		
		logger.info("新增AuditionForm End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 修改auditionform对象
	 * 
	 * @param auditionform
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateAuditionForm", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateAuditionForm(AuditionForm auditionform) throws Exception{
		logger.info("修改AuditionForm Start");
		
		auditionformService.updateAuditionForm(auditionform);
		
		logger.info("修改AuditionForm End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除auditionform对象
	 * 
	 * @param auditionform
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAuditionForm", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteAuditionForm(AuditionForm auditionform) throws Exception{
		logger.info("删除AuditionForm Start");
		
		auditionformService.deleteAuditionFormById(auditionform.getId());
		
		logger.info("删除AuditionForm End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取auditionform对象
	 * 
	 * @param auditionform
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryAuditionForms", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryAuditionForms(AuditionForm auditionform) throws Exception{
		logger.info("获取AuditionForm Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		List<AuditionForm> auditionforms= auditionformService.queryAuditionFormsFilter(filter);
		logger.info("获取AuditionForm End");
		
		return AsyncResponseData.getSuccess(auditionforms);
	}
	
	/**
	 * 根据ID获取auditionform对象
	 * 
	 * @param auditionform
	 * @throws Exception
	 */
	@RequestMapping(value = "/getAuditionFormById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getAuditionFormById(String id) throws Exception{
		logger.info("获取AuditionForm Start");
		
		AuditionForm auditionform = new AuditionForm();
		
		auditionform = auditionformService.getAuditionFormById(id);
		
		logger.info("获取AuditionForm End");
		
		return AsyncResponseData.getSuccess(auditionform);
	}
	
}
