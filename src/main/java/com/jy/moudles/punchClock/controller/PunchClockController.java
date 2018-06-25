package com.jy.moudles.punchClock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jy.common.config.Global;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.DatesUtil;
import com.jy.common.utils.UserUtils;
import com.jy.moudles.punchClock.VO.DateVO;
import com.jy.moudles.punchClock.entity.PunchClock;
import com.jy.moudles.punchClock.service.PunchClockService;
import com.jy.moudles.user.entity.User;

/**
 * PunchClock实现类
 *
 * 创建人：Administrator 创建时间：2018-05-25
 */
@Controller
@RequestMapping(value = "/punchclock")
public class PunchClockController {

	@Autowired
	private PunchClockService punchclockService;

	private static final Logger logger = LoggerFactory.getLogger(PunchClockController.class);

	/**
	 * 新增punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/savePunchClock", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData savePunchClock(PunchClock punchclock) throws Exception {
		logger.info("新增PunchClock Start");

		punchclockService.insertPunchClock(punchclock);

		logger.info("新增PunchClock End");
		return AsyncResponseData.getSuccess();
	}

	/**
	 * 修改punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePunchClock", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updatePunchClock(PunchClock punchclock) throws Exception {
		logger.info("修改PunchClock Start");

		punchclockService.updatePunchClock(punchclock);

		logger.info("修改PunchClock End");
		return AsyncResponseData.getSuccess();
	}

	/**
	 * 删除punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePunchClock", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deletePunchClock(PunchClock punchclock) throws Exception {
		logger.info("删除PunchClock Start");

		punchclockService.deletePunchClockById(punchclock.getId());

		logger.info("删除PunchClock End");
		return AsyncResponseData.getSuccess();
	}

	/**
	 * 获取punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryPunchClocks", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryPunchClocks(PunchClock punchclock,
			int pageNum,int pageSize,HttpServletRequest request) throws Exception {
		logger.info("获取PunchClock Start");
		
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("isLeave", punchclock.getIsLeave());
		
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<PunchClock> punchclocks = new PageInfo<PunchClock>(
				punchclockService.queryPunchClocksFilter(filter));
		
		logger.info("获取PunchClock End");

		return AsyncResponseData.getSuccess(punchclocks);
	}

	/**
	 * 根据ID获取punchclock对象
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/getPunchClockById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getPunchClockById(String id) throws Exception {
		logger.info("获取PunchClock Start");

		PunchClock punchclock = new PunchClock();

		punchclock = punchclockService.getPunchClockById(id);

		logger.info("获取PunchClock End");

		return AsyncResponseData.getSuccess(punchclock);
	}
	
	/**
	 * 打卡检测
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkPunch", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData checkPunch(HttpServletRequest request) throws Exception {
		logger.info("checkPunch Start");
		
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		
		String id = DatesUtil.getDateFormat("yyyyMMdd") + "_" + user.getId();
		
		PunchClock punchclock = punchclockService.getPunchClockById(id);
		
		if(null != punchclock) {
			if("1".equals(punchclock.getIsLeave())) {
				return AsyncResponseData.getSuccess().asParamError("已经请假了哟");
			}else {
				return AsyncResponseData.getSuccess().asParamError("已经打卡了哟");
			}
		}

		logger.info("checkPunch End");

		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 请假
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/punchLeave", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData punchLeave(String leaveInfo,
			HttpServletRequest request) throws Exception {
		logger.info("ask_leave Start");

		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		
		String id = DatesUtil.getDateFormat("yyyyMMdd") + "_" + user.getId();
		
		PunchClock punchclock = punchclockService.getPunchClockById(id);
		
		if(null != punchclock) {
			if("1".equals(punchclock.getIsLeave())) {
				return AsyncResponseData.getSuccess().asParamError("已经请假了哟");
			}else {
				return AsyncResponseData.getSuccess().asParamError("已经打卡了哟");
			}
		}else {
			punchclock = new PunchClock();
			punchclock.setId(id);
			punchclock.setIsLeave("1");
			punchclock.setUserId(user.getId());
			punchclock.setOrgId(user.getOrgCode());
			punchclock.setPunchInfo(leaveInfo);
			punchclock.setTimeInfo(DatesUtil.getDateFormat("yyyy-MM-dd HH:mm:ss"));
			punchclock.setCreateDate(new Date());
			punchclock.setCreateUser(user.getUserName());
			punchclock.setImgBase("");
			
			punchclockService.insertPunchClock(punchclock);
		}
		

		logger.info("ask_leave End");

		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 打卡
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/punch", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData punch(HttpServletRequest request,MultipartFile file) throws Exception {
		logger.info("ask_leave Start");
		
		if(null == file) {
			return AsyncResponseData.getSuccess().asParamError("no file");
		}
		
		User user = UserUtils.getLoginUser(request);
		String punchInfo = request.getParameter("text");
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		String dateDay = DatesUtil.getDateFormat("yyyyMMdd");
		String id = dateDay + "_" + user.getId();
		
		PunchClock punchclock = punchclockService.getPunchClockById(id);
		
		//文件保存
		File files = new File(Global.SYS_FILE_PATH + user.getId());
		if(!files.exists()) {
			files.mkdirs();
		}
		
		File files_ = new File(files.getPath()+"/" + dateDay + ".jpg");
		if(!files_.exists()) {
			files_.createNewFile();
		}
		FileOutputStream input = new FileOutputStream(files_);
		input.write(file.getBytes());
		input.close();
		
		if(null != punchclock) {
			if("1".equals(punchclock.getIsLeave())) {
				return AsyncResponseData.getSuccess().asParamError("已经请假了哟");
			}else {
				return AsyncResponseData.getSuccess().asParamError("已经打卡了哟");
			}
		}else {
			punchclock = new PunchClock();
			punchclock.setId(id);
			punchclock.setIsLeave("0");
			punchclock.setUserId(user.getId());
			punchclock.setOrgId(user.getOrgCode());
			punchclock.setTimeInfo(DatesUtil.getDateFormat("yyyy-MM-dd HH:mm:ss"));
			punchclock.setCreateDate(new Date());
			punchclock.setCreateUser(user.getUserName());
			punchclock.setPunchInfo(punchInfo);
			punchclock.setImgBase(Global.IMG_PATH + user.getId() + "/" + dateDay + ".jpg");
			
			punchclockService.insertPunchClock(punchclock);
		}
		

		logger.info("ask_leave End");

		return AsyncResponseData.getSuccess();
	}
	
	

	/**
	 * 获取打卡日历
	 * 
	 * @param punchclock
	 * @throws Exception
	 */
	@RequestMapping(value = "/getPunchClockDate", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getPunchClockDate(HttpServletRequest request) throws Exception {
		logger.info("获取PunchClock Start");

		List<DateVO> listDate = DatesUtil.getListDate();
		
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
		List<Integer> listPunch = punchclockService.getPunchClockByMonth(user.getId(), month);
		for(DateVO e : listDate) {
			if(!"forbid".equals(e.getCss())) {
				if(listPunch.contains(e.getDays())) {
					e.setCheck(true);
				}
			}
		}
		logger.info("获取PunchClock End");
		return AsyncResponseData.getSuccess(listDate);
	}

}
