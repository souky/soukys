package com.jy.common.timer.timerWork;

import com.alibaba.fastjson.JSON;
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

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by wb on 2017/11/12.
 */
public class CheckKafkaDataTimer {
    private static final Logger logger = LoggerFactory.getLogger(CheckKafkaDataTimer.class);

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private ApplicationContext context;

    public CheckKafkaDataTimer(ApplicationContext context) {
        this.context = context;
    }

    public void start(){
        logger.info("START KAFKA TIMER");
        Timer timer = new Timer();

        //每天凌晨12点校验上下级数据是否一致
        Date firstTime = getZeroTime(1);

        timer.schedule(new CheckDataTask(),firstTime,(1000 * 60 * 60 * 24));
    }

    /**
     * 统计当前的数据量,向每个下级发送
     */
    class CheckDataTask extends TimerTask{
        @Override
        public void run() {
            logger.info("kafka start to check data");
            OrganizationService organizationService = context.getBean(OrganizationService.class);
            SystemConfigService systemConfigService = context.getBean(SystemConfigService.class);
            SystemConfig systemConfig = systemConfigService.getSystemConfigByKey(SystemConfigConstants.ORGANIZATION_ID);
            String orgId = null;
            if(systemConfig != null) {
            	orgId = systemConfig.getSysValue();
            }
            Organization organization = organizationService.getOrganizationById(orgId);
            
            if(organization == null){
                logger.info("cannot get current Organization");
                return;
            }
            Map<String,Object> filter = new HashMap<>();
            filter.put("parentId",organization.getId());
            List<Organization> list = organizationService.queryOrganizationsFilter(filter);
            for(Organization org: list){
                if(StringUtils.isNotBlank(org.getIp())){
                    DeviceService deviceService = context.getBean(DeviceService.class);
                    BlackWhiteListService blackWhiteListService = context.getBean(BlackWhiteListService.class);
                    ReductionInfoService reductionInfoService = context.getBean(ReductionInfoService.class);
                    ExamService examService = context.getBean(ExamService.class);
                    ExamTypeService examTypeService = context.getBean(ExamTypeService.class);
                    ExamSubService examSubService = context.getBean(ExamSubService.class);

                    filter.clear();
                    filter.put("orgId",org.getId());
                    Date lastTime = getZeroTime(0);
                    Date currentTime = getZeroTime(1);
                    filter.put("lastTime",lastTime);
                    filter.put("currentTime",currentTime);
                    List<Device> devices = deviceService.queryDevicesFilter(filter);
                    List<BlackWhiteList> blackWhiteLists = blackWhiteListService.queryBlackWhiteListsFilter(filter);
                    List<ReductionInfo> reductionInfos = reductionInfoService.queryReductionInfosFilter(filter);
                    List<Exam> exams = examService.queryExamFilter(filter);
                    List<ExamType> examTypes = examTypeService.queryExamTypesFilter(filter);
                    List<ExamSub> examSubs = examSubService.queryExsubsFilter(filter);

                    Map<String,Integer> amountMap = new HashMap<>();
                    if(devices != null){
                        amountMap.put("device",devices.size());
                    }
                    if(blackWhiteLists != null){
                        amountMap.put("blackWhiteList",blackWhiteLists.size());
                    }
                    if(reductionInfos != null){
                        amountMap.put("reductionInfo",reductionInfos.size());
                    }
                    if(exams != null){
                        amountMap.put("exam",exams.size());
                    }
                    if(examTypes != null){
                        amountMap.put("examType",examTypes.size());
                    }
                    if(examSubs != null){
                        amountMap.put("examSub",examSubs.size());
                    }

                    String address = org.getIp() + ":" + JyKafkaProducer.KAFKA_PORT;
                    String app = "check_data,," + org.getId() + "," + sdf.format(lastTime) + "," + sdf.format(currentTime);
                    new JyKafkaProducer(address).send(app, JSON.toJSONString(amountMap));
                }
            }

            logger.info("kafka ending check data");
        }
    }

    //
    /**
     * 获取每天凌晨0点时间
     * @param num
     * num=0,当天0点,num=1,明天0点
     * @return "yyyy-MM-dd 00:00:00"
     */
    private Date getZeroTime(int num){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.set(Calendar.DATE,(calendar.get(Calendar.DATE) + 1));
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        calendar.add(Calendar.DAY_OF_MONTH, num);
        return calendar.getTime();
    }
}
