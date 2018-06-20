package com.jy.common.entity;

import java.io.Serializable;

public class ReturnObj implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7962229680753073756L;

	
	private int code;
	private String message;
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
		
}
