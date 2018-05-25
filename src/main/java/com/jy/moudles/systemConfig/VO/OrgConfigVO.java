package com.jy.moudles.systemConfig.VO;

public class OrgConfigVO {

	private String provinceCode;
	
	private String cityCode;
	
	private String areaCode;
	
	private String orgName;
	
	private String orgIp;
	
	/**
	 *是 Y/否N
	 */
	private String isExamSpot;
	

	/**
	 * @return the isExamSpot
	 */
	public String getIsExamSpot() {
		return isExamSpot;
	}

	/**
	 * @param isExamSpot the isExamSpot to set
	 */
	public void setIsExamSpot(String isExamSpot) {
		this.isExamSpot = isExamSpot;
	}

	/**
	 * @return the provinceCode
	 */
	public String getProvinceCode() {
		return provinceCode;
	}

	/**
	 * @param provinceCode the provinceCode to set
	 */
	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	/**
	 * @return the cityCode
	 */
	public String getCityCode() {
		return cityCode;
	}

	/**
	 * @param cityCode the cityCode to set
	 */
	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	/**
	 * @return the areaCode
	 */
	public String getAreaCode() {
		return areaCode;
	}

	/**
	 * @param areaCode the areaCode to set
	 */
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

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
	 * @return the orgIp
	 */
	public String getOrgIp() {
		return orgIp;
	}

	/**
	 * @param orgIp the orgIp to set
	 */
	public void setOrgIp(String orgIp) {
		this.orgIp = orgIp;
	}
	
}
