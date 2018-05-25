package com.jy.common.timer.timerWork;

import com.jy.moudles.exam.constant.ExamStatus;
import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.service.ExamService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.util.*;

/**
 * Created by wb on 2017/10/26.
 */
public class UpdateExamStatusTimer {

    private static final Logger logger = LoggerFactory.getLogger(UpdateExamStatusTimer.class);

    private ApplicationContext context;

    public UpdateExamStatusTimer() {
    }

    public UpdateExamStatusTimer(ApplicationContext context) {
        this.context = context;
    }

    public void start(){
        logger.info("start to update exam status");
        Timer timer = new Timer("update exam status");
        //schedule(TimerTask task, long delay, long period)  延迟delay毫秒执行定时任务
        //考试相关,只在项目启动时执行一次同步
        timer.schedule(new SendExamTask(), 1000 * 10, (1000 * 60 * 5));
    }

    class SendExamTask extends TimerTask {
        @Override
        public void run() {
            Date currentTime = new Date();
            logger.info(currentTime +"查询考试结束时间小于当前时间,并且考试状态为启用的 改为禁用状态");
            ExamService examService = context.getBean(ExamService.class);
            Map<String,Object> filter = new HashMap<String,Object>();
            filter.put("status", ExamStatus.ON);
            filter.put("currentTime", currentTime);
            List<Exam> exams = examService.queryExpiredExamsfilter(filter);
            if(exams != null && !exams.isEmpty()) {
            	for(Exam exam : exams) {
            		exam.setStatus(ExamStatus.OFF);
            		examService.updateExam(exam);
            	}
            }

            logger.info(new Date() +"修改考试状态结束");
        }
    }
}
