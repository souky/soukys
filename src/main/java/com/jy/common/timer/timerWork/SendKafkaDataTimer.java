package com.jy.common.timer.timerWork;

import com.alibaba.fastjson.JSON;
import com.jy.common.kafka.producer.JyKafkaProducer;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.blackwhitelist.entity.BlackWhiteList;
import com.jy.moudles.blackwhitelist.service.BlackWhiteListService;
import com.jy.moudles.device.entity.Device;
import com.jy.moudles.device.service.DeviceService;
import com.jy.moudles.kafka.entity.KafkaSync;
import com.jy.moudles.kafka.service.KafkaSyncService;
import com.jy.moudles.organization.entity.Organization;
import com.jy.moudles.organization.service.OrganizationService;
import com.jy.moudles.reductionInfo.entity.ReductionInfo;
import com.jy.moudles.reductionInfo.service.ReductionInfoService;
import com.jy.moudles.systemConfig.constant.SystemConfigConstants;
import com.jy.moudles.systemConfig.entity.SystemConfig;
import com.jy.moudles.systemConfig.service.SystemConfigService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.util.*;

/**
 * Created by wb on 2017/11/10.
 */
public class SendKafkaDataTimer {

    private static final Logger logger = LoggerFactory.getLogger(SendKafkaDataTimer.class);

    private ApplicationContext context;

    public SendKafkaDataTimer(ApplicationContext context) {
        this.context = context;
    }

    public void start(){
        logger.info("START KAFKA TIMER");
        Timer timer = new Timer();
        //schedule(TimerTask task, long delay, long period)  延迟delay毫秒执行定时任务
        //考试相关,只在项目启动时执行一次同步
        //下级向上级发送
        timer.schedule(new SendDataToUpper(), 1000 * 10, (1000 * 60 * 5));

        Timer timer1 = new Timer();
        //上级向下级发送
        timer1.schedule(new SendDataToLower(), 1000 * 100, (1000 * 60 * 10));
    }

    /**
     * 下级向发送
     */
    class SendDataToUpper extends TimerTask {
        @Override
        public void run() {
            logger.info("KAFKA TIMER STARTED");
            Date currentTime = new Date();
            //若存在上级且上级ip不为空,则向上级发送消息
            OrganizationService organizationService = context.getBean(OrganizationService.class);
            SystemConfigService systemConfigService = context.getBean(SystemConfigService.class);
            SystemConfig systemConfig = systemConfigService.getSystemConfigByKey(SystemConfigConstants.ORGANIZATION_ID);
            String orgId = null;
            if(systemConfig != null) {
            	orgId = systemConfig.getSysValue();
            }
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

            DeviceService deviceService = context.getBean(DeviceService.class);
            BlackWhiteListService blackWhiteListService = context.getBean(BlackWhiteListService.class);
            ReductionInfoService reductionInfoService = context.getBean(ReductionInfoService.class);

            //获取上次同步时间
            KafkaSyncService kafkaSyncService = context.getBean(KafkaSyncService.class);
            KafkaSync kafkaSync = null;
            Date lastTime;
            Map<String, Object> filter = new HashMap<>();
            filter.clear();

            //同步设备
            List<Device> devices = deviceService.queryDevicesFilter(filter);
            if(devices != null && !devices.isEmpty()){
                String app = "device,addList," + organization.getId();
                new JyKafkaProducer(address).send(app, JSON.toJSONString(devices));
                kafkaSync = new KafkaSync();
                kafkaSync.setId(UUIDUtil.get32UUID());
                kafkaSync.setTime(currentTime);
                kafkaSync.setType("device");
                kafkaSync.setDataId(devices.get(devices.size() - 1).getId());
                kafkaSyncService.addKafkaSync(kafkaSync);
            }

            //同步黑白名单
            lastTime = kafkaSyncService.queryMaxTimeByType("blackWhiteList");
            filter.clear();
            filter.put("lastTime",lastTime);
            filter.put("currentTime",currentTime);
            List<BlackWhiteList> blackWhiteLists = blackWhiteListService.queryBlackWhiteListsFilter(filter);
            if(blackWhiteLists != null && blackWhiteLists.size() > 0){
                int i = 0;
                String app = "blackWhite,addList," + organization.getId();
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

                kafkaSync = new KafkaSync();
                kafkaSync.setId(UUIDUtil.get32UUID());
                kafkaSync.setTime(currentTime);
                kafkaSync.setType("blackWhiteList");
                kafkaSync.setDataId(blackWhiteLists.get(blackWhiteLists.size() - 1).getId());
                kafkaSyncService.addKafkaSync(kafkaSync);
            }

            //还原信号
            lastTime = kafkaSyncService.queryMaxTimeByType("reductionInfo");
            filter.clear();
            filter.put("lastTime",lastTime);
            filter.put("currentTime",currentTime);
            List<ReductionInfo> reductionInfos = reductionInfoService.queryReductionInfosFilter(filter);
            if(reductionInfos != null && reductionInfos.size() > 0){
                int i = 0;
                String app = "reductionInfo,addList," + organization.getId();
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

                kafkaSync = new KafkaSync();
                kafkaSync.setId(UUIDUtil.get32UUID());
                kafkaSync.setTime(currentTime);
                kafkaSync.setType("reductionInfo");
                kafkaSync.setDataId(reductionInfos.get(reductionInfos.size() - 1).getId());
                kafkaSyncService.addKafkaSync(kafkaSync);
            }

            //同步组织机构
            lastTime = kafkaSyncService.queryMaxTimeByType("organization");
            if(lastTime == null || organization.getUpdateDate().getTime() > lastTime.getTime()){
                String app = "organization,add," + organization.getId();
                new JyKafkaProducer(address).send(app, JSON.toJSONString(organization));
                kafkaSync = new KafkaSync();
                kafkaSync.setId(UUIDUtil.get32UUID());
                kafkaSync.setTime(currentTime);
                kafkaSync.setType("organization");
                kafkaSync.setDataId(organization.getId());
                kafkaSyncService.addKafkaSync(kafkaSync);
            }

            logger.info("KAFKA TIMER END");
        }
    }

    /**
     * 上级To下级
     */
    class SendDataToLower extends TimerTask {
        @Override
        public void run() {
            logger.info("kafka upper to lower start");
            OrganizationService organizationService = context.getBean(OrganizationService.class);
            SystemConfigService systemConfigService = context.getBean(SystemConfigService.class);
            SystemConfig systemConfig = systemConfigService.getSystemConfigByKey(SystemConfigConstants.ORGANIZATION_ID);
            String orgId = null;
            if(systemConfig != null) {
            	orgId = systemConfig.getSysValue();
            }
            Organization currentOrganization = organizationService.getOrganizationById(orgId);
            if(currentOrganization == null){
                logger.info("cannot get currentOrganization");
                return;
            }
            Map<String,Object> filter = new HashMap<>();
            filter.put("parentId",currentOrganization.getId());
            List<Organization> list = organizationService.queryOrganizationsFilter(filter);
            for(Organization org: list){
                if(StringUtils.isNotBlank(org.getIp())){
                    String address = org.getIp() + ":" + JyKafkaProducer.KAFKA_PORT;
                    String app = "organization,add," + org.getId();
                    new JyKafkaProducer(address).send(app, JSON.toJSONString(org));
                }
            }

            logger.info("kafka upper to lower start");
        }
    }

}
