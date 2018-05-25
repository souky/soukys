package com.jy.moudles.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jy.common.excelUtil.ExportExcel;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.kafka.producer.KafkaMessageType;
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.LogUtil;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.exam.constant.ExamStatus;
import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.entity.ExamSub;
import com.jy.moudles.exam.service.ExamService;
import com.jy.moudles.exam.service.ExamSubService;
import com.jy.moudles.exam.utils.ExamUtils;
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
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 创建人：wb
 * 创建时间：2017-10-16 21:29:18
 */
@Controller
public class ExamController {

	@Autowired
	private ExamService examService;

    @Autowired
    private ExamSubService exsubService;

	private static final Logger LOGGER = LoggerFactory.getLogger(ExamController.class);
	
	//后台异步请求列表页面
	@RequestMapping(value="/showExamList",method = RequestMethod.POST)
	public ModelAndView getAllExamList(@RequestParam int pageNum,@RequestParam int pageSize,
			HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		PageHelper.startPage(pageNum, pageSize);
    	PageInfo<Exam> exam = new PageInfo<Exam>(examService.queryExamFilter(null));
		mv.setViewName("exam/post/showExamListPost");
		mv.addObject("examList", exam.getList());
		mv.addObject("pageNow", exam.getPageNum());
		mv.addObject("pageTotal", exam.getPages());
		//传入basePath
		String path = request.getContextPath();
	    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	    mv.addObject("basePath",basePath);
		return mv;
	}
	
