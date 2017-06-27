package com.souky.entity.commercial;

import java.io.Serializable;

public class CommercialOrderItem implements Serializable{

	private static final long serialVersionUID = -6090113879745895949L;
	
	private String id;
	private String orderId;
	private String foodId;
	private String foodCount;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getFoodId() {
		return foodId;
	}
	public void setFoodId(String foodId) {
		this.foodId = foodId;
	}
	public String getFoodCount() {
		return foodCount;
	}
	public void setFoodCount(String foodCount) {
		this.foodCount = foodCount;
	}


}
