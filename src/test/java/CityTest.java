import java.util.List;

import com.alibaba.fastjson.JSON;
import com.jy.common.utils.UUIDUtil;


public class CityTest {

	public static void main(String[] args) {
		String JsonContext = JsonUtil.ReadFile("c:/city.json");
		List<City> cities = JSON.parseArray(JsonContext,City.class);
		//System.out.println(cities.size());
		String sql1 = "INSERT INTO `jy_region_tab` (`id`, `region_code`, `region_name`, `region_p_id`, `region_level`, `region_order`) VALUES ('0', '000000', '中国', null, '1', '1');";
		System.out.println(sql1);
		//省
		for(int i = 0;i< cities.size();i++){
			City sheng = cities.get(i);
			String pid = "000000";
			String shengId = UUIDUtil.get32UUID();
			String sql2 = "INSERT INTO `jy_region_tab` (`id`, `region_code`, `region_name`, `region_p_id`, `region_level`, `region_order`) VALUES ('" + shengId + "','" + sheng.getCode() + "','" + sheng.getRegion() + "','" + pid + "','" + "2" + "','" + (i + 1) + "');";
			System.out.println(sql2);
			//市
			List<City> shis = sheng.getRegionEntitys();
			if(shis != null){
				for(int j = 0;j< shis.size();j++){
					City shi = shis.get(j);
					String shiId = UUIDUtil.get32UUID();
					String shiPid = sheng.getCode();
					String sql3 = "INSERT INTO `jy_region_tab` (`id`, `region_code`, `region_name`, `region_p_id`, `region_level`, `region_order`) VALUES ('" + shiId + "','" + shi.getCode() + "','" + shi.getRegion() + "','" + shiPid + "','" + "3" + "','" + (j + 1) + "');";
					System.out.println(sql3);
					//区县
					List<City> xians = shi.getRegionEntitys();
					if(xians != null){
						for (int k = 0; k < xians.size(); k++) {
							City xian = xians.get(k);
							String xianId = UUIDUtil.get32UUID();
							String xianPid = shi.getCode();
							String sql4 = "INSERT INTO `jy_region_tab` (`id`, `region_code`, `region_name`, `region_p_id`, `region_level`, `region_order`) VALUES ('" + xianId + "','" + xian.getCode() + "','" + xian.getRegion() + "','" + xianPid + "','" + "4" + "','" + (k + 1) + "');";
							System.out.println(sql4);
						}
					}
				}
				
			}
		}
	}

}
