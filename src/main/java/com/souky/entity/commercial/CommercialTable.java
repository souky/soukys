package com.souky.entity.commercial;

import java.io.Serializable;

public class CommercialTable implements Serializable{

	private static final long serialVersionUID = 2179645605467314485L;

	private String id;
	private String commercialId;
	private String foodName;
	private String foodPrice;
	private String foodDetailText;
	private String foodDetailImg;
	private String cookingTime;
	private String isHot;
	private String classifyId;
	private String status;
	
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
	public String getFoodName() {
		return foodName;
	}
	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}
	public String getFoodPrice() {
		return foodPrice;
	}
	public void setFoodPrice(String foodPrice) {
		this.foodPrice = foodPrice;
	}
	public String getFoodDetailText() {
		return foodDetailText;
	}
	public void setFoodDetailText(String foodDetailText) {
		this.foodDetailText = foodDetailText;
	}
	public String getFoodDetailImg() {
		return foodDetailImg;
	}
	public void setFoodDetailImg(String foodDetailImg) {
		this.foodDetailImg = foodDetailImg;
	}
	public String getCookingTime() {
		return cookingTime;
	}
	public void setCookingTime(String cookingTime) {
		this.cookingTime = cookingTime;
	}
	public String getIsHot() {
		return isHot;
	}
	public void setIsHot(String isHot) {
		this.isHot = isHot;
	}
	public String getClassifyId() {
		return classifyId;
	}
	public void setClassifyId(String classifyId) {
		this.classifyId = classifyId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
