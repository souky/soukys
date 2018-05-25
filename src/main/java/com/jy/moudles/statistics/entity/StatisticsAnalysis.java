package com.jy.moudles.statistics.entity;

import java.util.List;

public class StatisticsAnalysis {
	
	
	private int suspiciousSignalNum;
	private int cheatSignalNum;
	
	private int detectiveNum;
	private int shieldNum;
	
	private int onlineNumForDetective;
	private int normalOnlineDetective;
	private int innormalOnlineDetective;
	
	private int offlineNumForDetective;
	private int normalOfflineDetective;
	private int innormalOfflineDetective;
	
	private int onlineNumForShield;
	private int normalOnlineShield;
	private int innormalOnlineShield;
	
	
	private int offlineNumForShield;
	private int normalOfflineShield;
	private int innormalOfflineShield;
	
	List<CheatFrequencyPoint> pointList;
	
	
	public int getDetectiveNum() {
		return detectiveNum;
	}
	public void setDetectiveNum(int detectiveNum) {
		this.detectiveNum = detectiveNum;
	}
	public int getShieldNum() {
		return shieldNum;
	}
	public void setShieldNum(int shieldNum) {
		this.shieldNum = shieldNum;
	}
	public int getOnlineNumForDetective() {
		return onlineNumForDetective;
	}
	public void setOnlineNumForDetective(int onlineNumForDetective) {
		this.onlineNumForDetective = onlineNumForDetective;
	}
	public int getNormalOnlineDetective() {
		return normalOnlineDetective;
	}
	public void setNormalOnlineDetective(int normalOnlineDetective) {
		this.normalOnlineDetective = normalOnlineDetective;
	}
	public int getInnormalOnlineDetective() {
		return innormalOnlineDetective;
	}
	public void setInnormalOnlineDetective(int innormalOnlineDetective) {
		this.innormalOnlineDetective = innormalOnlineDetective;
	}
	public int getOfflineNumForDetective() {
		return offlineNumForDetective;
	}
	public void setOfflineNumForDetective(int offlineNumForDetective) {
		this.offlineNumForDetective = offlineNumForDetective;
	}
	public int getNormalOfflineDetective() {
		return normalOfflineDetective;
	}
	public void setNormalOfflineDetective(int normalOfflineDetective) {
		this.normalOfflineDetective = normalOfflineDetective;
	}
	public int getInnormalOfflineDetective() {
		return innormalOfflineDetective;
	}
	public void setInnormalOfflineDetective(int innormalOfflineDetective) {
		this.innormalOfflineDetective = innormalOfflineDetective;
	}
	public int getOnlineNumForShield() {
		return onlineNumForShield;
	}
	public void setOnlineNumForShield(int onlineNumForShield) {
		this.onlineNumForShield = onlineNumForShield;
	}
	public int getNormalOnlineShield() {
		return normalOnlineShield;
	}
	public void setNormalOnlineShield(int normalOnlineShield) {
		this.normalOnlineShield = normalOnlineShield;
	}
	public int getInnormalOnlineShield() {
		return innormalOnlineShield;
	}
	public void setInnormalOnlineShield(int innormalOnlineShield) {
		this.innormalOnlineShield = innormalOnlineShield;
	}
	public int getOfflineNumForShield() {
		return offlineNumForShield;
	}
	public void setOfflineNumForShield(int offlineNumForShield) {
		this.offlineNumForShield = offlineNumForShield;
	}
	public int getNormalOfflineShield() {
		return normalOfflineShield;
	}
	public void setNormalOfflineShield(int normalOfflineShield) {
		this.normalOfflineShield = normalOfflineShield;
	}
	public int getInnormalOfflineShield() {
		return innormalOfflineShield;
	}
	public void setInnormalOfflineShield(int innormalOfflineShield) {
		this.innormalOfflineShield = innormalOfflineShield;
	}

	public int getSuspiciousSignalNum() {
		return suspiciousSignalNum;
	}
	public void setSuspiciousSignalNum(int suspiciousSignalNum) {
		this.suspiciousSignalNum = suspiciousSignalNum;
	}
	public int getCheatSignalNum() {
		return cheatSignalNum;
	}
	public void setCheatSignalNum(int cheatSignalNum) {
		this.cheatSignalNum = cheatSignalNum;
	}
	public List<CheatFrequencyPoint> getPointList() {
		return pointList;
	}
	public void setPointList(List<CheatFrequencyPoint> pointList) {
		this.pointList = pointList;
	}
}
