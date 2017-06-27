package com.souky.entity.commercial;

import java.io.Serializable;
import java.util.Date;

public class CommercialOrder implements Serializable{

	private static final long serialVersionUID = 6630453342706078822L;

	private String id;
	private String commercialId;
	private String orderPrice;
	private String orderMaker;
	private String isPay;
	private String payWWay;
	private String isCooking;
	private Date creatTime;
	private Date payTime;
	private String orderStatus;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCommercialId() {
		return commercialId;
	}
	public void setCommercialId(String commercialId) {
		this.commercialId = commercialId;
	}
	public String getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(String orderPrice) {
		this.orderPrice = orderPrice;
	}
	public String getOrderMaker() {
		return orderMaker;
	}
	public void setOrderMaker(String orderMaker) {
		this.orderMaker = orderMaker;
	}
	public String getIsPay() {
		return isPay;
	}
	public void setIsPay(String isPay) {
		this.isPay = isPay;
	}
	public String getPayWWay() {
		return payWWay;
	}
	public void setPayWWay(String payWWay) {
		this.payWWay = payWWay;
	}
	public String getIsCooking() {
		return isCooking;
	}
	public void setIsCooking(String isCooking) {
		this.isCooking = isCooking;
	}
	public Date getCreatTime() {
		return creatTime;
	}
	public void setCreatTime(Date creatTime) {
		this.creatTime = creatTime;
	}
	public Date getPayTime() {
		return payTime;
	}
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	
	

}
