package com.jy.moudles.kafka.service;

import com.jy.moudles.kafka.entity.KafkaSync;

import java.util.Date;

public interface KafkaSyncService {

	Date queryMaxTimeByType(String type);
	
	void addKafkaSync(KafkaSync kafkaSync);
	
	void deleteKafkaSync(String time);
	
	KafkaSync queryByDataId(String dataId);
	
	void updateKafkaSync(KafkaSync kafkaSync);
}
