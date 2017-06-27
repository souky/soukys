package com.souky.entity.user;

import java.io.Serializable;

public class Jurisdiction implements Serializable{

	private static final long serialVersionUID = 7213874953624978489L;
	
	private String id;
	private String jurisdiction_name;
	private String identification;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIdentification() {
		return identification;
	}
	public void setIdentification(String identification) {
		this.identification = identification;
	}
	public String getJurisdiction_name() {
		return jurisdiction_name;
	}
	public void setJurisdiction_name(String jurisdiction_name) {
		this.jurisdiction_name = jurisdiction_name;
	}
	
	
	
}
