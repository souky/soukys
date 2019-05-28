package com.jy.moudles.userScore.entity;

import java.util.Date;

import com.jy.common.entity.BaseEntity;
/**
*
*/
public class UserScore extends BaseEntity{
	
	private static final long serialVersionUID = -1L;
	
	
	/**
	 * 
	 */
	private String id;
	
	/**
	 * 
	 */
	private String userName;
	
	/**
	 * 
	 */
	private String userPhone;
	
	private int userAge;
	
	
	private String userAddress;
	/**
	 * 
	 */
	private int userScore;
	
	/**
	 * 
	 */
	private int userTime;
	
	private Date userDate;
	
	/**
	 * 
	 */
	private int userFlag;
	
	
	
	public Date getUserDate() {
		return userDate;
	}

	public void setUserDate(Date userDate) {
		this.userDate = userDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	
	public int getUserScore() {
		return userScore;
	}

	public void setUserScore(int userScore) {
		this.userScore = userScore;
	}
	
	public int getUserTime() {
		return userTime;
	}

	public void setUserTime(int userTime) {
		this.userTime = userTime;
	}
	
	public int getUserFlag() {
		return userFlag;
	}

	public void setUserFlag(int userFlag) {
		this.userFlag = userFlag;
	}

	public int getUserAge() {
		return userAge;
	}

	public void setUserAge(int userAge) {
		this.userAge = userAge;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	
	
	
}



