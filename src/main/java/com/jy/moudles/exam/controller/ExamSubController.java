package com.jy.moudles.exam.controller;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.kafka.producer.KafkaMessageType;
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.LogUtil;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.exam.entity.ExamSub;
import com.jy.moudles.exam.service.ExamSubService;
import com.jy.moudles.exam.utils.ExamUtils;
import com.jy.moudles.systemLog.constants.LogOperationType;
import com.jy.moudles.user.entity.User;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** 
 * 创建人：wb
 * 创建时间：2017-10-16 21:29:18
 */
@Controller
@RequestMapping(value="/exsub")
public class ExamSubController {
	
	@Autowired
	private ExamSubService exsubService;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ExamSubController.class);
	
	/**
	 *  保存考试场次
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveExsub", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveExsub(HttpServletRequest request){
    	LOGGER.info("新增考试场次开始");
		int row = 0;
		Map<String,String> errMsgs = new HashMap<String,String>();
		ExamSub exsub = new ExamSub();
		
		String examId = request.getParameter("examId");
		String no = request.getParameter("no");
		String name = request.getParameter("name");
		String begintimes = request.getParameter("subStartTime");
		String endtimes = request.getParameter("subEndTime");
		
		String begindates = request.getParameter("examStartTime");
		String enddates = request.getParameter("examEndTime");
		
		//验证数据
		if(StringUtils.isBlank(examId)){
			errMsgs.put("error", "考试编号为空");
			return AsyncResponseData.getParamError(errMsgs);
		}
		if(StringUtils.isBlank(no)){
			errMsgs.put("error", "场次编号为空");
			return AsyncResponseData.getParamError(errMsgs);
		}
		
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("no", no);
		filter.put("examPlanId",examId);
		List<ExamSub> examSubList = exsubService.queryExsubsFilter(filter);
		if(examSubList != null && !examSubList.isEmpty()){
			errMsgs.put("error", "该场次已经存在");
			return AsyncResponseData.getParamError(errMsgs);
		}
		
		if(StringUtils.isBlank(name)){
			errMsgs.put("error", "场次名称为空");
			return AsyncResponseData.getParamError(errMsgs);
		}
		filter.clear();
		filter.put("name", name);
		filter.put("examPlanId",examId);
		examSubList = exsubService.queryExsubsFilter(filter);
		if(examSubList != null && !examSubList.isEmpty()){
			errMsgs.put("error", "该考试场次名称已经存在已经存在");
			return AsyncResponseData.getParamError(errMsgs);
		}
		if(StringUtils.isBlank(begintimes)){
			errMsgs.put("error", "考试场次开始时间为空");
			return AsyncResponseData.getParamError(errMsgs);
		}
		if(StringUtils.isBlank(endtimes)){
			errMsgs.put("error", "考试场次结束时间为空");
			return AsyncResponseData.getParamError(errMsgs);
		}
		if(StringUtils.isBlank(begindates) || StringUtils.isBlank(enddates)){
			errMsgs.put("error", "获取考试计划时间失败");
			return AsyncResponseData.getParamError(errMsgs);
		}
		//日期转化
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date begintime = sdf.parse(begintimes);
			Date endtime = sdf.parse(endtimes);
			if(begintime.getTime() >= endtime.getTime()){
				errMsgs.put("error", "场次开始时间大于或等于结束时间");
				return AsyncResponseData.getParamError(errMsgs);
			}
			
			Date begindate = sdf.parse(begindates);
			Date enddate = sdf.parse(enddates);
			if(begindate.getTime() > begintime.getTime() || enddate.getTime() < endtime.getTime()){
				errMsgs.put("error", "场次开始时间和结束时间必须在计划时间之内");
				return AsyncResponseData.getParamError(errMsgs);
			}

            filter.put("examPlanId", examId);
            List<ExamSub> examSubs = exsubService.queryExsubsFilter(filter);
            if(examSubs != null && examSubs.size() > 0){
                for(ExamSub examSub : examSubs){
                    if((begintime.getTime() > examSub.getStartTime().getTime() && begintime.getTime() < examSub.getEndTime().getTime()) ||
                            (endtime.getTime() > examSub.getStartTime().getTime() && endtime.getTime() < examSub.getEndTime().getTime())){
                        errMsgs.put("error", "考试场次时间存在冲突");
                        return AsyncResponseData.getParamError(errMsgs);
                    }
                }
            }

			
			exsub.setStartTime(begintime);
			exsub.setEndTime(endtime);
		} catch (ParseException e) {
			e.printStackTrace();
			errMsgs.put("error", "日期转化异常");
			return AsyncResponseData.getParamError(errMsgs);
		}
		
		
		if(!StringUtils.isNumeric(no)){
			errMsgs.put("error", "场次编号错误");
			return AsyncResponseData.getParamError(errMsgs);
		}
		exsub.setId(UUIDUtil.get32UUID());
		exsub.setNo(Integer.parseInt(no));
		exsub.setName(name);
		exsub.setExamPlanId(examId);
		
		User user = LoginInterceptor.getCurrentUser();
		exsub.setOrgId(user.getOrgId());
		exsub.setCreateDate(new Date());
		exsub.setUpdateDate(new Date());
		exsub.setCreateUser(user.getId());
		exsub.setUpdateUser(user.getId());
		row = exsubService.insertExsub(exsub);
		sengExamSubData(KafkaMessageType.ADD, exsub, null);
		LogUtil.addLog("新增考试场次", LogOperationType.ADD, request);
		LOGGER.info("新增考试场次结束");
        ExamUtils.issuedExam();

		return AsyncResponseData.getSuccess(row);
	}
	
	/**
	 *  exsub 
	 * 
	 * @param exsub
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateExsub", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateExsub(@RequestBody ExamSub exsub,HttpServletRequest request) throws Exception{
    	LOGGER.info("更新 考试场次 开始");
		
		exsubService.updateExsub(exsub);
		
		LOGGER.info("更新 考试场次 开始");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 *  exsub 
	 * 
	 * @param exsub
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteExsub", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteExsub(ExamSub exsub,HttpServletRequest request) throws Exception{
    	LOGGER.info("删除 考试场次 开始");
		int row = 0;
		if(exsub!= null){
			row = exsubService.deleteExsubById(exsub.getId());
			sengExamSubData(KafkaMessageType.DELETE, null, exsub.getId());
			LogUtil.addLog("删除考试场次", LogOperationType.DELETE, request);
            ExamUtils.issuedExam();
		}
		
		LOGGER.info("删除 考试场次 结束");
		return AsyncResponseData.getSuccess(row);
	}
	
	/**
	 *  exsub 
	 * 
	 * @param exsub
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryExsubs", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryExsubs(ExamSub exsub,HttpServletRequest request) throws Exception{
    	LOGGER.info("查询考试场次开始");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("examPlanId", exsub.getExamPlanId());
		List<ExamSub> exsubs= exsubService.queryExsubsFilter(filter);
		LOGGER.info("查询考试场次");
		
		return AsyncResponseData.getSuccess(exsubs);
	}

	//----------------------------------------------------------------------------------------------------------------
	//发送kafka消息
	/**
	 * examSub,examSubId,ids同时只能有一个为非空
	 * @param type add/update/delete
	 * @param examSub 增加或者修改考试场次
	 * @param examSubId 删除考试场次
	 */
	private void sengExamSubData(String type,ExamSub examSub,String examSubId){
        LOGGER.info("----kafak start to send examSub data,type = " + type);
        //ExamUtils.sengExamSubData(type, examSub, examSubId);
        LOGGER.info("----kafak send examSub data ended,type = " + type);
	}
	
}
