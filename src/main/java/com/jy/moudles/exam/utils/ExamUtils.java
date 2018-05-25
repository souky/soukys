package com.jy.moudles.exam.utils;

import com.alibaba.fastjson.JSON;
import com.jy.common.kafka.producer.JyKafkaProducer;
import com.jy.common.persistence.interceptor.LoginInterceptor;
import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.entity.ExamSub;
import com.jy.moudles.exam.entity.ExamType;
import com.jy.moudles.exam.service.ExamService;
import com.jy.moudles.organization.entity.Organization;
import com.jy.moudles.organization.service.OrganizationService;
import com.jy.moudles.user.entity.User;
import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.common.utils.GeneralProtocol;
import com.jy.protocol.jf.utils.IssuedSendUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import java.util.*;

/**
 * Created by wb on 2017/12/14 14:14
 * 考试相关工具类
 */
public class ExamUtils {

    static WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();

    /**
     * 下发考试到侦测
     */
    public static void issuedExam() {

        Object flag = ParamStatic.issuedStaticMap.get(IssuedSendUtils.HEART_BREATH);
        if(flag != null && (boolean)flag){
            Map<String,Object> filters = new HashMap<>();
            filters.put("status", 1);
            ExamService examService = context.getBean(ExamService.class);
            List<Exam> issExamList = examService.queryExamToSend(filters);
            String ip = (String) ParamStatic.issuedStaticMap.get(IssuedSendUtils.DETECTION_IP);
            if(null != issExamList && issExamList.size() > 0) {
                //去掉考试中没有考试场次的
                Iterator<Exam> iterator = issExamList.iterator();
                while(iterator.hasNext()){
                    Exam exam = iterator.next();
                    if(exam.getExamSubList() == null || exam.getExamSubList().isEmpty()){
                        iterator.remove();
                    }
                }
                if(issExamList.size() > 0){
                    GeneralProtocol.sendExam(issExamList);
                }
            }else {
                List<Exam> issExamLists = new ArrayList<>();
                GeneralProtocol.sendExam(issExamLists);
            }
        }
    }

    /**
     * kafka 发送考试类型
     * examType,examTypeId,ids同时只能有一个为非空
     * @param type add/update/delete/deleteList
     * @param examType 增加或者修改考试类型
     * @param examTypeId 删除考试类型
     * @param ids 批量删除考试类型
     */
    public static void sengExamTypeData(String type, ExamType examType, String examTypeId, List<String> ids){
        String address = checkOrgAndIP();
        if(StringUtils.isNotBlank(address)){
            //add/update
            if(examType != null){
                String app = "examType," + type + "," + examType.getOrgId();
                new JyKafkaProducer(address).send(app, JSON.toJSONString(examType));
                return;
            }
            //delete
            if(StringUtils.isNotBlank(examTypeId)){
                String app = "examType," + type + ",";
                new JyKafkaProducer(address).send(app, JSON.toJSONString(examTypeId));
            }
            //deleteList
            if(ids != null && ids.size() > 0){
                String app = "examType," + type + "," ;
                new JyKafkaProducer(address).send(app, JSON.toJSONString(ids));
            }
        }
    }

    /**
     * kafka 发送考试计划
     * exam,examId,ids同时只能有一个为非空
     * @param type add/update/delete/deleteList
     * @param exam 增加或者修改考试计划
     * @param examId 删除考试计划
     * @param ids 批量删除考试计划
     */
    public static void sengExamData(String type,Exam exam,String examId,List<String> ids){
        String address = checkOrgAndIP();
        if(StringUtils.isNotBlank(address)){
            //add/update
            if(exam != null){
                String app = "exam," + type + "," + exam.getOrgId();
                new JyKafkaProducer(address).send(app, JSON.toJSONString(exam));
            }
            //delete
            if(StringUtils.isNoneBlank(examId)){
                String app = "exam," + type + ",";
                new JyKafkaProducer(address).send(app, examId);
            }
            //deleteList
            if(ids != null && ids.size() > 0){
                String app = "exam," + type + ",";
                new JyKafkaProducer(address).send(app, JSON.toJSONString(ids));
            }
        }
    }

    /**
     * kafka 发送考试场次
     * examSub,examSubId,ids同时只能有一个为非空
     * @param type add/update/delete
     * @param examSub 增加或者修改考试场次
     * @param examSubId 删除考试场次
     */
    public static void sengExamSubData(String type, ExamSub examSub, String examSubId){
        String address = checkOrgAndIP();
        if(StringUtils.isNotBlank(address)) {
            //add/update
            if (examSub != null) {
                String app = "examSub," + type + "," + examSub.getOrgId();
                new JyKafkaProducer(address).send(app, JSON.toJSONString(examSub));
            }
            //delete
            if (StringUtils.isNoneBlank(examSubId)) {
                String app = "examSub," + type + ",";
                new JyKafkaProducer(address).send(app, JSON.toJSONString(examSubId));
            }
        }
    }


    //------------------------------------------------------------------------------------------------
    private static String checkOrgAndIP(){
        String address = "";
        User user = LoginInterceptor.getCurrentUser();
        Organization upperOrganization = null;
        if(user != null) {
            OrganizationService organizationService = context.getBean(OrganizationService.class);
            Organization currentOrg = organizationService.getOrganizationById(user.getOrgId());
            if(currentOrg != null) {
                upperOrganization = organizationService.getOrganizationById(currentOrg.getParentId());
            }
        }
        if(upperOrganization != null && StringUtils.isNotBlank(upperOrganization.getIp())){
            String ip = upperOrganization.getIp();
            address = ip + ":" + JyKafkaProducer.KAFKA_PORT;
        }else{
            System.out.println("-------------cannot get upperOrganization");
        }
        return address;
    }

}
