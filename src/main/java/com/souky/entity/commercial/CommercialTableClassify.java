package com.souky.entity.commercial;

import java.io.Serializable;

public class CommercialTableClassify implements Serializable{

	private static final long serialVersionUID = 6682360141318474929L;
	
	private String id;
	private String classifyName;
	private String classifyImg;
	private String sort;
	private String status;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getClassifyName() {
		return classifyName;
	}
	public void setClassifyName(String classifyName) {
		this.classifyName = classifyName;
	}
	public String getClassifyImg() {
		return classifyImg;
	}
	public void setClassifyImg(String classifyImg) {
		this.classifyImg = classifyImg;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}


}
