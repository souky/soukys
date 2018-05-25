package com.jy.common.timer;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.jy.common.timer.timerWork.CheckKafkaDataTimer;

/**
 * Created by wb on 2017/11/10.
 */
@Component
public class kafkaCheckData implements ApplicationListener<ContextRefreshedEvent> {
    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        //防止timer执行两次
        if(event.getApplicationContext().getParent() == null){
            //new CheckKafkaDataTimer(event.getApplicationContext()).start();
        }
    }
}
