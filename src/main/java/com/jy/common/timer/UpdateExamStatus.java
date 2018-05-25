package com.jy.common.timer;

import com.jy.common.timer.timerWork.UpdateExamStatusTimer;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

/**
 * Created by wb on 2017/10/26.
 */
@Component
public class UpdateExamStatus implements ApplicationListener<ContextRefreshedEvent> {

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        //防止timer执行两次
        if(event.getApplicationContext().getParent() == null){
            //new SendExamPlanTimer(event.getApplicationContext()).start();
        }
    }
}