	//后台异步返回数据
	@RequestMapping(value="/showExamListData",method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData showExamListData(){
		List<Exam> list = examService.queryExamFilter(null);
		return AsyncResponseData.getSuccess(list);
	}
	//导出考试列表
	@RequestMapping(value="/exportExams")
	@ResponseBody
	public void exportExams(HttpServletResponse response,HttpServletRequest request){
    	LOGGER.info("导出考试计划开始");
		List<Exam> list = examService.queryExamFilter(null);
		ExportExcel ee = new ExportExcel("这是考试列表文件的标题",Exam.class);
		ee.setDataList(list);
		try {
			ee.write(response,"ExamList.xlsx" );
		} catch (IOException e) {
			e.printStackTrace();
		}
		LOGGER.info("导出考试计划结束");
	}
	
	
	
	@RequestMapping(value="/saveOrUpdateExam",method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveOrUpdateExam(HttpServletRequest request){
    	LOGGER.info("修改/新增  考试计划 开始");
    	String id = request.getParameter("examId");
    	String examName = request.getParameter("examName");
    	String examNo = request.getParameter("examNo");
		String begindateString = request.getParameter("examStartTime");
		String enddateString = request.getParameter("examEndTime");
		String examTypeId = request.getParameter("examTypeId");
		int status = ExamStatus.ON;
		String statusStr = request.getParameter("status");
		if(statusStr != null && !"".equals(statusStr)){
			status = Integer.parseInt(statusStr);
		}

		int rows = 0;
		
		Exam exam = new Exam();
		exam.setExamName(examName);
		exam.setExamNo(examNo);
		exam.setStatus(status);
		exam.setExamTypeId(examTypeId);
		//非空验证
		if(StringUtils.isBlank(examName)){
			return AsyncResponseData.getSuccess().asParamError("考试名称不能为空");
		}
		if(StringUtils.isBlank(examNo)){
			return AsyncResponseData.getSuccess().asParamError("考试编号不能为空");
		}
		if(StringUtils.isBlank(examTypeId)){
			return AsyncResponseData.getSuccess().asParamError("考试类型不能为空");
		}

		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("year", examNo.substring(0, 4));
		filter.put("examTypeId", examTypeId);
		List<Exam> exams = examService.queryExamsByExamTypeAndYear(filter);
		if(exams != null && exams.size() > 0){
			if(StringUtils.isBlank(id)){
				return AsyncResponseData.getSuccess().asParamError("该类型考试计划已经存在");
			}else{
				for(Exam e : exams){
					if(!id.equals(e.getId())){
						return AsyncResponseData.getSuccess().asParamError("该类型考试计划已经存在");
					}
				}
			}
		}

		List<Exam> allExams = examService.queryExamFilter(null);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date begindate = sdf.parse(begindateString);
			Date enddate = sdf.parse(enddateString);
			//时间比较 开始日期不能大于结束日期
			if(begindate.getTime() >= enddate.getTime()){
				return AsyncResponseData.getSuccess().asParamError("开始日期大于或等于结束日期");
			}
			//一个时间段内只有存在一个考试计划
			for (Exam e: allExams) {
				if((begindate.getTime() > e.getStartTime().getTime() && begindate.getTime() < e.getEndTime().getTime()) ||
						(enddate.getTime() > e.getStartTime().getTime() && enddate.getTime() < e.getEndTime().getTime())){
					return AsyncResponseData.getSuccess().asParamError("存在两场考试时间冲突");
				}
			}

			//如果id不为空,校验修改后的考试计划时间,与已经存在的考试场次时间是否冲突
			if(StringUtils.isNotBlank(id)){
                filter.clear();
                filter.put("examPlanId", id);
                List<ExamSub> examSubs = exsubService.queryExsubsFilter(filter);
                if(examSubs != null && examSubs.size() > 0){
                    for(ExamSub examSub : examSubs){
                        if((examSub.getStartTime().getTime() < begindate.getTime()) ||
                                (examSub.getEndTime().getTime() > enddate.getTime())){
                            return AsyncResponseData.getSuccess().asParamError("考试计划时间与考试场次时间冲突");
                        }
                    }
                }
            }

			exam.setStartTime(begindate);
			exam.setEndTime(enddate);
		} catch (ParseException e) {
			e.printStackTrace();
			LOGGER.info("日期转化异常");
			return AsyncResponseData.getSuccess().asParamError("网络错误");
		}
		
		//
		User user = LoginInterceptor.getCurrentUser();
		//新增
		exam.setUpdateUser(user.getId());
		exam.setUpdateDate(new Date());

		//判断库中是否存在启用的考试计划
		filter.clear();
		filter.put("examNo", examNo);
        List<Exam> examList = examService.queryExamFilter(filter);
		if(StringUtils.isBlank(id)){
			if(examList == null || examList.isEmpty()){
				exam.setId(UUIDUtil.get32UUID());
				exam.setCreateDate(new Date());
				exam.setCreateUser(user.getId());
				exam.setOrgId(user.getOrgId());
				examService.addExam(exam);
				sengExamData(KafkaMessageType.ADD, exam, null, null);
				LogUtil.addLog("新增考试计划", LogOperationType.ADD, request);
			}else{
				return AsyncResponseData.getSuccess().asParamError("该考试编号已经存在");
			}
		}else{
			exam.setId(id);
			if(examList == null || examList.isEmpty()){
				examService.updateExam(exam);
				sengExamData(KafkaMessageType.UPDATE, exam, null, null);
				LogUtil.addLog("修改考试计划", LogOperationType.EDIT, request);
			}else if(examList != null && !examList.isEmpty() && exam.getId().equals(examList.get(0).getId())){
				examService.updateExam(exam);
				sengExamData(KafkaMessageType.UPDATE, exam, null, null);
				LogUtil.addLog("修改考试计划", LogOperationType.EDIT, request);
			}else{
				return AsyncResponseData.getSuccess().asParamError("该考试编号已经存在");
			}
		}
		//下发考试计划
		ExamUtils.issuedExam();

		return AsyncResponseData.getSuccess(rows);
	}
	
	@RequestMapping(value="/deleteExam",method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteExam(HttpServletRequest request){
    	LOGGER.info("删除考试计划 开始");
		String id = request.getParameter("id");
		Integer rows = 0;
		if(!StringUtils.isBlank(id)){
			rows = examService.deleteExamById(id);
			sengExamData(KafkaMessageType.DELETE, null, id, null);
			exsubService.deleteExsubsByExamPlanId(id);
			LogUtil.addLog("删除考试计划", LogOperationType.DELETE, request);
			LogUtil.addLog("删除考试计划对应的考试场次", LogOperationType.DELETE, request);
			LOGGER.info("删除考试计划 结束");
			//下发考试计划 
			ExamUtils.issuedExam();
		}
		return AsyncResponseData.getSuccess(rows);
	}
	
	@RequestMapping(value="/deleteExamByNums",method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteExamByNums(HttpServletRequest request){
    	LOGGER.info("删除考试计划 开始");
		if(StringUtils.isBlank(request.getParameter("ids"))){
			return AsyncResponseData.getSuccess(0);
		}
		String[] examNums = request.getParameter("ids").split(",");
		Integer rows = 0;
		List<String> ids = new ArrayList<String>();
		for(String s:examNums){
			if(!StringUtils.isBlank(s)){
				ids.add(s);
			}
		}
		if(ids.isEmpty()){
			return AsyncResponseData.getSuccess(rows);
		}
		rows = examService.deleteExams(ids);
		sengExamData(KafkaMessageType.DELETE_LIST, null, null, ids);
		for (String id:ids) {
			exsubService.deleteExsubsByExamPlanId(id);
		}
		LogUtil.addLog("批量删除考试计划", LogOperationType.DELETE, request);
		LogUtil.addLog("批量删除考试计划对应的考试场次", LogOperationType.DELETE, request);
		LOGGER.info("删除考试计划结束");
		//下发考试计划
		ExamUtils.issuedExam();
		
		return AsyncResponseData.getSuccess(rows);
	}
	
	@RequestMapping(value="/queryMaxExamNo",method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryMaxExamNo(){
		String examNo = examService.queryMaxExamNo();
		return AsyncResponseData.getSuccess(examNo);
	}

    @RequestMapping(value="/changeStatus",method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData changeStatus(String id,int status,HttpServletRequest request){
        List<Exam> examList = examService.queryExamById(id);
        if(examList == null) {
            return AsyncResponseData.getSuccess().asParamError("参数错误");
        }
        Exam exam = examList.get(0);
        exam.setStatus(status);
	    examService.updateExam(exam);
        LogUtil.addLog("修改考试计划", LogOperationType.EDIT, request);
        LOGGER.info("修改考试状态结束");
       
        //开启线程,下发到侦测
        ExamUtils.issuedExam();

        return AsyncResponseData.getSuccess();
    }

	
	//----------------------------------------------------------------------------------------------------------------
    //发送kafka消息
    /**
     * exam,examId,ids同时只能有一个为非空
     * @param type add/update/delete/deleteList
     * @param exam 增加或者修改考试计划
     * @param examId 删除考试计划
     * @param ids 批量删除考试计划
     */
	private void sengExamData(String type,Exam exam,String examId,List<String> ids){
        LOGGER.info("----kafak start to send exam data,type = " + type);
        //ExamUtils.sengExamData(type, exam, examId, ids);
        LOGGER.info("----kafak send exam data ended,type = " + type);
	}

	
}