package com.jy.moudles.blackwhitelist.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.*;
import com.jy.common.validate.Validator;
import com.jy.moudles.blackwhitelist.entity.BlackWhiteList;
import com.jy.moudles.blackwhitelist.service.BlackWhiteListService;
import com.jy.moudles.systemLog.constants.LogOperationType;
import com.jy.moudles.user.entity.User;
import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.common.utils.GeneralProtocol;
import com.jy.protocol.jf.utils.IssuedSendUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.poifs.filesystem.OfficeXmlFileException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * blackWhiteList
 * @author xipeng
 *	2017-10-16
 */
@Controller
@RequestMapping(value="/blackwhitelist")
public class BlackWhiteListController {
	
	@Autowired
	private BlackWhiteListService blackwhitelistService;

	private static final Logger LOGGER = LoggerFactory.getLogger(BlackWhiteListController.class);
	
	/**
	 *
	 * @param blackwhitelist
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveBlackWhiteList", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData saveBlackWhiteList(BlackWhiteList blackwhitelist,HttpServletRequest request) throws Exception{
		LOGGER.info("新增BlackWhiteList Start");
        User user = LoginInterceptor.getCurrentUser();
        blackwhitelist.setOrgId(user.getOrgId());
        blackwhitelist.setCreateUser(user.getId());
        blackwhitelist.setUpdateUser(user.getId());
        blackwhitelist.setCreateDate(new Date());
        blackwhitelist.setUpdateDate(new Date());
		blackwhitelistService.insertBlackWhiteList(blackwhitelist);
		LogUtil.addLog("新增黑白名单", LogOperationType.ADD,request);
		LOGGER.info("新增BlackWhiteList End");
		//下发黑白名单
		sendBW();
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 *
	 * @param blackwhitelist
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateBlackWhiteList", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData updateBlackWhiteList(BlackWhiteList blackwhitelist,HttpServletRequest request) throws Exception{
		LOGGER.info("更新BlackWhiteList Start");
		String marjorFrequency = blackwhitelist.getMarjorFrequency();
		String secondFrequency = blackwhitelist.getSecondFrequency();
		if((!StringUtils.isNumeric(marjorFrequency)) || (!StringUtils.isNumeric(secondFrequency))){
			return AsyncResponseData.getSuccess().asParamError("频点参数不合法");
		}
		User user = LoginInterceptor.getCurrentUser();
		blackwhitelist.setUpdateUser(user.getId());
		blackwhitelist.setUpdateDate(new Date());
		if(2 == blackwhitelist.getFrequencyType()){
            Map<String, Object> filter = new HashMap<>();
            //查看是否有频段重叠的,频点不作考虑
            filter.put("frequencyType", "2");
            List<BlackWhiteList> blackWhiteLists = blackwhitelistService.queryBlackWhiteListsFilter(filter);
            if(blackWhiteLists != null && !blackWhiteLists.isEmpty()){
                int mFrequency = Integer.parseInt(marjorFrequency);
                int sFrequency = Integer.parseInt(secondFrequency);
                for(BlackWhiteList bw : blackWhiteLists){
                    if(!bw.getId().equals(blackwhitelist.getId())){
                        String marjorFrequency1 = bw.getMarjorFrequency();
                        String secondFrequency1 = bw.getSecondFrequency();
                        if((StringUtils.isNumeric(marjorFrequency)) && (StringUtils.isNumeric(secondFrequency))){
                            int mFrequency1 = Integer.parseInt(marjorFrequency1);
                            int sFrequency1 = Integer.parseInt(secondFrequency1);
                            if((mFrequency >= mFrequency1 && mFrequency <= sFrequency1) || (sFrequency >= mFrequency1 && sFrequency <= sFrequency1) ||
                                    (mFrequency < mFrequency1 && sFrequency > sFrequency1)){
                                return AsyncResponseData.getSuccess().asParamError("输入的频段与原有的频段存在冲突");
                            }
                        }
                    }
                }
            }
        }
		if (StringUtils.isBlank(blackwhitelist.getId())) {
            blackwhitelist.setCreateUser(user.getId());
            blackwhitelist.setCreateDate(new Date());
            blackwhitelist.setOrgId(user.getOrgId());
            blackwhitelist.setSource(1);
            blackwhitelistService.insertBlackWhiteList(blackwhitelist);
			LogUtil.addLog("新增黑白名单", LogOperationType.ADD,request);
        } else {
            blackwhitelistService.updateBlackWhiteList(blackwhitelist);
			LogUtil.addLog("更新黑白名单", LogOperationType.EDIT,request);
        }
		//下发黑白名单
		sendBW();
		LOGGER.info("更新BlackWhiteList End");
		return AsyncResponseData.getSuccess();
	}
	
	/**
	 *
	 * @param blackwhitelist
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteBlackWhiteList", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData deleteBlackWhiteList(BlackWhiteList blackwhitelist,HttpServletRequest request) throws Exception{
		LOGGER.info("删除BlackWhiteList Start");
		
		blackwhitelistService.deleteBlackWhiteListById(blackwhitelist.getId());
		LogUtil.addLog("删除黑白名单", LogOperationType.DELETE,request);
		LOGGER.info("删除BlackWhiteList End");
		//下发黑白名单
		sendBW();
		return AsyncResponseData.getSuccess();
	}
	
	/**
     * 批量删除blackwhitelist对象
     *
     * @return ModelAndView
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/deleteBlackWhiteLists", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData deleteBlackWhiteLists(HttpServletRequest request) throws Exception {
        LOGGER.info("批量删除黑白名单 Start");
        if (StringUtils.isBlank(request.getParameter("ids"))) {
            return AsyncResponseData.getSuccess(0);
        }
        String[] bwIds = request.getParameter("ids").split(",");
        blackwhitelistService.deleteBlackWhiteLists(new ArrayList(Arrays.asList(bwIds)));
		LogUtil.addLog("批量删除黑白名单", LogOperationType.DELETE,request);
        LOGGER.info("批量删除黑白名单 End");
        //下发黑白名单
		sendBW();
        return AsyncResponseData.getSuccess();
    }
    
    /**
     * 获取blackwhitelist对象
     *
     * @param id
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/getBlackwhitelistById")
    @ResponseBody
    public AsyncResponseData.ResultData getBlackwhitelistById(String id) throws Exception {
    	LOGGER.info("获取黑白名单 开始");
        BlackWhiteList blackWhiteList = blackwhitelistService.getBlackWhiteListById(id);

    	LOGGER.info("获取黑白名单 结束");
        return AsyncResponseData.getSuccess(blackWhiteList);
    }
	/**
	 *
	 * @param blackwhitelist
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryBlackWhiteLists", method = RequestMethod.POST)
	@ResponseBody
	public AsyncResponseData.ResultData queryBlackWhiteLists(BlackWhiteList blackwhitelist,
			int pageNum, int pageSize) throws Exception{
		LOGGER.info("获取BlackWhiteList列表 Start");
		
		Map<String, Object> filter = new HashMap<String, Object>();
		
		if (blackwhitelist.getFrequencyType() != null && blackwhitelist.getFrequencyType()>-1) {
            filter.put("frequencyType", blackwhitelist.getFrequencyType());
        }
        if (blackwhitelist.getType() != null && blackwhitelist.getType()>-1) {
            filter.put("type", blackwhitelist.getType());
        }
        if (blackwhitelist.getSource() != null && blackwhitelist.getSource()>-1) {
            filter.put("source", blackwhitelist.getSource());
        }
        PageHelper.startPage(pageNum, pageSize);
        PageInfo<BlackWhiteList> blackwhitelists = new PageInfo<BlackWhiteList>(blackwhitelistService.queryBlackWhiteListsFilter(filter));

		LOGGER.info("获取BlackWhiteList列表 End");
		
		return AsyncResponseData.getSuccess(blackwhitelists);
	}
	
	/**
     * 下载模板
     *
     * @throws Exception
     */
  	@RequestMapping(value = "/downloadBWListTemplate", method = RequestMethod.GET)
    @ResponseBody
    public void downloadBWListTemplate(HttpServletResponse response, HttpServletRequest request) throws Exception {
  		String path = BlackWhiteListController.class.getClassLoader().getResource("/template/blackWhiteTemplate.xls").getPath();
  		FileDownload.fileDownload(response, path, "blackWhiteTemplate.xls");
  	}
  	
