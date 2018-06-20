package com.jy.moudles.punchClock.VO;

import java.util.Date;

/**
 * 日历VO
 * 
 * */
public class DateVO {

	private int days;
	private String css;
	private boolean check;
	private Date date;
	
	public int getDays() {
		return days;
	}
	public void setDays(int days) {
		this.days = days;
	}
	public String getCss() {
		return css;
	}
	public void setCss(String css) {
		this.css = css;
	}
	public boolean isCheck() {
		return check;
	}
	public void setCheck(boolean check) {
		this.check = check;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
}
