package com.jy.moudles.userAnswer.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.questionBank.VO.QuestionBankVO;
import com.jy.moudles.userAnswer.VO.UserAnswerVO;
import com.jy.moudles.userAnswer.dao.UserAnswerDao;
import com.jy.moudles.userAnswer.entity.UserAnswer;
import com.jy.moudles.userAnswer.service.UserAnswerService;
import com.jy.moudles.userScore.dao.UserScoreDao;
import com.jy.moudles.userScore.entity.UserScore;

/** 
 * UserAnswer业务实现类
 * 创建人：go-3
 * 创建时间：2019-04-18
 */
@Service
public class UserAnswerServiceImpl implements UserAnswerService {

	@Autowired
	private UserAnswerDao UserAnswerDao;
	@Autowired
	private UserScoreDao userScoreDao;
	
	@Override
	public void insertUserAnswer(UserAnswer UserAnswer){
		UserAnswer.setId(UUIDUtil.get32UUID());
		UserAnswerDao.insertUserAnswer(UserAnswer);
	}
	
	@Override
	public void updateUserAnswer(UserAnswer UserAnswer){
		UserAnswerDao.updateUserAnswer(UserAnswer);
	}
	
	
	@Override
	public List<UserAnswer> queryUserAnswersFilter(Map<String, Object> filter){
		return UserAnswerDao.queryUserAnswersFilter(filter);
	}
	
	@Override
	public void deleteUserAnswerById(String id){
		UserAnswerDao.deleteUserAnswerById(id);
	}
	
	@Override
	public void deleteUserAnswers(List<String> ids){
		UserAnswerDao.deleteUserAnswers(ids);
	}

	@Override
	public void insertsUserAnswer(List<UserAnswer> UserAnswers) {
		String userId = "";
		int times = 0;
		for(UserAnswer e :UserAnswers) {
			e.setId(UUIDUtil.get32UUID());
			userId = e.getUserId();
			times += e.getTime();
		}
		UserAnswerDao.insertsUserAnswer(UserAnswers);
		
		UserScore userScore = new UserScore();
		userScore.setUserFlag(1);
		userScore.setId(userId);
		userScore.setUserTime(times);
		userScore.setUserDate(new Date());
		userScoreDao.updateUserScore(userScore);
	}

	@Override
	public List<UserAnswer> getUserAnswerByUserId(String userId) {
		List<UserAnswer> list = UserAnswerDao.getUserAnswerByUserId(userId);
		
		return list;
	}

	@Override
	public AsyncResponseData.ResultData getUserAnswerByUserIdWithData(String userId) {
		
		List<UserAnswerVO> list = UserAnswerDao.getUserAnswerByUserIdWithData(userId);
//		// ablity map
//		Map<String,AblityMap> map_ablity = new HashMap<>();
//		
//		// ablity list
//		List<AblityVO> listAblity = new ArrayList<>();
//		
//		// ablity value
//		List<Integer> ablityValue = new ArrayList<>();
//		
//		// 处理能力值
//		if(null != list && list.size() > 0) {
//			for(UserAnswerVO u : list) {
//				
//				QuestionBankVO questionBankVO = u.getQuestionBankVO();
//				
//				String ablity = questionBankVO.getAblity();
//				AblityMap ablityMap = map_ablity.get(ablity);
//				
//				if(null == ablityMap) {
//					ablityMap = new AblityMap(questionBankVO,u);
//					map_ablity.put(ablity, ablityMap);
//				}else {
//					ablityMap.setTotal(ablityMap.getTotal() + 1);
//					if(questionBankVO.getAnswer().equals(u.getUserAnswer())) {
//						ablityMap.setRight(ablityMap.getRight() + 1);
//					}
//					map_ablity.put(ablity, ablityMap);
//				}
//				
//			}
//			
//			// 处理map
//			for(Map.Entry<String, AblityMap> e : map_ablity.entrySet()) {
//				AblityVO ablityVO = new AblityVO();
//				ablityVO.setText(e.getKey());
//				ablityVO.setMax(100);
//				listAblity.add(ablityVO);
//				AblityMap abmap = e.getValue();
//				BigDecimal right = new BigDecimal(abmap.getRight());
//				BigDecimal total = new BigDecimal(abmap.getTotal());
//				BigDecimal value = right.divide(total,2,BigDecimal.ROUND_HALF_UP);
//				value = value.multiply(new BigDecimal(100));
//				ablityValue.add(value.intValue());
//			}
//		}
		
		Map<String,Object> resultMap = new HashMap<>();
		
		resultMap.put("list", list);
//		resultMap.put("listAblity", listAblity);
//		resultMap.put("ablityValue", ablityValue);
		
		return AsyncResponseData.getSuccess(resultMap);
	}
	
	class AblityMap{
		
		AblityMap(QuestionBankVO questionBankVO,UserAnswerVO userAnswerVO){
			this.ablityName = questionBankVO.getAblity();
			this.total = 0;
			this.right = 0;
			this.total += 1;
			if(questionBankVO.getAnswer().equals(userAnswerVO.getUserAnswer())) {
				this.right += 1;
			}
		}
		
		private String ablityName;
		private int right;
		private int total;
		
		public String getAblityName() {
			return ablityName;
		}
		public void setAblityName(String ablityName) {
			this.ablityName = ablityName;
		}
		public int getRight() {
			return right;
		}
		public void setRight(int right) {
			this.right = right;
		}
		public int getTotal() {
			return total;
		}
		public void setTotal(int total) {
			this.total = total;
		}
		
		
	}
	
}

