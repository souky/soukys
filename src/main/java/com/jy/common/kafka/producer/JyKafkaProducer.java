package com.jy.common.kafka.producer;

import org.apache.commons.lang3.StringUtils;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;

import java.util.Date;
import java.util.Properties;

/**
 * Created by flm on 2017/7/25.
 */
public class JyKafkaProducer extends Thread {
    private final Producer<String, String> producer;

    public final static int KAFKA_PORT = 9092;

    //目前只用一个topic
    private final String TOPIC = "anti-cheat-system";

    /**
     * JyKafkaProducer构造函数
     *
     * @param addrs   需要发送的IP地址，支持多个用逗号分隔
     * @throws Exception
     */
    public JyKafkaProducer(String addrs) {
        Properties props = new Properties();
        props.put("bootstrap.servers", addrs);
        props.put("acks", "all");
        props.put("retries", 0);
        props.put("batch.size", 16384);
        props.put("linger.ms", 1);
        props.put("buffer.memory", 33554432);
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        System.out.println("address======" + addrs);
        producer = new KafkaProducer<String, String>(props);
    }

    /**
     * app = 模块名称 + 操作类型 + orgid  + 上次同步时间 + 本次事件
     * (eg:"exam,add," + orgId + lastTime + currentTime(时间不需要可以不加))
]    * @param app     消息的应用模块
     * @param msg     消息体
     */
    public void send(String app,String msg) {
    	send(TOPIC,app,msg);
    }
    
    public void send(String topic, String app,String msg) {
        System.out.println("start send message！#######" + new Date());
        producer.send(new ProducerRecord<String, String>(topic,app,msg));
        if(StringUtils.isNoneBlank(app)){
            System.out.println("----" + app.split(",") + "---- sync success,time:" + new Date());
        }
        producer.close();
        //发送成功
        System.out.println("end send message！#######" + new Date());

    }
}
