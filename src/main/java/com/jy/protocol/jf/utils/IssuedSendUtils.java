package com.jy.protocol.jf.utils;

import com.jy.moudles.blackwhitelist.entity.BlackWhiteList;
import com.jy.moudles.device.entity.Device;
import com.jy.moudles.device.service.DeviceService;
import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.entity.ExamSub;
import com.jy.moudles.exam.service.ExamService;
import com.jy.moudles.reductionInfo.entity.ReductionInfo;
import com.jy.moudles.reductionInfo.service.ReductionInfoService;
import com.jy.moudles.systemConfig.constant.SystemConfigConstants;
import com.jy.moudles.systemConfig.entity.SystemConfig;
import com.jy.moudles.systemConfig.service.SystemConfigService;
import com.jy.protocol.common.constant.DeviceVender;
import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.jf.constants.JFCodeConstants;
import com.jy.protocol.jf.entity.BlackWhiteListCode;
import com.jy.protocol.jf.entity.ExamPlan;
import com.jy.protocol.jf.tcp.TcpUtil;
import com.jy.protocol.jf.udp.UdpUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import java.io.*;
import java.util.*;

/**
 * 下发工具类
 * */
public class IssuedSendUtils {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(IssuedSendUtils.class);
	private static WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
	
	//侦测UDP端口
	public static final Integer DETECTION_UDP_PORT = 6510;
	//屏蔽UDP端口
	public static final Integer SHIELD_UDP_PORT = 6610;
	//TCP端口
	public static final Integer TCP_PORT = 6600;
	
	//通用模块协议代码
	private static final String BASE_CODE = "03";
	//4G模块协议代码
	private static final String G_CODE = "04";
	
	//设备注册
	private static final String REGISTER_DEVICE = "00";
	
	public static final String SOURCE = "01";
	
	//还原文件保存地址
	//public static final String PATH = "src/main/webapp/static/reductionInfo";
	
	//侦测ip
	public static final String DETECTION_IP = "DETECTION_IP";

	//侦测设备
	public static final String DETECTION_DEVICE = "DETECTION_DEVICE";

	//屏蔽ip
	public static final String SHIELD_IP = "SHIELD_IP";
	//心跳
	public static final String HEART_BREATH = "HEART_BREATH";
	
	//心跳协议命令
	public static final String HEART_CODE = "f2";
	
	
	
	
	/**
	 * 考试下发操作
	 * */
	public static void sendExam(List<Exam> listExam,String ip,int port) {
		
		List<ExamPlan> listExamPlan = new ArrayList<ExamPlan>();
		//封装
		if(null != listExam && listExam.size() > 0) {
			for(Exam e : listExam) {
				ExamPlan examPlan = new ExamPlan();
				examPlan.setExamCode(e.getExamNo());
				List<ExamSub> listExsub = e.getExamSubList();
				if(null != listExsub && listExsub.size() > 0) {
					for(ExamSub ee : listExsub) {
						examPlan.setNumber(ee.getNo());
						examPlan.setStartDate(ee.getStartTime());
						examPlan.setEndDate(ee.getEndTime());
						examPlan.setReserved(JFCodeConstants.DEFAULT_RESERVED_CODE);
					}
				}
				listExamPlan.add(examPlan);
			}
			
		}
		//获取协议代码
		String code = AnalyzeJFOXUtils.getExamPlanCode(listExamPlan);
		
		if(!StringUtils.isBlank(code) && !StringUtils.isBlank(ip)){
			//考试信息存入缓存,在还原信号入库时方便使用
			ParamStatic.issuedStaticMap.put("currentExams", listExam);
			//下发
			UdpUtil.sendUdp(ip, port, TypeConversionUtils.hexStringToBytes(code));
			LOGGER.info("下发考试计划完成");
		}
	}
	
	
	/**
	 * 黑白名单下发操作
	 * */
	public static void sendBlackWhite(List<BlackWhiteList> listBlackWhite,String ip,int port) {
		//封装协议类
    	List<BlackWhiteListCode> blackWhiteList = new ArrayList<BlackWhiteListCode>();
    	if(null != listBlackWhite && listBlackWhite.size() > 0) {
    		for(BlackWhiteList e:listBlackWhite) {
    			BlackWhiteListCode code = new BlackWhiteListCode();
    			code.setAttribute(e.getType());
    			//起始频点
    			if(null == e.getMarjorFrequency()) {
    				code.setStartFrequency("0");
    			}else {
    				String center = e.getMarjorFrequency().toString();
    				code.setStartFrequency(center);
    			}
    			//结束频点
    			if(null == e.getSecondFrequency()) {
    				code.setEndFrequency("0");
    			}else {
    				String end = e.getSecondFrequency().toString();
    				code.setEndFrequency(end);
    			}
    			
    			
    			code.setType(e.getFrequencyType());
    			blackWhiteList.add(code);
    		}
    	}
    	String codeBW = AnalyzeJFOXUtils.getBlackWhiteList(blackWhiteList);
    	// 黑白名单下发  IP 改为获取的  192.168.15.120
		if(!StringUtils.isBlank(codeBW) && !StringUtils.isBlank(ip)){
			TcpUtil.sendTcp(ip, codeBW, port);
			LOGGER.info("下发黑白名单完成");
		}
    	
	}
	
