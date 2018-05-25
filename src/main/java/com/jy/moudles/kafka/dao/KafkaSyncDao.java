package com.jy.moudles.kafka.dao;

import org.apache.ibatis.annotations.Param;

import com.jy.common.persistence.annotation.MyBatisDao;
import com.jy.moudles.kafka.entity.KafkaSync;

import java.util.Date;

@MyBatisDao
public interface KafkaSyncDao {

	Date queryMaxTimeByType(String type);
	
	void addKafkaSync(KafkaSync kafkaSync);
	
	void deleteKafkaSync(String time);
	
	KafkaSync queryByDataId(@Param("dataId")String dataId);
	
	void updateKafkaSync(KafkaSync kafkaSync);
}
