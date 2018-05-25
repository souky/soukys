package com.jy.moudles.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.common.utils.FileToZip;
import com.jy.common.utils.LogUtil;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.device.entity.Device;
import com.jy.moudles.device.service.DeviceService;
import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.entity.ExamAfterData;
import com.jy.moudles.exam.entity.ExamSub;
import com.jy.moudles.exam.service.ExamAfterDataService;
import com.jy.moudles.exam.service.ExamService;
import com.jy.moudles.exam.service.ExamSubService;
import com.jy.moudles.systemLog.constants.LogOperationType;
import com.jy.moudles.user.entity.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wb on 2017/10/22.
 */
@Controller
@RequestMapping(value="/examAfterData")
public class ExamAfterDataController {

    @Autowired
    private ExamAfterDataService examAfterDataService;

    @Autowired
    private ExamService examService;

    @Autowired
    private ExamSubService examSubService;
    
    @Autowired
    private DeviceService deviceService;

    private static final Logger LOGGER = LoggerFactory.getLogger(ExamAfterDataController.class);

    //打包文件数量
    private static int count = 0;

    /**
     * examAfterData
     *
     * @param examAfterData
     * @throws Exception
     */
    @RequestMapping(value = "/savePackageInfo", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData savePackageInfo(ExamAfterData examAfterData, HttpServletRequest request) throws Exception {
        LOGGER.info("新增打包开始");
        Date startTime = new Date();
        String examPlanId = examAfterData.getExamPlanId();
        String examNumberId = examAfterData.getExamNumberId();
        if (examPlanId == null || "".equals(examPlanId)) {
            return AsyncResponseData.getSuccess().asParamError("考试信息不能为空");
        }
        List<Exam> examList = examService.queryExamById(examPlanId);
        if (examList != null && examList.isEmpty()) {
            return AsyncResponseData.getSuccess().asParamError("考试信息不能为空");
        }
        String examName = examList.get(0).getExamName();

        //文件存储路径
        //文件存储项目中的位置,基础路径
        String _filePath = request.getServletContext().getRealPath("/") + "static/reductionInfo/";
        String filePath = _filePath;
        String examSubName = "";
        //String examSubNo = "";
        
        //查询设备信息
        Map<String, Object> filter = new HashMap<>();
        filter.put("type", "1");
        List<Device> devices = deviceService.queryDevicesFilter(filter);
        String mac = null;
        if(devices != null && devices.size() > 0) {
        	mac = devices.get(0).getMac();
        	filePath +=  mac + "/";
        }
        
        filePath += examList.get(0).getExamNo() + "/";
        //若场次为空,查询符合考试计划的所有内容
        if (examNumberId == null || "".equals(examNumberId)) {
        	//路径为 filePath + 设备mac地址  + 考试编号
            //filePath +=  "考试编号" + "/";
            examSubName = "全部考试场次";
        } else {
            ExamSub examSub = examSubService.getExsubById(examNumberId);
            if (examSub == null) {
                return AsyncResponseData.getSuccess().asParamError("参数错误");
            }
            examSubName = examSub.getName();
            //路径为 filePath + 设备mac地址  + 考试编号 + 考试场次编号 
            filePath += examSub.getNo() + "/";
            //examSubNo = examSub.getNo() + "";
        }


        //判断需要打包的文件夹是否存在
        File file = new File(filePath);
        if (file != null && (!file.exists()) || file.listFiles().length < 1) {
            return AsyncResponseData.getSuccess().asParamError("查询不到需要打包的文件");
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String fileName = examName + "_" + examSubName + "_" + sdf.format(startTime) + ".zip";
        // _filePath + fileName
        String fileAddress = request.getServletContext().getRealPath("/") + "static/sftpDownload/";
        FileToZip.fileToZip(filePath, fileAddress + fileName);

        examAfterData.setId(UUIDUtil.get32UUID());
        examAfterData.setStartTime(startTime);
        examAfterData.setFileName(fileName);
        examAfterData.setFileAddress(fileAddress + fileName);

        int fileNumbers = getFile(filePath);
        examAfterData.setFileNumbers(fileNumbers);
        File file1 = new File(fileAddress + fileName);
        long fileSize = 0;
        if (file1.exists() && file1.isFile()) {
            fileSize = file1.length();
        }
        if (fileSize >= Long.MAX_VALUE) {
            return AsyncResponseData.getSuccess().asParamError("压缩文件太大,暂时无法压缩");
        }
        examAfterData.setFileSize(fileSize);
        //字节流存储
        byte[] data = fileToByte(file1);
        examAfterData.setFileByte(data);

        examAfterData.setFileType("zip");
        examAfterData.setEndTime(new Date());
        examAfterData.setCreateDate(new Date());
        User user = LoginInterceptor.getCurrentUser();
        if (user != null) {
            examAfterData.setCreateUser(user.getId());
            examAfterData.setOrgId(user.getOrgId());
        }

        examAfterDataService.insertExamAfterData(examAfterData);
        LogUtil.addLog("新增打包信息", LogOperationType.ADD,request);
        LOGGER.info("新增打包结束");
        return AsyncResponseData.getSuccess();
    }

    /**
     * examAfterData
     *
     * @param examAfterData
     * @throws Exception
     */
    @RequestMapping(value = "/deletePackageInfo", method = RequestMethod.POST)
    @ResponseBody
    public AsyncResponseData.ResultData deletePackageInfo(ExamAfterData examAfterData,HttpServletRequest request) throws Exception{
        LOGGER.info("删除打包开始");

        if(examAfterData != null){
            examAfterData = examAfterDataService.getExamAfterDataById(examAfterData.getId());
            String fileAddress = examAfterData.getFileAddress();
            if(fileAddress != null){
                File file = new File(fileAddress);
                if(file.exists()){
                    file.delete();
                }
            }
            examAfterDataService.deleteExamAfterDataById(examAfterData.getId());
            LogUtil.addLog("删除打包信息", LogOperationType.DELETE,request);
        }

        LOGGER.info("删除打包结束");
        return AsyncResponseData.getSuccess();
    }

    @RequestMapping(value = "/packageInfo", method = RequestMethod.POST)
    public ModelAndView queryPackageInfos(ExamAfterData examAfterData) throws Exception{
        ModelAndView mv = new ModelAndView();
        mv.setViewName("exam/packageInfo");
        return mv;
    }

    /**
     * examAfterData
     *
     * @param examAfterData
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/packageInfoPost", method = RequestMethod.POST)
    public ModelAndView packageInfoPost(HttpServletRequest request,ExamAfterData examAfterData,int pageNum,int pageSize) throws Exception{
        LOGGER.info("获取打包开始");
        ModelAndView mv = new ModelAndView();
        Map<String, Object> filter = new HashMap<String, Object>();
        PageHelper.startPage(pageNum, pageSize);
        List<ExamAfterData> examAfterDatas = examAfterDataService.queryExamAfterDatasFilter(filter);
        PageInfo<ExamAfterData> packageinfoList = new PageInfo<>(examAfterDatas);
        LOGGER.info("获取打包结束");
        for(ExamAfterData e : examAfterDatas){
            String examPlanId = e.getExamPlanId();
            List<Exam> examList = examService.queryExamById(examPlanId);
            if(examList != null && examList.size() > 0){
                e.setExamName(examList.get(0).getExamName());
            }

            String examNumberId = e.getExamNumberId();
            ExamSub examSub = examSubService.getExsubById(examNumberId);
            if(examSub != null){
                e.setExamSubName(examSub.getName() + "-" + examSub.getNo());
            }

        }
        mv.addObject("packageinfoList", examAfterDatas);
        mv.addObject("pageNow", packageinfoList.getPageNum());
        mv.addObject("pageTotal", packageinfoList.getPages());
        //传入basePath
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
        mv.addObject("basePath",basePath);
        mv.setViewName("exam/post/packageInfoPost");
        return mv;
    }

    /**
     * 下载打包
     * @param id
     * @return
     */
    @RequestMapping(value = "/downloadPackage", method = RequestMethod.GET)
    public void downloadPackage(HttpServletResponse response,String id) throws IOException{
        if(id != null && !"".equals(id)){
            ExamAfterData examAfterData = examAfterDataService.getExamAfterDataById(id);
            if (examAfterData != null) {
            	InputStream is = new FileInputStream(examAfterData.getFileAddress());
            	OutputStream out = response.getOutputStream();
                try {
                    response.reset();
                    response.setContentType("application/octet-stream; charset=utf-8");
                    response.setHeader("Content-Disposition", "attachment; filename=" + examAfterData.getFileName());
                    byte[] b = new byte[1024];
                    int len;
                    while((len = is.read(b)) > 0){
                    	//TODO IOEXCEPTION 
                        out.write(b,0,len);
                        out.flush();
                    }
                    
                }catch(FileNotFoundException e){
                    e.printStackTrace();
                }catch(IOException ioe){
                    ioe.printStackTrace();
                }finally {
                	if(out != null) {
                		out.close();
                	}
                	if(is != null) {
                		is.close();
                	}
                }

            }
        }


    }



    //--------------------------------------------------------------------
    //获取文件夹中文件数量
    private static int getFile(String filepath) {
        int num = count;
        File file = new File(filepath);
        File[] listfile = file.listFiles();
        for (int i = 0; i < listfile.length; i++) {
            if (!listfile[i].isDirectory()) {
                count++;
                //String temp=listfile[i].toString().substring(7,listfile[i].toString().length()) ;
                //System.out.println("文件"+count+"---path=" + listfile[i]);
            } else {
                getFile(listfile[i].toString());
            }
        }
        return count - num;
    }

    //将文件保存到字节数组中
    private static byte[] fileToByte(File file) throws IOException {
        @SuppressWarnings("resource")
		InputStream inputStream = new FileInputStream(file);
        ByteArrayOutputStream bAOutputStream = new ByteArrayOutputStream();
        int ch;
        while ((ch = inputStream.read()) != -1) {
            bAOutputStream.write(ch);
        }
        byte[] data = bAOutputStream.toByteArray();
        bAOutputStream.close();
        return data;
    }


}