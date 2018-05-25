package com.jy.common.kafka.producer;

/**
 * @author wb
 * kafka 发送消息的类型
 *
 */
public class KafkaMessageType {
	
	public final static String ADD = "add";
	
	public final static String ADD_LIST = "addList";
	
	public final static String UPDATE = "update";
	
	public final static String DELETE = "delete";
	
	public final static String DELETE_LIST = "deleteList";
	
	public final static String DELETE_ALL = "deleteAll";
	
	public final static String DELETE_AND_ADD = "deleteAndAdd";

}
