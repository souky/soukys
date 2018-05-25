package com.jy.moudles.kafka.controller;

import com.alibaba.fastjson.JSON;
import com.jy.common.kafka.producer.JyKafkaProducer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * blackWhiteList实现类
 * <p>
 * 创建人：1
 * 创建时间：2017-05-31
 */
@Controller
@RequestMapping(value = "/kafka")
public class KafkaTestController {


    @RequestMapping(value = "/kafkaTest", method = RequestMethod.GET)
    @ResponseBody
    public void sentTest() throws Exception {

//        String topic = "anti_cheat";
        String value = "test46546464";
//        String ifPartition = "1";
//        Integer partitionNum = 3;
        String app = "test";//用来生成key
        new JyKafkaProducer("192.168.128.230:9092").send(app, JSON.toJSONString(value));
//        Map<String,Object> res = kafkaProducerServer.sndMesForTemplate
//                (topic, value, ifPartition, partitionNum, app);
//
       System.out.println("测试结果如下：===============");
//        String message = (String)res.get("message");
//        String code = (String)res.get("code");
//
//        System.out.println("code:"+code);
//        System.out.println("message:"+message);
    }
}
