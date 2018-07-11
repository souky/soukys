package com.jy.moudles.punchRank.controller;

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

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.UserUtils;
import com.jy.moudles.punchRank.entity.PunchRank;
import com.jy.moudles.punchRank.entity.RankVO;
import com.jy.moudles.punchRank.service.PunchRankService;
import com.jy.moudles.user.entity.User;

/** 
 * PunchRank实现类
 *
 * 创建人：Administrator
 * 创建时间：2018-07-04
 */
@Controller
@RequestMapping(value="/punchrank")
public class PunchRankController {
	
	@Autowired
	private PunchRankService punchrankService;
	
	private static final Logger logger = LoggerFactory.getLogger(PunchRankController.class);
	
	/**
	 * 新增punchrank对象
	 * 
	 * @param punchrank
	 * @throws Exception
	 */
	@RequestMapping(value = "/savePunchRank", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData savePunchRank(String rankTime,String orgCode) throws Exception{
		return punchrankService.insertPunchRank(orgCode,rankTime);
	}
	
	/**
	 * 修改punchrank对象
	 * 
	 * @param punchrank
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePunchRank", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updatePunchRank(RankVO rankVO) throws Exception{
		logger.info("修改PunchRank Start");
		
		punchrankService.updatePunchRank(rankVO);
		
		logger.info("修改PunchRank End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 删除punchrank对象
	 * 
	 * @param punchrank
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePunchRank", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deletePunchRank(PunchRank punchrank) throws Exception{
		logger.info("删除PunchRank Start");
		
		punchrankService.deletePunchRankById(punchrank.getId());
		
		logger.info("删除PunchRank End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 * 获取上周排名
	 * 
	 * @param punchrank
	 * @throws Exception
	 */
	@RequestMapping(value = "/getLastWeekRank", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getLastWeekRank(HttpServletRequest request) throws Exception{
		logger.info("getLastWeekRank Start");
		
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		
		String orgCode = user.getOrgCode();
		PunchRank punchrank = new PunchRank();
		punchrank.setOrgCode(orgCode);
		
		List<PunchRank> punchranks = punchrankService.getLastPunchRank(punchrank);
		
		logger.info("getLastWeekRank End");
		
		return AsyncResponseData.getSuccess(punchranks);
	}
	
	/**
	 * 获取punchrank对象
	 * 
	 * @param punchrank
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryPunchRanks", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryPunchRanks(PunchRank punchrank) throws Exception{
		logger.info("获取PunchRank Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("rankTime", punchrank.getRankTime());
		filter.put("orgCode", punchrank.getOrgCode());
		
		List<PunchRank> punchranks= punchrankService.queryPunchRanksFilter(filter);
		logger.info("获取PunchRank End");
		
		return AsyncResponseData.getSuccess(punchranks);
	}
	
	/**
	 * 根据ID获取punchrank对象
	 * 
	 * @param punchrank
	 * @throws Exception
	 */
	@RequestMapping(value = "/getPunchRankById", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData getPunchRankById(String id) throws Exception{
		logger.info("获取PunchRank Start");
		
		PunchRank punchrank = new PunchRank();
		
		punchrank = punchrankService.getPunchRankById(id);
		
		logger.info("获取PunchRank End");
		
		return AsyncResponseData.getSuccess(punchrank);
	}
	
}
