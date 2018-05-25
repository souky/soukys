package com.jy.moudles.classroomInfo.entity;

import com.jy.common.entity.BaseEntity;
import com.jy.moudles.device.entity.Device;

import java.util.List;

public class ClassroomInfo extends BaseEntity{

	
	/**
	 * 楼的数量
	 */
	private int buildingNo;
	
	/**
	 * 每栋楼的层数
	 */
	private int floorNo;
	
	/**
	 * 每层的教室数量
	 */
	private int classroomNo;
	
	
	public int getBuildingNo() {
		return buildingNo;
	}

	public void setBuildingNo(int buildingNo) {
		this.buildingNo = buildingNo;
	}
	
	public int getFloorNo() {
		return floorNo;
	}

	public void setFloorNo(int floorNo) {
		this.floorNo = floorNo;
	}
	
	public int getClassroomNo() {
		return classroomNo;
	}

	public void setClassroomNo(int classroomNo) {
		this.classroomNo = classroomNo;
	}

}



