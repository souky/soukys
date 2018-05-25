package com.jy.common.kafka.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jy.common.kafka.producer.JyKafkaProducer;
import com.jy.moudles.blackwhitelist.entity.BlackWhiteList;
import com.jy.moudles.blackwhitelist.service.BlackWhiteListService;
import com.jy.moudles.device.entity.Device;
import com.jy.moudles.device.service.DeviceService;
import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.entity.ExamSub;
import com.jy.moudles.exam.entity.ExamType;
import com.jy.moudles.exam.service.ExamService;
import com.jy.moudles.exam.service.ExamSubService;
import com.jy.moudles.exam.service.ExamTypeService;
import com.jy.moudles.reductionInfo.entity.ReductionInfo;
import com.jy.moudles.reductionInfo.service.ReductionInfoService;
import org.apache.commons.lang3.StringUtils;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.listener.MessageListener;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.alibaba.fastjson.JSON;
import com.jy.moudles.organization.entity.Organization;
import com.jy.moudles.organization.service.OrganizationService;

/**
 * kafka监听器启动
 * 自动监听是否有消息需要消费
 * @author wb
 *
 */
public class KafkaConsumerServer implements MessageListener<String, String> {
	protected final Logger logger = LoggerFactory.getLogger(KafkaConsumerServer.class);

