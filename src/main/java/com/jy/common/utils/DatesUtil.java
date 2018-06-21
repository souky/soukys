package com.jy.common.utils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.jy.moudles.punchClock.VO.DateVO;

public class DatesUtil {

	/**
	 * 获取日历
	 * */
	public static List<DateVO> getListDate(){
		Calendar c = Calendar.getInstance();
		c.set(Calendar.HOUR_OF_DAY, 0);
		c.set(Calendar.MINUTE, 0);
		c.set(Calendar.SECOND, 0);
		c.set(Calendar.MILLISECOND, 0);
		long date = c.getTimeInMillis();
		c.set(Calendar.DAY_OF_MONTH, 1);
		int week = c.get(Calendar.DAY_OF_WEEK) -1;
		long oneDay = 1000 * 60 * 60 * 24l;
		if(week == -1) {
			week = 0;
		}
		long initDay = c.getTimeInMillis() - (oneDay * week);
		long dayOne = c.getTimeInMillis();
		int month = c.get(Calendar.MONTH);
		c.set(Calendar.MONTH, month+1);
		long dayLast = c.getTimeInMillis() - oneDay;
		
		List<DateVO> listDate = new ArrayList<>();

		int for_int = 35;
		
		if (week > 4) {
			for_int = 42;
		}
		
		for(int i = 1;i <= for_int;i++ ) {
			DateVO dateVO = new DateVO();
			dateVO.setCheck(false);
			dateVO.setCss("");
			if(initDay == date) {
				dateVO.setCss("active");
			}
			if(initDay < dayOne || initDay > dayLast) {
				dateVO.setCss("forbid");
			}
			Calendar cc = Calendar.getInstance();
			cc.setTimeInMillis(initDay);
			dateVO.setDate(cc.getTime());
			dateVO.setDays(cc.get(Calendar.DAY_OF_MONTH));
			initDay += oneDay;
			listDate.add(dateVO);
		}
		return listDate;
	}
	
	/**
	 * 获取时间日程
	 * */
	public static String getDateFormat(String format) {
		String returnString = "";
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		try {
			returnString = sdf.format(date);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return returnString;
	}
}
