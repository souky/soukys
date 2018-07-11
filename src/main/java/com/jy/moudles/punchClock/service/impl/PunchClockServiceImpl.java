package com.jy.moudles.punchClock.service.impl;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.jy.common.config.Global;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.jsonadpter.AsyncResponseData.ResultData;
import com.jy.common.utils.DatesUtil;
import com.jy.common.utils.UserUtils;
import com.jy.moudles.punchClock.dao.PunchClockDao;
import com.jy.moudles.punchClock.entity.PunchClock;
import com.jy.moudles.punchClock.service.PunchClockService;
import com.jy.moudles.targetInfo.dao.TargetInfoDao;
import com.jy.moudles.targetInfo.entity.TargetInfo;
import com.jy.moudles.user.entity.User;

/** 
 * PunchClock业务实现类
 * 创建人：Administrator
 * 创建时间：2018-05-25
 */
@Service
public class PunchClockServiceImpl implements PunchClockService {

	@Autowired
	private PunchClockDao PunchClockDao;
	
	@Autowired
	private TargetInfoDao TargetInfoDao;
	
	@Override
	public AsyncResponseData.ResultData punch(HttpServletRequest request,MultipartFile file){
		
		if(null == file) {
			return AsyncResponseData.getSuccess().asParamError("no file");
		}
		
		User user = UserUtils.getLoginUser(request);
		String punchInfo = request.getParameter("text");
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		String dateDay = DatesUtil.getDateFormat("yyyy-MM-dd");
		String id = dateDay + "_" + user.getId();
		
		PunchClock punchclock = PunchClockDao.getPunchClockById(id);
		
		//文件保存
		File files = new File(Global.SYS_FILE_PATH + user.getId());
		if(!files.exists()) {
			files.mkdirs();
		}
		
		File files_ = new File(files.getPath()+"/" + dateDay + ".jpg");
		if(!files_.exists()) {
			try {
				
				files_.createNewFile();
				FileOutputStream input = new FileOutputStream(files_);
				input.write(file.getBytes());
				input.flush();
	            input.close();
				//图片加时间水印
				Image srcImg = ImageIO.read(files_);
	            int srcImgWidth = srcImg.getWidth(null);
	            int srcImgHeight = srcImg.getHeight(null);
	            // 加水印
	            BufferedImage bufImg = new BufferedImage(srcImgWidth, srcImgHeight, 
	            		BufferedImage.TYPE_INT_RGB);
	            Graphics2D g = bufImg.createGraphics();
	            g.drawImage(srcImg, 0, 0, srcImgWidth, srcImgHeight, null);
	            Font font = new Font("Courier New", Font.PLAIN, 20);  
	            g.setColor(Color.BLACK); //根据图片的背景设置水印颜色
	            g.setFont(font);
	            int x = srcImgWidth - 
	            		g.getFontMetrics(g.getFont()).charsWidth(dateDay.toCharArray(), 0, dateDay.length())
	            		- 10;
	            int y = srcImgHeight - 10;
	            g.drawString(dateDay, x, y);
	            g.dispose();
	            FileOutputStream inputs = new FileOutputStream(files_);
	            ImageIO.write(bufImg, "jpg", inputs);
	            inputs.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
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
			
			PunchClockDao.insertPunchClock(punchclock);
			
			//增加进度
			TargetInfo targetInfo = TargetInfoDao.getTargetNow(user.getId());
			if(null != targetInfo) {
				Map<String,Object> filter = new HashMap<>();
				filter.put("userId", targetInfo.getUserId());
				filter.put("timeComperS", targetInfo.getStartTime());
				filter.put("timeComperE", targetInfo.getEndTime());
				filter.put("isLeave",0);
				
				List<PunchClock> list = PunchClockDao.queryPunchClocksFilter(filter);
				long offTime = targetInfo.getEndTime().getTime() - targetInfo.getStartTime().getTime();
				long offDay = offTime / 86400l / 1000l;
				
				BigDecimal doneDay = new BigDecimal(list.size());
				BigDecimal totalDay = new BigDecimal(offDay);
				
				BigDecimal RateProgress = doneDay.divide(totalDay,2,BigDecimal.ROUND_HALF_DOWN)
						.multiply(new BigDecimal(100));
				
				TargetInfo targetInfoNew = new TargetInfo();
				targetInfoNew.setId(targetInfo.getId());
				targetInfoNew.setRateProgress(RateProgress.intValue());
				TargetInfoDao.updateTargetInfo(targetInfoNew);
			}
			
			
			return AsyncResponseData.getSuccess();
		}
	}
	
	@Override
	public void updatePunchClock(PunchClock PunchClock){
		PunchClockDao.updatePunchClock(PunchClock);
	}
	
	@Override
	public PunchClock getPunchClockById(String id){
		return PunchClockDao.getPunchClockById(id);
	}
	
	@Override
	public List<PunchClock> queryPunchClocksFilter(Map<String, Object> filter){
		return PunchClockDao.queryPunchClocksFilter(filter);
	}
	
	@Override
	public void deletePunchClockById(String id){
		PunchClockDao.deletePunchClockById(id);
	}
	
	@Override
	public void deletePunchClocks(List<String> ids){
		PunchClockDao.deletePunchClocks(ids);
	}

	@Override
	public List<Integer> getPunchClockByMonth(String userId,int month) {
		return PunchClockDao.getPunchClockByMonth(userId, month);
	}
	
	public List<String> getPunchClockByTarget(String userId,String rankTime){
		List<String> returnList = new ArrayList<>();
		TargetInfo targetInfo = TargetInfoDao.getTargetInfoByRankTime(userId,rankTime);
		if(null != targetInfo) {
			Map<String,Object> filter = new HashMap<>();
			filter.put("userId", targetInfo.getUserId());
			filter.put("timeComperS", targetInfo.getStartTime());
			filter.put("timeComperE", targetInfo.getEndTime());
			filter.put("isLeave",0);
			
			List<PunchClock> list = PunchClockDao.queryPunchClocksFilter(filter);
			if(null != list && list.size() > 0) {
				for(PunchClock e:list) {
					returnList.add(e.getImgBase());
				}
			}
			
		}
		return returnList;
	}

	@Override
	public void insertPunchClock(PunchClock PunchClock) {
		PunchClockDao.insertPunchClock(PunchClock);
	}

	@Override
	public ResultData punchLeave(String leaveInfo, HttpServletRequest request) {
		User user = UserUtils.getLoginUser(request);
		if(null == user) {
			return AsyncResponseData.getSuccess().asLogicError("no login");
		}
		
		String id = DatesUtil.getDateFormat("yyyy-MM-dd") + "_" + user.getId();
		
		PunchClock punchclock = PunchClockDao.getPunchClockById(id);
		
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
			
			PunchClockDao.insertPunchClock(punchclock);
		}
		


		return AsyncResponseData.getSuccess();
	}
	
}

