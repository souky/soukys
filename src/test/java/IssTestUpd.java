import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jy.moudles.exam.entity.Exam;
import com.jy.moudles.exam.entity.ExamSub;
import com.jy.protocol.jf.utils.IssuedSendUtils;

public class IssTestUpd {

	public static final String ip = "192.168.15.22";
	public static final String ip_s = "192.168.15.33";
	
	public static void main(String[] args) {
		//kaiguanzuduanshebei();
		//xiafakaoshi();
		
	}
	
	public static void xiafakaoshi() {
		List<Exam> list = new ArrayList<Exam>();
		Exam exm = new Exam();
		exm.setExamName("测试考试计划");
		exm.setExamNo("2017002");
		Date date = new Date();
		exm.setStartTime(new Date());
		long time = date.getTime();
		time += 6 * 60 *60 * 1000;
		date.setTime(time);
		exm.setEndTime(date);
		exm.setStatus(1);
		
		List<ExamSub> examSubList = new ArrayList<ExamSub>();
		ExamSub examSub = new ExamSub();
		examSub.setExamPlanId(exm.getExamNo());
		examSub.setNo(1);
		examSub.setName("测试第一次");
		Date date2 = new Date();
		examSub.setStartTime(new Date());
		long time2 = date2.getTime();
		time2 += 6 * 60 * 60 * 1000;
		date2.setTime(time2);
		examSub.setEndTime(date2);
		examSubList.add(examSub);
		
		exm.setExamSubList(examSubList);
		
		list.add(exm);
		
		
		IssuedSendUtils.sendExam(list, ip, IssuedSendUtils.DETECTION_UDP_PORT);
	}

	public static void kaiguanzuduanshebei() {
		IssuedSendUtils.shieldControllerBase(0, ip_s, IssuedSendUtils.DETECTION_UDP_PORT);
		IssuedSendUtils.shieldControllerPhone(0, ip_s, IssuedSendUtils.DETECTION_UDP_PORT);
	}
}
