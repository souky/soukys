package com.jy.moudles.communicationCheck.controller;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.LogUtil;
import com.jy.moudles.device.service.DeviceService;
import com.jy.moudles.exam.service.ExamAfterDataService;
import com.jy.moudles.exam.service.ExamService;
import com.jy.moudles.exam.service.ExamSubService;
import com.jy.moudles.exam.service.ExamTypeService;
import com.jy.moudles.reductionInfo.service.ReductionInfoService;
import com.jy.moudles.systemLog.constants.LogOperationType;
import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.jf.utils.IssuedSendUtils;
import com.jy.protocol.jf.utils.ThreadSwitchUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

/**
 * Created by wb on 2017/10/31.
 */
@Controller
@RequestMapping("paramConfig")
public class ParamConfigController {

    private static final Logger LOGGER = LoggerFactory.getLogger(ParamConfigController.class);

    @Autowired
    private ExamService examService;

    @Autowired
    private ExamSubService exsubService;

    @Autowired
    private ReductionInfoService reductioninfoService;

    @Autowired
    private ExamAfterDataService examAfterDataService;

    @Autowired
    private ExamTypeService examTypeService;

    @Autowired
    private DeviceService deviceService;
    
    /**
     * 连接/关闭服务
     * @param request
     * @param status
     * @return
     */
    @RequestMapping(value = "/connectServer", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData connectServer(HttpServletRequest request, int status){
    	if(status == 0){//断开连接
            LOGGER.info("平台断开与侦测的连接");
            ThreadSwitchUtils.closeServerThread();
            try {
                Thread.sleep(4000);
            } catch (InterruptedException e) {
                e.printStackTrace();
                return AsyncResponseData.getSuccess().asParamError("网络错误");
            }
            Object obj = ParamStatic.issuedStaticMap.get(IssuedSendUtils.HEART_BREATH);
            if(obj != null && !(boolean)obj){
                return AsyncResponseData.getSuccess();
            }
    	}else if(status  == 1) {//开始连接
            LOGGER.info("平台开始与侦测进行连接");
    		ThreadSwitchUtils.startServerThread();
            try {
                Thread.sleep(7000);
            } catch (InterruptedException e) {
                e.printStackTrace();
                return AsyncResponseData.getSuccess().asParamError("网络错误");
            }
            Object obj = ParamStatic.issuedStaticMap.get(IssuedSendUtils.HEART_BREATH);
            if(obj != null && (boolean)obj){
                return AsyncResponseData.getSuccess();
            }
    	}
    	
    	return AsyncResponseData.getSuccess().asParamError("操作失败");
    }
    
    /**
     * 获取当前是否连接
     * @param request
     * @return
     */
    @RequestMapping(value = "/getConnectStatus", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData getConnectStatus(HttpServletRequest request){
    	
    	Object heartBreath = ParamStatic.issuedStaticMap.get(IssuedSendUtils.HEART_BREATH);
    	boolean returnStr = false;
    	if(heartBreath != null) {
    		returnStr = (boolean)heartBreath;
    	}
    	return AsyncResponseData.getSuccess(returnStr);
    }

    @RequestMapping(value = "/clearDataBeforeExam", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData clearDataBeforeExam(HttpServletRequest request){
        LOGGER.info("开始清理数据");
        exsubService.clearExamSubData();
        examService.clearExamData();
        reductioninfoService.clearReductionInfoData();
        examAfterDataService.clearExamAfterData();
        examTypeService.clearExamType();
        deviceService.clearDeviceData();

        //清理还原信号源文件
        LOGGER.info("清理还原信号源文件");
        String path = request.getServletContext().getRealPath("/");
        File file = new File(path + "static/reductionInfo");
        if(file != null && file.exists()){
            deleteAllFilesOfDir(file);
            file.mkdir();
        }
        //删除本地试听的文件和打包的文件
        File fileDownload = new File(path + "static/sftpDownload");
        if(fileDownload != null && fileDownload.exists()){
            deleteAllFilesOfDir(fileDownload);
            fileDownload.mkdir();
        }

        LogUtil.addLog("清理考试场次数据", LogOperationType.DELETE, request);
        LogUtil.addLog("清理考试计划数据", LogOperationType.DELETE, request);
        LogUtil.addLog("清理还原信号数据", LogOperationType.DELETE, request);
        LogUtil.addLog("清理考后打包数据", LogOperationType.DELETE, request);
        LogUtil.addLog("清理考试类型数据", LogOperationType.DELETE, request);
        LogUtil.addLog("清理设备数据", LogOperationType.DELETE, request);
        LOGGER.info("清理数据结束");
        return AsyncResponseData.getSuccess("清理成功");
    }

    //删除文件
    private static void deleteAllFilesOfDir(File path) {
        if (path == null || !path.exists()){
            return;
        }
        if (path.isFile()) {
            path.delete();
            return;
        }
        File[] files = path.listFiles();
        for (int i = 0; i < files.length; i++) {
            deleteAllFilesOfDir(files[i]);
        }
        path.delete();
    }

}
