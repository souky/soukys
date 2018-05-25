import java.util.List;


public class City {

	private String code;
	
	private String region;
	
	private List<City> regionEntitys;

	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code the code to set
	 */
	public void setCode(String code) {
		this.code = code; 
	}

	/**
	 * @return the region
	 */
	public String getRegion() {
		return region;
	}

	/**
	 * @param region the region to set
	 */
	public void setRegion(String region) {
		this.region = region;
	}

	/**
	 * @return the regionEntitys
	 */
	public List<City> getRegionEntitys() {
		return regionEntitys;
	}

	/**
	 * @param regionEntitys the regionEntitys to set
	 */
	public void setRegionEntitys(List<City> regionEntitys) {
		this.regionEntitys = regionEntitys;
	}
	
}
