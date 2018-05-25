import java.util.List;

import com.alibaba.fastjson.JSON;
import com.jy.common.utils.UUIDUtil;


public class OrganizationTest {

	public static void main(String[] args) {
		String JsonContext = JsonUtil.ReadFile("c:/city.json");
		List<City> cities = JSON.parseArray(JsonContext,City.class);
		//System.out.println(cities.size());
		String chinaId = UUIDUtil.get32UUID();
		String sql1 = "INSERT INTO `jy_organization_tab` (`id`, `code`, `name`, `parent_id`) VALUES ('" + chinaId + "', '000000', '中国', null);";
		System.out.println(sql1);
		//省
		for(int i = 0;i< cities.size();i++){
			City sheng = cities.get(i);
			String shengId = UUIDUtil.get32UUID();
			String sql2 = "INSERT INTO `jy_organization_tab` (`id`, `code`, `name`, `parent_id`) VALUES ('" + shengId + "','" + sheng.getCode() + "','" + sheng.getRegion() + "','" + chinaId + "');";
			System.out.println(sql2);
			//市
			List<City> shis = sheng.getRegionEntitys();
			if(shis != null){
				for(int j = 0;j< shis.size();j++){
					City shi = shis.get(j);
					String shiId = UUIDUtil.get32UUID();
					String sql3 = "INSERT INTO `jy_organization_tab` (`id`, `code`, `name`, `parent_id`) VALUES ('" + shiId + "','" + shi.getCode() + "','" + shi.getRegion() + "','" + shengId + "');";
					System.out.println(sql3);
					//区县
					List<City> xians = shi.getRegionEntitys();
					if(xians != null){
						for (int k = 0; k < xians.size(); k++) {
							City xian = xians.get(k);
							String xianId = UUIDUtil.get32UUID();
							String sql4 = "INSERT INTO `jy_organization_tab` (`id`, `code`, `name`, `parent_id`) VALUES ('" + xianId + "','" + xian.getCode() + "','" + xian.getRegion() + "','" + shiId + "');";
							System.out.println(sql4);
						}
					}
				}
				
			}
		}
	}

}
