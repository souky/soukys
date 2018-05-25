package com.jy.moudles.kafka.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.moudles.kafka.dao.KafkaSyncDao;
import com.jy.moudles.kafka.entity.KafkaSync;
import com.jy.moudles.kafka.service.KafkaSyncService;

import java.util.Date;

@Service
public class KafkaSyncServiceImpl implements KafkaSyncService{

	@Autowired
	private KafkaSyncDao dao;
	
	@Override
	public Date queryMaxTimeByType(String type) {
		return dao.queryMaxTimeByType(type);
	}

	@Override
	public void addKafkaSync(KafkaSync kafkaSync) {
		dao.addKafkaSync(kafkaSync);		
	}

	@Override
	public void deleteKafkaSync(String time) {
		dao.deleteKafkaSync(time);
	}

	@Override
	public KafkaSync queryByDataId(String dataId) {
		return dao.queryByDataId(dataId);
	}

	@Override
	public void updateKafkaSync(KafkaSync kafkaSync) {
		dao.updateKafkaSync(kafkaSync);
	}

}
