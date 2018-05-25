package com.jy.moudles.blackwhitelist.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.common.excelUtil.ExportExcel;
import com.jy.common.utils.UUIDUtil;
import com.jy.moudles.blackwhitelist.dao.BlackWhiteListDao;
import com.jy.moudles.blackwhitelist.entity.BlackWhiteList;
import com.jy.moudles.blackwhitelist.service.BlackWhiteListService;

/** 
 * blackWhiteList
 */
@Service
public class BlackWhiteListServiceImpl implements BlackWhiteListService {

	@Autowired
	private BlackWhiteListDao blackWhiteListdao;
	
	@Override
	public void insertBlackWhiteList(BlackWhiteList blackWhiteList){
		blackWhiteList.setId(UUIDUtil.get32UUID());
		blackWhiteListdao.insertBlackWhiteList(blackWhiteList);
	}
	
	@Override
	public void updateBlackWhiteList(BlackWhiteList blackWhiteList){
		blackWhiteListdao.updateBlackWhiteList(blackWhiteList);
	}
	
	@Override
	public BlackWhiteList getBlackWhiteListById(String id){
		return blackWhiteListdao.getBlackWhiteListById(id);
	}
	
	@Override
	public List<BlackWhiteList> queryBlackWhiteListsFilter(Map<String, Object> filter){
		return blackWhiteListdao.queryBlackWhiteListsFilter(filter);
	}
	
	@Override
	public void deleteBlackWhiteListById(String id){
		blackWhiteListdao.deleteBlackWhiteListById(id);
	}
	
	@Override
	public void deleteBlackWhiteLists(List<String> ids){
		Map<String, Object> map = new HashMap<String, Object>();  
	    map.put("ids", ids);  
		blackWhiteListdao.deleteBlackWhiteLists(map);
	}

	@Override
	public void getBlackWhiteLists(HttpServletResponse response, Map<String, Object> filter) {
		List<BlackWhiteList> blackWhiteList = blackWhiteListdao.queryBlackWhiteListsFilter(filter);
		ExportExcel ee = new ExportExcel("这是黑白名单列表的标题",BlackWhiteList.class);
		for(BlackWhiteList bw:blackWhiteList){
			if(bw.getFrequencyType() == 1){
				bw.setFrequencyTypeAlias("频点");
			}else if(bw.getFrequencyType() == 2){
				bw.setFrequencyTypeAlias("频段");
			}else{
				bw.setFrequencyTypeAlias("未知");
			}
			if(bw.getSource() == 1){
				bw.setSourceAlias("本地");
			}else if(bw.getSource() == 2){
				bw.setSourceAlias("平台");
			}else{
				bw.setSourceAlias("未知");
			}
			//类型--0：未知、1：黑名单、2：高可疑、3：中可疑、4：低可疑、5：白名单
			if(bw.getType() == 1){
				bw.setTypeAlias("黑名单");
			}
			if(bw.getType() == 2){
				bw.setTypeAlias("高可疑");
			}
			if(bw.getType() == 3){
				bw.setTypeAlias("中可疑");
			}
			if(bw.getType() == 4){
				bw.setTypeAlias("低可疑");
			}
			if(bw.getType() == 5){
				bw.setTypeAlias("白名单");
			}
			if(bw.getType() == 0){
				bw.setTypeAlias("未知");
			}
		}
		ee.setDataList(blackWhiteList);
		try {
			ee.write(response,"BlackWhiteList.xlsx" );
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteBWsByKafka(Map<String, Object> filter) {
		blackWhiteListdao.deleteBWsByKafka(filter);
	}

	@Override
	public void insertBlackWhiteListBatch(List<BlackWhiteList> blackWhiteList) {
		if (blackWhiteList != null && blackWhiteList.size() > 0) {
			blackWhiteListdao.insertBlackWhiteListBatch(blackWhiteList);
		}
	}
	
}

