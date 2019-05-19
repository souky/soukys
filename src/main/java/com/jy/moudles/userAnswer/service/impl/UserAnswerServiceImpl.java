package com.jy.moudles.userAnswer.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.jsonadpter.AsyncResponseData;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.questionBank.VO.QuestionBankVO;
import com.jy.moudles.userAnswer.VO.AblityVO;
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
		// ablity map
		Map<String,AblityMap> map_ablity = new HashMap<>();
		
		// ablity list
		List<AblityVO> listAblity = new ArrayList<>();
		
		// ablity value
		List<Integer> ablityValue = new ArrayList<>();
		
		Map<String,Integer> selfMaps = new HashMap<>();
		selfMaps.put("A",1);
		selfMaps.put("B",2);
		selfMaps.put("C",3);
		selfMaps.put("D",4);
		selfMaps.put("E",5);
		
		Map<String,Integer> selfMap_rever = new HashMap<>();
		selfMap_rever.put("A",5);
		selfMap_rever.put("B",4);
		selfMap_rever.put("C",3);
		selfMap_rever.put("D",2);
		selfMap_rever.put("E",1);
		
		// 处理能力值
		if(null != list && list.size() > 0) {
			for(UserAnswerVO u : list) {
				
				QuestionBankVO questionBankVO = u.getQuestionBankVO();
				
				String[] ablity = questionBankVO.getAblity().split(",");
				
				for(String s : ablity) {
					AblityMap ablityMap = map_ablity.get(s);
					if(null == ablityMap) {
						ablityMap = new AblityMap();
					}
					// 总分值加入
					ablityMap.addMax(questionBankVO.getScore());
					
					// 分值加入
					if(questionBankVO.getType() == 1) {
						if(questionBankVO.getAnswer().equals(u.getUserAnswer())) {
							ablityMap.addValue(questionBankVO.getScore());
						}
					}
					
					if(questionBankVO.getType() == 2) {
						if(!questionBankVO.getAnswer().equals("")) {
							ablityMap.addValue(questionBankVO.getScore());
						}
					}
					
					if(questionBankVO.getType() == 3 && StringUtils.isNotBlank(u.getUserAnswer())) {
						Integer i = 0;
						if(questionBankVO.getRevers() == 1) {
							i = selfMap_rever.get(u.getUserAnswer());
						}else {
							i = selfMaps.get(u.getUserAnswer());
						}
						if(null != i) {
							ablityMap.addValue(i);
						}
					}
					
					map_ablity.put(s,ablityMap);
				}
				
			}
			
			// 处理map
			for(Map.Entry<String, AblityMap> e : map_ablity.entrySet()) {
				AblityVO ablityVO = new AblityVO();
				ablityVO.setText(e.getKey());
				ablityVO.setMax(e.getValue().getMax());
				listAblity.add(ablityVO);
				ablityValue.add(e.getValue().getValue());
			}
		}
		
		Map<String,Object> resultMap = new HashMap<>();
		
		resultMap.put("list", list);
		resultMap.put("listAblity", listAblity);
		resultMap.put("ablityValue", ablityValue);
		
		return AsyncResponseData.getSuccess(resultMap);
	}
	
	class AblityMap{
		
		
		
		private String ablityName;
		private int max;
		private int value;
		
		public void addValue(int value) {
			this.value += value;
		}
		public void addMax(int max) {
			this.max += max;
		}
		
		public String getAblityName() {
			return ablityName;
		}
		public void setAblityName(String ablityName) {
			this.ablityName = ablityName;
		}
		public int getMax() {
			return max;
		}
		public void setMax(int max) {
			this.max = max;
		}
		public int getValue() {
			return value;
		}
		public void setValue(int value) {
			this.value = value;
		}
		
		
		
	}
	
}