  	 /**
     * 导出blackwhitelist列表
     *
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/exportBlackWhiteList", method = RequestMethod.GET)
    @ResponseBody
    public void exportBlackWhiteList(HttpServletResponse response, HttpServletRequest request){
        LOGGER.info("导出 黑白名单 Start");

        Map<String, Object> filter = new HashMap<String, Object>();

        String frequencyType = request.getParameter("frequencyType");
        String type = request.getParameter("type");
        String source = request.getParameter("source");

        if (StringUtils.isNotBlank(frequencyType) && !"null".equals(frequencyType)) {
            filter.put("frequencyType", frequencyType);
        }
        if (StringUtils.isNotBlank(type) && !"null".equals(type)) {
            filter.put("type", type);
        }
        if (StringUtils.isNotBlank(source) && !"null".equals(source)) {
            filter.put("source", source);
        }

        blackwhitelistService.getBlackWhiteLists(response, filter);
        LOGGER.info("导出 黑白名单 End");
    }
    
    /**
  	 * 导入blackwhitelist
  	 * @throws IOException 
  	 */
  	@RequestMapping(value = "/importBlackWhiteList", method = RequestMethod.POST)
  	@ResponseBody
  	public AsyncResponseData.ResultData importBlackWhiteList(MultipartFile file,HttpServletRequest request,HttpSession session) throws IOException{
  		if(file == null){  
            return AsyncResponseData.getLogicError("上传文件不合法");    
        }  
  		String name = file.getOriginalFilename();  
        long size = file.getSize();  
        if(name == null || ExcelUtil.EMPTY.equals(name) && size == 0){
            return AsyncResponseData.getLogicError("上传文件不合法"); 
        }  
        
        BlackWhiteList bw = null;  
        List<BlackWhiteList> listBW = new ArrayList<BlackWhiteList>();  
        try {
        	//读取Excel数据到List中  
            List<ArrayList<String>> list = new ExcelRead().readExcel(file);
            User user = LoginInterceptor.getCurrentUser();
            //list中存的就是excel中的数据，可以根据excel中每一列的值转换成你所需要的值（从0开始），如：
        	for(ArrayList<String> arr:list){  
            	bw = new BlackWhiteList();
            	boolean flag = true;
            	if(StringUtils.isNumeric(arr.get(0))) {
					bw.setFrequencyType(Integer.valueOf((arr.get(0)))); //频类 ：0-未知	1-频点  2-频段
				}else{
            		LOGGER.info("导入黑白名单,频类不能为空");
            		flag = false;
				}
            	if(StringUtils.isNumeric(arr.get(1))) {
					bw.setType(Integer.valueOf(arr.get(1))); //类型 ：0-未知  1-黑名单  2-高可疑度频段  3-中可疑度频段  4-低可疑度频段  5-白名单
				}else{
                    LOGGER.info("导入黑白名单,类型不能为空");
                    flag = false;
				}
                String mFrequency = arr.get(2);
                String sFrequency = arr.get(3);
                //黑白名单范围 100,000-1,300,000
                if(Validator.isPositiveNumber(mFrequency)){
                    int mFrequencyNum = Integer.parseInt(mFrequency) * 1000;
                    if(mFrequencyNum < 100000 || mFrequencyNum > 1300000){
                        LOGGER.info("导入黑白名单,开始频点/主频点大于1300或者小于100");
                        flag = false;
                    }else{
                        bw.setMarjorFrequency(mFrequencyNum + "");
                    }
                }else{
                    LOGGER.info("导入黑白名单,开始频点/主频点不合法");
                    flag = false;
                }
                if(Validator.isPositiveNumber(sFrequency)){
                    int sFrequencyNum = Integer.parseInt(sFrequency) * 1000;
                    if(sFrequencyNum < 100000 || sFrequencyNum > 1300000){
                        LOGGER.info("导入黑白名单,结束频点/副频点大于1300或者小于100");
                        flag = false;
                    }else{
                        bw.setSecondFrequency(sFrequencyNum + "");
                    }
                }else{
                    LOGGER.info("导入黑白名单,结束频点/副频点不合法");
                    flag = false;
                }
                if(bw.getFrequencyType() == 2){
                    //TODO 频点冲突
                    //结束频点大于开始频点
                    String mFrequencyStr = bw.getMarjorFrequency();
                    String sFrequencyStr = bw.getSecondFrequency();
                    if(StringUtils.isBlank(mFrequencyStr) || StringUtils.isBlank(sFrequencyStr)){
                        flag = false;
                    }
                    if(Integer.parseInt(mFrequencyStr) >= Integer.parseInt(sFrequencyStr)){
                        LOGGER.info("结束频点应大于开始频点");
                        flag = false;
                    }
                }

            	/*if(StringUtils.isNotEmpty(arr.get(2))) {
					bw.setMarjorFrequency(new BigDecimal(arr.get(2)).multiply(new BigDecimal("1000")).toString());  //开始频点/主频点
				}else{
                    LOGGER.info("导入黑白名单,开始频点/主频点不能为空");
                    flag = false;
				}
				if(StringUtils.isNotEmpty(arr.get(3))) {
					bw.setSecondFrequency(new BigDecimal(arr.get(3)).multiply(new BigDecimal("1000")).toString());//结束频点/副频点
				}else{
                    LOGGER.info("导入黑白名单,结束频点/副频点不能为空");
                    flag = false;
				}*/
            	/*if(StringUtils.isNumeric(arr.get(4))) {
					bw.setSource(Integer.valueOf(arr.get(4)));  //来源 0：未知、1：本地、2：平台
				}else {
				}*/
                bw.setSource(1);
                bw.setOrgId(user.getOrgId());
                bw.setCreateUser(user.getId());
                bw.setUpdateUser(user.getId());
                bw.setCreateDate(new Date());
                bw.setUpdateDate(new Date());
                bw.setId(UUIDUtil.get32UUID());
                if(flag){
                    listBW.add(bw);
                }else{
                    bw = null;
                }
            }
            /*List<BlackWhiteList> needSaveBW = new ArrayList<>();
            for(BlackWhiteList bl : listBW) {
            	bl.setId(UUIDUtil.get32UUID());   
            	needSaveBW.add(bl);
            }*/
            //判断导入的excel中的频段是否与已经存在数据库的频段存在冲突
            Map<String, Object> filter = new HashMap<>();
            filter.put("frequencyType", "2");
            List<BlackWhiteList> blackWhiteLists = blackwhitelistService.queryBlackWhiteListsFilter(filter);
            if(blackWhiteLists != null){
                for (BlackWhiteList blackWhiteList: blackWhiteLists) {
                    Integer majorFrequency = Integer.parseInt(blackWhiteList.getMarjorFrequency());
                    Integer secondFrequency = Integer.parseInt(blackWhiteList.getSecondFrequency());
                    Iterator<BlackWhiteList> iterator = listBW.iterator();
                    while(iterator.hasNext()){
                        BlackWhiteList b = iterator.next();
                        Integer majorFrequency1 = Integer.parseInt(b.getMarjorFrequency());
                        Integer secondFrequency1 = Integer.parseInt(b.getSecondFrequency());
                        if(!(majorFrequency1 > secondFrequency || secondFrequency1 < majorFrequency)){
                            iterator.remove();
                        }
                    }
                }
            }

            blackwhitelistService.insertBlackWhiteListBatch(listBW);
			LogUtil.addLog("批量导入黑白名单", LogOperationType.ADD,request);
			//下发黑白名单
			sendBW();
      		return AsyncResponseData.getSuccess("成功");
			
		} catch (OfficeXmlFileException e) {
			return AsyncResponseData.getLogicError("文件数据不合法"); 
		}
        
  	}

  	//下发黑白名单至设备
	private void sendBW(){

  	    //查看是否已连接侦测服务器
        Object flag = ParamStatic.issuedStaticMap.get(IssuedSendUtils.HEART_BREATH);
        if(flag != null && (boolean)flag){
            Map<String, Object> filter = new HashMap<String, Object>();
            //source=1 为本地数据
            //filter.put("source",1);
            List<BlackWhiteList> blackWhiteLists = blackwhitelistService.queryBlackWhiteListsFilter(filter);
            String ip = (String) ParamStatic.issuedStaticMap.get(IssuedSendUtils.DETECTION_IP);
            if(ip != null && !"".equals(ip)) {
                LOGGER.info("ip========" + ip);
                GeneralProtocol.sendBlackWhite(blackWhiteLists);
            }
        }
    }
  	
}
