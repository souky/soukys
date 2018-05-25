package com.jy.moudles.statistics.entity;

/**
 * Created by wb on 2017/11/1.
 */
public class DeviceCollectVO {

    private String orgName;

    private int count;

    /**
     * 设备类型 0：未知、1：侦测、2：阻断
     */
    private int type;

    /**
     * 设备状态 0：未知、1：在线、2：离线
     */
    private int status;

	/**
	 * @return the orgName
	 */
	public String getOrgName() {
		return orgName;
	}

	/**
	 * @param orgName the orgName to set
	 */
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	/**
	 * @return the count
	 */
	public int getCount() {
		return count;
	}

	/**
	 * @param count the count to set
	 */
	public void setCount(int count) {
		this.count = count;
	}

	/**
	 * @return the type
	 */
	public int getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(int type) {
		this.type = type;
	}

	/**
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}
    
}