	/**
	 * 平台注册操作
	 * @param type 0:不强制  1:强制
	 * */
	public static void registerPlatform(int type,String ip,int port) {
		String code = AnalyzeJFOXUtils.getConnectionSource(type);
		if(!StringUtils.isBlank(code)) {
			LOGGER.info("平台注册 ip:"+ip);
			TcpUtil.registerTcp(ip, code, port);
			LOGGER.info("平台注册 成功");
		}
	}
	
	/**
	 * 心跳解析
	 * */
	
	/**
	 * 屏蔽设备通用模块开启关闭
	 * @param type 1:开   0:关
	 * */
	public static void shieldControllerBase(int type,String ip,int port) {
		String code = AnalyzeJFOXUtils.getmoduleOpenOperation(BASE_CODE, type);
		UdpUtil.sendUdp(ip, port, TypeConversionUtils.hexStringToBytes(code));
		LOGGER.info("屏蔽通用模块");
	}
	
	/**
	 * 屏蔽设备4G模块开启关闭
	 * @param type 1:开   0:关
	 *
	 * */
	public static void shieldControllerPhone(int type,String ip,int port) {
		String code = AnalyzeJFOXUtils.getmoduleOpenOperation(G_CODE, type);
		UdpUtil.sendUdp(ip, port, TypeConversionUtils.hexStringToBytes(code));
		LOGGER.info("屏蔽4G模块");
	}

	
	/**
	 * 接收侦测设备信息
	 * @return 解析代码错误时 返回null
	 * */
	public static void detectionDeviceWithCode(String code,String ip) {
		if(!StringUtils.isBlank(code)) {
			if(code.length() < 68) {
				LOGGER.warn("协议代码格式有误");
			}else {
				Device device = new Device();
				//设备sn
				String sn = code.substring(20, 36);
				sn = sn.replace("4a46","JY");
				//mac地址
				String mac = code.substring(36, 48);
				mac = MacUtils.coverStringToMac(mac);
				//设备工作状态
				String status = code.substring(48, 50);
				//考试计划执行状态
				System.out.println("---------------------------" + code);
				String examPlanStatus = code.substring(50, 52);
				
				//版本
				String version_temp = code.substring(60, 76);
				StringBuilder sb = new StringBuilder();
				sb.append(version_temp.substring(1,2)).append(".")
                        .append(version_temp.substring(5,6)).append(".")
                        .append(version_temp.substring(9,10)).append(".")
                        .append(version_temp.substring(13,14));
				//TODO 版本信息内容设置错误,后期可能修改
                System.out.println("版本信息=====" + version_temp);
                device.setVersion(sb.toString());
				/*StringBuffer version = new StringBuffer();
				if(null != version_temp) {
					char[] charArray = version_temp.toCharArray();
					String sb = "";
					for(int i = 0;i < charArray.length;i++) {
						sb += charArray[i];
						if(i != 0 && i % 2 == 1 ) {
							String snum = Integer.valueOf(sb.toString(), 16)+".";
							version.append(snum);
							sb = "";
						}
					}
				}*/
                device.setVender(DeviceVender.JF);
				device.setMac(mac);
				device.setSn(sn);
				device.setType(1);
				device.setIp(ip);
				//device.setVersion(version.toString().substring(0, version.length() - 1));

				//赋值orgid
				SystemConfigService systemConfigService = context.getBean(SystemConfigService.class);
				SystemConfig systemConfig = systemConfigService.getSystemConfigByKey(SystemConfigConstants.ORGANIZATION_ID);
				if(systemConfig != null) {
					device.setOrgId(systemConfig.getSysValue());
				}
				
				if(null != status) {
					if("00".equals(status)) {
						device.setStatus(1);
					}else {
						device.setStatus(2);
					}
				}else {
					device.setStatus(0);
				}
				
				
				switch (examPlanStatus) {
					case "10":
						//无考试计划
						device.setWorkStatus(1);
						break;
					case "12":
						//考中
						device.setWorkStatus(2);
						break;
					case "13":
						//考间
						device.setWorkStatus(3);
						break;
					case "20":
						//空闲
						device.setWorkStatus(4);
						break;
					default:
						device.setWorkStatus(0);
						break;
				}
				
				//获取device对象
				DeviceService deviceService = context.getBean(DeviceService.class);
				try{
					Device deviceTemp = deviceService.getDeviceByMac(mac);
					if(null == deviceTemp) {
						device.setCreateDate(new Date());
						device.setUpdateDate(new Date());
						deviceService.insertDevice(device);
						ParamStatic.issuedStaticMap.put(DETECTION_IP, ip);
						ParamStatic.issuedStaticMap.put(DETECTION_DEVICE, device);
					}else {
						device.setUpdateDate(new Date());
						ParamStatic.issuedStaticMap.put(DETECTION_IP, ip);
						deviceService.updateDeviceByMac(device);
						ParamStatic.issuedStaticMap.put(DETECTION_DEVICE, device);
					}
				}catch (Exception e){

				}
			}
		}else {
			LOGGER.warn("未接收到协议代码");
		}
	}
	