	/**
	 * 监听器自动执行该方法
	 * 	消费消息
	 * 	自动提交offset
	 * 	执行业务代码
	 * 	（high level api 不提供offset管理，不能指定offset进行消费）
	 */
	@Override
	public void onMessage(ConsumerRecord<String, String> record) {

        logger.info("=============kafka start to Consumer message=============");
		WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
		Map<String, Object> filter = new HashMap<>();


		String value = record.value();
		String [] keys = record.key().split(",");
		//根据key判断消费类型
		//1.上级消费来自下级消息
		//同步组织机构
		OrganizationService organizationService = context.getBean(OrganizationService.class);
		if("organization".equals(keys[0])){
			Organization org = JSON.parseObject(value, Organization.class);
			//
			Organization organization = organizationService.getOrganizationById(org.getId());
			if(organization == null){
				organizationService.insertOrganization(org);
			}else{
				organizationService.updateOrganization(org);
			}

		}

		//同步还原信号
        ReductionInfoService reductionInfoService = context.getBean(ReductionInfoService.class);
		if("reductionInfo".equals(keys[0])){
            if("add".equals(keys[1])){
                ReductionInfo reductionInfo = JSON.parseObject(value, ReductionInfo.class);
                reductionInfoService.insertReductionInfo(reductionInfo);
            }else if("addList".equals(keys[1])){
		        List<ReductionInfo> reductionInfoList = JSON.parseArray(value,ReductionInfo.class);
                reductionInfoService.insertReductionInfosBatch(reductionInfoList);
            }else if("deleteAll".equals(keys[1])){
                filter = buildMapFilter(keys,filter);
                reductionInfoService.deleteReductionInfosByKafka(filter);
            }else if("deleteAndAdd".equals(keys[1])){
                filter = buildMapFilter(keys,filter);
                reductionInfoService.deleteReductionInfosByKafka(filter);
                List<ReductionInfo> reductionInfoList = JSON.parseArray(value,ReductionInfo.class);
                reductionInfoService.insertReductionInfosBatch(reductionInfoList);
            }
		}

		//同步设备
        DeviceService deviceService = context.getBean(DeviceService.class);
		if("device".equals(keys[0])){
			List<Device> deviceList = JSON.parseArray(value, Device.class);
            filter = buildMapFilter(keys,filter);
			deviceService.deleteDevicesByKafka(filter);
			deviceService.insertDevicesBatch(deviceList);
		}

		//同步黑白名单
		BlackWhiteListService blackWhiteListSerice = context.getBean(BlackWhiteListService.class);
		if("blackWhite".equals(keys[0])){
			if("addList".equals(keys[1])){
                List<BlackWhiteList> blackWhiteList = JSON.parseArray(value, BlackWhiteList.class);
                blackWhiteListSerice.insertBlackWhiteListBatch(blackWhiteList);
			}else if("deleteAll".equals(keys[1])){
                filter = buildMapFilter(keys,filter);
                blackWhiteListSerice.deleteBWsByKafka(filter);
            }else if("deleteAndAdd".equals(keys[1])){
                filter = buildMapFilter(keys,filter);
                blackWhiteListSerice.deleteBWsByKafka(filter);
                List<BlackWhiteList> blackWhiteList = JSON.parseArray(value, BlackWhiteList.class);
                blackWhiteListSerice.insertBlackWhiteListBatch(blackWhiteList);
            }
			
		}

		//同步考试计划
		ExamService examService = context.getBean(ExamService.class);
		if("exam".equals(keys[0])){
            if("add".equals(keys[1])){
                Exam exam = JSON.parseObject(value, Exam.class);
                examService.addExam(exam);
            }else if("update".equals(keys[1])){
                Exam exam = JSON.parseObject(value, Exam.class);
				examService.updateExam(exam);
            }else if("delete".equals(keys[1])){
                //String id = JSON.parseObject(value, String.class);
                examService.deleteExamById(value);
            }else if("deleteList".equals(keys[1])){
                List<String> ids = JSON.parseArray(value, String.class);
                examService.deleteExams(ids);
            }else if("deleteAndAdd".equals(keys[1])){
                filter = buildMapFilter(keys,filter);
                examService.deleteExamByKafka(filter);
                List<Exam> exams = JSON.parseArray(value,Exam.class);
                examService.insertExamBatch(exams);
            }
        }
        //同步考试类型
        ExamTypeService examTypeService = context.getBean(ExamTypeService.class);
        if("examType".equals(keys[0])){
            if("add".equals(keys[1])){
                ExamType examType = JSON.parseObject(value, ExamType.class);
                examTypeService.insertExamType(examType);
            }else if("update".equals(keys[1])){
                ExamType examType = JSON.parseObject(value, ExamType.class);
                examTypeService.updateExamType(examType);
            }else if("delete".equals(keys[1])){
                String id = JSON.parseObject(value, String.class);
                examTypeService.deleteExamTypeById(id);
            }else if("deleteList".equals(keys[1])){
                List<String> ids = JSON.parseArray(value, String.class);
                examTypeService.deleteExamTypes(ids);
            }else if("deleteAndAdd".equals(keys[1])){
                filter = buildMapFilter(keys,filter);
                examTypeService.deleteExamTypeBykafka(filter);
                List<ExamType> examTypes = JSON.parseArray(value,ExamType.class);
                examTypeService.insertExamTypeBatch(examTypes);
            }
        }
        //同步考试场次
        ExamSubService examSubService = context.getBean(ExamSubService.class);
        if("examSub".equals(keys[0])){
            if("add".equals(keys[1])){
                ExamSub examSub = JSON.parseObject(value, ExamSub.class);
                examSubService.insertExsub(examSub);
            }else if("update".equals(keys[1])){
                ExamSub examSub = JSON.parseObject(value, ExamSub.class);
                examSubService.updateExsub(examSub);
            }else if("delete".equals(keys[1])){
                String id = JSON.parseObject(value, String.class);
                examSubService.deleteExsubById(id);
            }else if("deleteAndAdd".equals(keys[1])){
                filter = buildMapFilter(keys,filter);
                examSubService.deleteExamSubBykafka(filter);
                List<ExamSub> examSubs = JSON.parseArray(value,ExamSub.class);
                examSubService.insertExsubBatch(examSubs);
            }
        }

		//2.下级消费来自上级消息
        if("check_data".equals(keys[0])){
        	
            String orgId = keys[2];
            Organization upperOrganization = null;
            Organization organization = organizationService.getOrganizationById(orgId);
        	if(organization == null) {
        		logger.info("cannot get current Organization");
                return;
        	}
        	
        	upperOrganization = organizationService.getOrganizationById(organization.getParentId());
            if(upperOrganization == null || StringUtils.isBlank(upperOrganization.getIp())){
                logger.info("cannot get upperOrganization");
                return;
            }
        	
            String ip = upperOrganization.getIp();
            String address = ip + ":" + JyKafkaProducer.KAFKA_PORT;

            @SuppressWarnings("unchecked")
			Map<String,Integer> amountMap = JSON.parseObject(value,Map.class);
            String lastTime = keys[3];
            String currentTime = keys[4];
            if(amountMap != null){
                filter.clear();
                filter.put("orgId",orgId);
                filter.put("lastTime",lastTime);
                filter.put("currentTime",currentTime);
                List<Device> devices = deviceService.queryDevicesFilter(filter);
                List<BlackWhiteList> blackWhiteLists = blackWhiteListSerice.queryBlackWhiteListsFilter(filter);
                List<ReductionInfo> reductionInfos = reductionInfoService.queryReductionInfosFilter(filter);
                List<Exam> exams = examService.queryExamFilter(filter);
                List<ExamType> examTypes = examTypeService.queryExamTypesFilter(filter);
                List<ExamSub> examSubs = examSubService.queryExsubsFilter(filter);
                //下级数量不等于上级数量时,删除上级,同步下级
                //设备
                if(devices != null && devices.size() != amountMap.get("device")){
                    String app = "device,deleteAndAdd," + orgId;
                    new JyKafkaProducer(address).send(app, JSON.toJSONString(devices));
                }
                //黑白名单
                if(blackWhiteLists != null && blackWhiteLists.size() != amountMap.get("blackWhiteList")){
                    String app = "blackWhiteList,deleteAndAdd," + orgId;
                    int i = 0;
                    if(blackWhiteLists.size()/1000 > 0){
                        for(;i < blackWhiteLists.size();i++){
                            List<BlackWhiteList> bwSubList = blackWhiteLists.subList(1000 * i, 1000 * (i + 1));
                            new JyKafkaProducer(address).send(app, JSON.toJSONString(bwSubList));
                        }
                    }
                    if(blackWhiteLists.size()%1000 != 0){
                        List<BlackWhiteList> bwSubList = blackWhiteLists.subList(1000 * i, blackWhiteLists.size());
                        new JyKafkaProducer(address).send(app, JSON.toJSONString(bwSubList));
                    }
                    if(blackWhiteLists.size() == 0){
                        app = "blackWhiteList,deleteAll," + orgId;
                        new JyKafkaProducer(address).send(app, JSON.toJSONString(blackWhiteLists));
                    }
                }
                //还原信号
                if(reductionInfos != null && reductionInfos.size() != amountMap.get("reductionInfo")){
                    String app = "reductionInfo,deleteAndAdd," + orgId;
                    int i = 0;
                    if(reductionInfos.size()/1000 > 0){
                        for(;i < reductionInfos.size();i++){
                            List<ReductionInfo> subList = reductionInfos.subList(1000 * i, 1000 * (i + 1));
                            new JyKafkaProducer(address).send(app, JSON.toJSONString(subList));
                        }
                    }
                    if(reductionInfos.size()%1000 != 0){
                        List<ReductionInfo> subList = reductionInfos.subList(1000 * i, reductionInfos.size());
                        new JyKafkaProducer(address).send(app, JSON.toJSONString(subList));
                    }
                    if(reductionInfos.size() == 0){
                        app = "reductionInfo,deleteAll," + orgId;
                        new JyKafkaProducer(address).send(app, JSON.toJSONString(reductionInfos));
                    }
                }
                //考试计划
                if(exams != null && exams.size() != amountMap.get("exam")){
                    String app = "exam,deleteAndAdd," + orgId;
                    new JyKafkaProducer(address).send(app, JSON.toJSONString(exams));
                }
                //考试类型
                if(examTypes != null && examTypes.size() != amountMap.get("examType")){
                    String app = "examType,deleteAndAdd," + orgId;
                    new JyKafkaProducer(address).send(app, JSON.toJSONString(examTypes));
                }
                //考试场次
                if(examSubs != null && examSubs.size() != amountMap.get("examSub")){
                    String app = "examSub,deleteAndAdd," + orgId;
                    new JyKafkaProducer(address).send(app, JSON.toJSONString(examSubs));
                }
            }
        }
//		//组织机构
//		if("org_sync".equals(keys[0])){
//			List<Organization> orgList = JSON.parseArray(value, Organization.class);
//			//本地组织机构
//			List<Organization> orgListLocal = organizationService.queryOrganizationsFilter(null);
//			List<String> orgIdList = new ArrayList<>();
//			for(Organization orgLocal : orgListLocal){
//				orgIdList.add(orgLocal.getId());
//			}
//			for(Organization org : orgList){
//				if(!orgIdList.contains(org.getId())){
//					organizationService.insertOrganization(org);
//				}else{
//					organizationService.updateOrganization(org);
//				}
//			}
//		}


		String topic = record.topic();
		String key = record.key();
		//long offset = record.offset();
		//int partition = record.partition();
		logger.info("-------------topic:" + topic);
		//logger.info("-------------value:"+value);
		logger.info("-------------key:" + key);
		//logger.info("-------------offset:"+offset);
		//logger.info("-------------partition:"+partition);
		logger.info("=============kafka Consumer message end=============");
	}

	//
    private Map<String,Object> buildMapFilter(String [] keys,Map<String,Object> filter){
	    if(filter != null && keys.length > 4){
            filter.clear();
            String orgId = keys[2];
            String lastTime = keys[3];
            String currentTime = keys[4];
            filter.put("orgId",orgId);
            filter.put("lastTime",lastTime);
            filter.put("currentTime",currentTime);
        }
	    return filter;
    }

}
