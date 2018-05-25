package com.jy.moudles.blackwhitelist.entity;

import com.jy.common.entity.BaseEntity;
import com.jy.common.excelUtil.ExcelField;
import com.jy.moudles.organization.entity.Organization;

public class BlackWhiteList extends BaseEntity{

	private static final long serialVersionUID = -2750349742355545348L;

	/**
	 * 频类--0：未知、1：频点、2：频段
	 */
	private Integer frequencyType;

	@ExcelField(title = "频类")
	private String frequencyTypeAlias;
	
	/**
	 * 类型--0：未知、1：黑名单、2：高可疑、3：中可疑、4：低可疑、5：白名单
	 */
	private Integer type;

	@ExcelField(title = "类型")
	private String typeAlias;

	/**
	 * 主频点/开始频点--单位（Hz）
	 */
	@ExcelField(title = "开始频点/中心频点")
	private String marjorFrequency;
	
	/**
	 * 副频点/结束频点--单位（Hz）
	 */
	@ExcelField(title = "结束频点/副频点")
	private String secondFrequency;

	/**
	 * 来源--0：未知、1：本地、2：平台
	 */
	private Integer source;

	@ExcelField(title = "来源")
	private String sourceAlias;


	/**
	 * 组织机构ID
	 */
	private String orgId;

	private Organization organization;
	
	
	public Integer getFrequencyType() {
		return frequencyType;
	}

	public void setFrequencyType(Integer frequencyType) {
		this.frequencyType = frequencyType;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	public String getMarjorFrequency() {
		return marjorFrequency;
	}

	public void setMarjorFrequency(String marjorFrequency) {
		this.marjorFrequency = marjorFrequency;
	}
	
	public String getSecondFrequency() {
		return secondFrequency;
	}

	public void setSecondFrequency(String secondFrequency) {
		this.secondFrequency = secondFrequency;
	}
	
	public Integer getSource() {
		return source;
	}

	public void setSource(Integer source) {
		this.source = source;
	}
	
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public String getFrequencyTypeAlias() {
		return frequencyTypeAlias;
	}

	public void setFrequencyTypeAlias(String frequencyTypeAlias) {
		this.frequencyTypeAlias = frequencyTypeAlias;
	}

	public String getTypeAlias() {
		return typeAlias;
	}

	public void setTypeAlias(String typeAlias) {
		this.typeAlias = typeAlias;
	}

	public String getSourceAlias() {
		return sourceAlias;
	}

	public void setSourceAlias(String sourceAlias) {
		this.sourceAlias = sourceAlias;
	}
}



