package com.souky.entity.commercial;

import java.io.Serializable;

public class CommercialInfo implements Serializable{

	private static final long serialVersionUID = 1602567638457858919L;
	
	private String id;
	private String commercialName;
	private String wxPayInfo;
	private String aliPayInfo;
	private String contactTel;
	private String contactAddress;
	private String status;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCommercialName() {
		return commercialName;
	}
	public void setCommercialName(String commercialName) {
		this.commercialName = commercialName;
	}
	public String getWxPayInfo() {
		return wxPayInfo;
	}
	public void setWxPayInfo(String wxPayInfo) {
		this.wxPayInfo = wxPayInfo;
	}
	public String getAliPayInfo() {
		return aliPayInfo;
	}
	public void setAliPayInfo(String aliPayInfo) {
		this.aliPayInfo = aliPayInfo;
	}
	public String getContactTel() {
		return contactTel;
	}
	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}
	public String getContactAddress() {
		return contactAddress;
	}
	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
