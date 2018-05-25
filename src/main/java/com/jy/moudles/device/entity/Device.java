package com.jy.moudles.device.entity;

import com.jy.common.entity.BaseEntity;
import com.jy.common.excelUtil.ExcelField;
import com.jy.moudles.organization.entity.Organization;

public class Device extends BaseEntity{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1080231915844126776L;

	/**
	 * IP地址  例：255.255.255.255
	 */
	@ExcelField(title = "IP")
	private String ip;
	
	/**
	 * MAC地址  例：00-00-00-00-00-00
	 */
	@ExcelField(title = "MAC")
	private String mac;
	
	/**
	 * SN码  自动生成：JY + MAC（不含特殊符号），例：JY000000000000
	 */
	@ExcelField(title = "SN")
	private String sn;
	
	/**
	 * 类型  0：未知、1：侦测、2：阻断
	 */
	@ExcelField(title = "类型")
	private Integer type;
	
	/**
	 * 版本号  V3.0.0.45
	 */
	@ExcelField(title = "版本")
	private String version;
	
	/**
	 * 状态  0：未知、1：在线、2：离线
	 */
	@ExcelField(title = "状态")
	private Integer status;
	
	/**
	 * 工作状态  0：未知、1：无考试计划、2：考中、3：考间、4：空闲
	 */
	@ExcelField(title = "工作状态")
	private Integer workStatus;
	
	/**
	 * 受控状态  0：未知、1：自动、2：手动
	 */
	@ExcelField(title = "受控状态")
	private Integer controlled;
	
	/**
	 * 手/自动  0：未知、1：自动、2：手动-全部、3：手动---1G、4：手动---手机、5：手动---未选
	 */
	private Integer operationType;
	private Integer operationType1G;
	private Integer operationTypePhone;
	
	/**
	 * 分组ID  [0,99]
	 */
	private Integer groupNo;

	/**
	 * 开关机 0:未知, 1:开机, 2:关机
	 */
	private Integer poweroff;

	/**
	 * 设备对应教室编排顺序
	 */
	private Integer listOrder;
	
	/**
	 * 组织机构ID
	 */
	private String orgId;
	
	private Integer pageNum;
	private Integer pageSize;

	private Organization organization;

	/**
	 * 设备放置地点
	 */
	private String address;

	/**
	 * 设备厂家(发送协议时用于区分)
	 * @return
	 */
	private String vender;
	
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
	
	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}
	
	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}
	
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getWorkStatus() {
		return workStatus;
	}

	public void setWorkStatus(Integer workStatus) {
		this.workStatus = workStatus;
	}

	public Integer getControlled() {
		return controlled;
	}

	public void setControlled(Integer controlled) {
		this.controlled = controlled;
	}

	public Integer getOperationType() {
		return operationType;
	}

	public void setOperationType(Integer operationType) {
		this.operationType = operationType;
	}

	public Integer getOperationType1G() {
		return operationType1G;
	}

	public void setOperationType1G(Integer operationType1G) {
		this.operationType1G = operationType1G;
	}

	public Integer getOperationTypePhone() {
		return operationTypePhone;
	}

	public void setOperationTypePhone(Integer operationTypePhone) {
		this.operationTypePhone = operationTypePhone;
	}

	public Integer getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(Integer groupNo) {
		this.groupNo = groupNo;
	}

	public Integer getPageNum() {
		return pageNum==null?1:pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public Integer getPageSize() {
		return pageSize==null?10:pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

    public Integer getPoweroff() {
        return poweroff;
    }

    public void setPoweroff(Integer poweroff) {
        this.poweroff = poweroff;
    }

    public Integer getListOrder() {
        return listOrder;
    }

    public void setListOrder(Integer listOrder) {
        this.listOrder = listOrder;
    }

	public String getVender() {
		return vender;
	}

	public void setVender(String vender) {
		this.vender = vender;
	}
}



