package com.jy.moudles.user.entity;

import java.io.Serializable;

import com.jy.common.entity.BaseEntity;
import com.jy.common.excelUtil.ExcelField;
import com.jy.moudles.organization.entity.Organization;

public class User extends BaseEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	
	/**
	 * 姓名
	 */
	@ExcelField(title = "姓名")
	private String name;
	
	/**
	 * 用户名
	 */
	@ExcelField(title = "用户名")
	private String userName;
	
	/**
	 * 密码
	 */
	private String password;
	
	/**
	 * 性别
	 */
	private Integer sex;
	
	/**
	 * 年龄
	 */
	@ExcelField(title = "年龄")
	private Integer age;
	
	/**
	 * 地址
	 */
	@ExcelField(title = "地址")
	private String address;
	
	/**
	 * 电话号码
	 */
	@ExcelField(title = "电话")
	private String phone;
	
	/**
	 * 邮箱
	 */
	private String email;
	
	/**
	 * orgId
	 */
	private String orgId;
	
	/**
	 * 角色id
	 */
	private String roleId;
	
	private String mobile;
	private String provinceCode;
	private String cityCode;
	private String regionCode;
	private String image;
	private int dataPermission;
	
	private String roleName;
	private String orgName;
	
	/**
	 * 机构：和机构实体类关联起来
	 */
	private Organization organization;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getDataPermission() {
		return dataPermission;
	}

	public void setDataPermission(int dataPermission) {
		this.dataPermission = dataPermission;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	

}