	/**
	 * 接收屏蔽设备信息
	 * @return 解析代码错误时 返回null
	 * */
	public static void shieldDeviceWithCode(String code,String ip) {
		
		DeviceService deviceService = context.getBean(DeviceService.class);
		
		Device device = new Device();
		
		if(!StringUtils.isBlank(code)) {
			if(code.length() < 52) {
				LOGGER.warn("协议代码格式有误");
			}else {
				//设备sn
				String sn = code.substring(20, 36);
				sn = sn.replace("4a46","JY");
				//mac地址
				String mac = code.substring(36, 48);
				mac = MacUtils.coverStringToMac(mac);
				
				
				String opreation = code.substring(48,50);
				String version = code.substring(50,52);
				if(StringUtils.isNotBlank(version) && version.length() >= 2){
					device.setVersion(version.substring(0,1) + "." + version.substring(1,version.length()));
				}

                device.setVender(DeviceVender.JF);
				device.setMac(mac);
				device.setSn(sn);
				device.setType(2);
				device.setStatus(1);
				device.setIp(ip);

				//赋值orgid
				SystemConfigService systemConfigService = context.getBean(SystemConfigService.class);
	            SystemConfig systemConfig = systemConfigService.getSystemConfigByKey(SystemConfigConstants.ORGANIZATION_ID);
	            if(systemConfig != null) {
	            	device.setOrgId(systemConfig.getSysValue());
	            }
				
				switch (opreation) {
					case "00":
						device.setOperationType(1);
						break;
					case "01":
						device.setOperationType(5);
						break;
					case "02":
						device.setOperationType(3);
						break;
					case "03":
						device.setOperationType(4);
						break;
				}
				
				Device devices = deviceService.getDeviceByMac(mac);
				
				//获取device对象
				if(null == devices) {
					device.setCreateDate(new Date());
					device.setUpdateDate(new Date());
					device.setControlled(1);
					deviceService.insertDevice(device);
					ParamStatic.issuedStaticMap.put(SHIELD_IP, ip);
				}else {
					device.setUpdateDate(new Date());
					deviceService.updateDeviceByMac(device);
					ParamStatic.issuedStaticMap.put(SHIELD_IP, ip);
				}
				
			}
		}else {
			LOGGER.warn("未接收到协议代码");
		}
		
		
	}
	
	
	/**
	 * 还原文件上传 
	 */
	@SuppressWarnings("unused")
	public static void reductionFileUpload(List<String> codeList) {
	    String path = context.getServletContext().getRealPath("/") + "static/reductionInfo";
		DeviceService deviceService= context.getBean(DeviceService.class);
		ExamService examService = context.getBean(ExamService.class);
		ReductionInfoService reductionInfoService = context.getBean(ReductionInfoService.class);
		
		@SuppressWarnings("unchecked")
		List<Exam> currentExams = (List<Exam>) ParamStatic.issuedStaticMap.get("currentExams");
		Date now = new Date();
		if(currentExams == null || currentExams.isEmpty()) {
			currentExams = examService.queryCurrentExam(now);
			ParamStatic.issuedStaticMap.put("currentExams", currentExams);
		}

		//查询不到当前的考试信息,还原信号不写库
		if(currentExams != null && !currentExams.isEmpty()){
            //考试场次
            String examPlanId = "tempExamPlan";
            String examSubId = "tempExamSub";
            String examNo = examPlanId;
            String examSubNo = examSubId;

            //Exam exam = null;
            for(Exam e : currentExams) {
                if(e.getStartTime().getTime() <= now.getTime() && e.getEndTime().getTime() >= now.getTime()) {
                    examPlanId = e.getId();
                    examNo = e.getExamNo();
                    List<ExamSub> examSubs = e.getExamSubList();
                    if(examSubs != null) {
                        for(ExamSub es : examSubs) {
                            if(es.getStartTime().getTime() <= now.getTime() || es.getEndTime().getTime() >= now.getTime()) {
                                examSubId = es.getId();
                                examSubNo = es.getNo() + "";
                            }
                        }
                    }
                }
            }

            String fileName = "";
            StringBuffer sb = new StringBuffer();
            String mac = "tempMAC";

            //获取设备
            Map<String,Object> filter = new HashMap<>();
            filter.put("type", "1");
            List<Device> listDevice = deviceService.queryDevicesFilter(filter);
            if(null != listDevice && listDevice.size() > 0) {
                Device device = listDevice.get(0);
                if(null != device && StringUtils.isNotBlank(device.getMac())) {
                    mac = device.getMac();
                }
            }
            String filePath = path + File.separator + mac;
            String fileAddr = "static/reductionInfo" + File.separator + mac;
            File dir1 = new File(filePath);
            if(!dir1.exists()) {
                dir1.mkdir();
            }

            ReductionInfo reductionInfo = new ReductionInfo();
            //考试计划文件夹
            filePath += File.separator + examNo;
            fileAddr += File.separator + examNo;
            File dir2 = new File(filePath);
            if(!dir2.exists()) {
                dir2.mkdir();
            }
            //考试场次文件夹
            filePath += File.separator + examSubNo;
            fileAddr += File.separator + examSubNo;
            File dir3 = new File(filePath);
            if(!dir3.exists()) {
                dir3.mkdir();
            }
            //解析帧头
            if(null != codeList && codeList.size() > 0) {

                for(int i = 0;i<codeList.size();i++) {
                    if(i==0) {
                        String codeReturn = codeList.get(i);

                        fileName += new Date().getTime() + "";

                        //频点
                        String frequency = codeReturn.substring(20, 28);
                        frequency = TimeUtils.reverseHex(frequency);
                        frequency = Long.valueOf(frequency, 16)+"hz";
                        fileName += "_"+frequency;

                        //强度
                        String power = codeReturn.substring(28, 30);
                        power = TypeConversionUtils.hexStringToBytes(power)[0]+"dbm";
                        fileName += "_"+power;
                        //采样率
                        String collection = codeReturn.substring(30, 38);
                        collection = TimeUtils.reverseHex(collection);
                        collection = Long.valueOf(collection, 16)+"hz";
                        fileName += "_"+collection;
                        //文件类型
                        String signalTypeString = codeReturn.substring(38,40);
                        if("00".equals(signalTypeString)) {
                            fileName += ".wav";
                            reductionInfo.setSuffix("wav");
                            reductionInfo.setSignalType(1);
                            reductionInfo.setRecognitionResult(0);
                            reductionInfo.setFileAddr(fileAddr + File.separator+fileName);
                            reductionInfo.setFileName(fileName);
                        }else {
                            fileName += ".txt";
                            reductionInfo.setSuffix("txt");
                            reductionInfo.setSignalType(2);
                            reductionInfo.setRecognitionResult(1);
                            reductionInfo.setFileAddr(fileAddr + File.separator+fileName);
                            reductionInfo.setFileName(fileName);
                            System.out.println(fileName);
                        }
                        //还原结果
                        String returnResult = codeReturn.substring(40, 80);

                        //数据流大小
                        String fileSize = codeReturn.substring(80, 88);
                        fileSize = TimeUtils.reverseHex(fileSize);
                        fileSize = Long.valueOf(fileSize, 16)+"";

                        reductionInfo.setFrequency(frequency);
                        reductionInfo.setDb(power);
                        reductionInfo.setReductionTime(now);
                        reductionInfo.setCreateDate(now);
                        reductionInfo.setUpdateDate(now);
                        reductionInfo.setExamPlanId(examPlanId);
                        reductionInfo.setExamNumberId(examSubId);
                        //赋值orgid
                        SystemConfigService systemConfigService = context.getBean(SystemConfigService.class);
                        SystemConfig systemConfig = systemConfigService.getSystemConfigByKey(SystemConfigConstants.ORGANIZATION_ID);
                        if(systemConfig != null) {
                            reductionInfo.setOrgId(systemConfig.getSysValue());
                        }
                        reductionInfoService.insertReductionInfo(reductionInfo);

                        sb.append(codeReturn.substring(88));
                    }else {
                        String code = codeList.get(i);
                        sb.append(code);
                    }
                }

            }

            byte[] b = TypeConversionUtils.hexStringToBytes(sb.toString());

            BufferedOutputStream bos = null;
            FileOutputStream fos = null;
            File file = null;
            file = new File(filePath + File.separator + fileName);
            try {
                fos = new FileOutputStream(file);
                bos = new BufferedOutputStream(fos);
                bos.write(b);
            } catch (FileNotFoundException e) {
                System.out.println(fileName);
                System.out.println("error");
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                try {
                    if(bos != null) {
                        bos.close();
                    }
                    if(fos != null) {
                        fos.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }else{
		    LOGGER.info("---------------------当前查询不到考试信息");
        }

	}

	
}